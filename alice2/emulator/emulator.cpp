#include <cstdio>
#include <cstdlib>
#include <unistd.h>
#include <map>
#include <sys/socket.h>
#include <fcntl.h>

#include "emulator.h"
#include <rfb/keysym.h>

#include "z80emu.h"
#include "8x16.h"

const bool debug = false;

bool Z80_INTERRUPT_FETCH = false;
unsigned short Z80_INTERRUPT_FETCH_DATA;

std::vector<board_base*> boards;

// 14 offset from left, 9 offset from right
const int video_board_width = 176;
const int video_board_height = 262;
const int video_board_hsync_columns = 14;
const int video_board_vsync_rows = 9;

const int video_rfb_scale_x = 3;
const int video_rfb_scale_y = 2;

const int font_scale = 2;
const int lcd_rows = 2;
const int lcd_columns = 16;
const int lcd_chars_height = lcd_rows * (fontheight + 1) * font_scale;

uint32_t rfb_pixel(int  r, int g, int b)
{
    return (r << 16) | (g << 8) | (b);
}

void draw_glyph(rfbScreenInfoPtr server, int x, int y, char c)
{
    int    gx, gy;
    unsigned char    *glyph;

    glyph = fontbits + fontheight * c;
    for(gx = 0; gx < fontwidth + 1; gx++)
        for(gy = 0; gy < fontheight + 1; gy++) {
            int v;
            if(gx < fontwidth && gy < fontheight && (glyph[gy + gx / 8] & (1 << (7 - (gx % 8)))))
                v = 32;
            else
                v = 224;
            for(int j = 0; j < font_scale; j++)
                for(int i = 0; i < font_scale; i++) {
                int col = x + i + gx * font_scale;
                int row = y + j + gy * font_scale;
                rfbDrawPixel(server, col, row, rfb_pixel(v, v, v));
            }
        }
        rfbMarkRectAsModified(server, x, y, x + fontwidth * 2 + 1, y + fontheight * 2 + 1);

}

bool quit = false;

// -- GENERATED BY KEYS.PY

std::map<int, unsigned char> rfb_keys_to_AT_keycodes;

void populate_keycode_map()
{

    rfb_keys_to_AT_keycodes[XK_Shift_L] = 0x12;
    rfb_keys_to_AT_keycodes[XK_Shift_R] = 0x59;
    rfb_keys_to_AT_keycodes[XK_Tab] = 0x0D;
    rfb_keys_to_AT_keycodes[XK_grave] = 0x0E;
    rfb_keys_to_AT_keycodes[XK_asciitilde] = 0x0E;
    rfb_keys_to_AT_keycodes[XK_q] = 0x15;
    rfb_keys_to_AT_keycodes[XK_Q] = 0x15;
    rfb_keys_to_AT_keycodes[XK_1] = 0x16;
    rfb_keys_to_AT_keycodes[XK_exclam] = 0x16;
    rfb_keys_to_AT_keycodes[XK_z] = 0x1A;
    rfb_keys_to_AT_keycodes[XK_Z] = 0x1A;
    rfb_keys_to_AT_keycodes[XK_s] = 0x1B;
    rfb_keys_to_AT_keycodes[XK_S] = 0x1B;
    rfb_keys_to_AT_keycodes[XK_a] = 0x1C;
    rfb_keys_to_AT_keycodes[XK_A] = 0x1C;
    rfb_keys_to_AT_keycodes[XK_w] = 0x1D;
    rfb_keys_to_AT_keycodes[XK_W] = 0x1D;
    rfb_keys_to_AT_keycodes[XK_2] = 0x1E;
    rfb_keys_to_AT_keycodes[XK_at] = 0x1E;
    rfb_keys_to_AT_keycodes[XK_c] = 0x21;
    rfb_keys_to_AT_keycodes[XK_C] = 0x21;
    rfb_keys_to_AT_keycodes[XK_x] = 0x22;
    rfb_keys_to_AT_keycodes[XK_X] = 0x22;
    rfb_keys_to_AT_keycodes[XK_d] = 0x23;
    rfb_keys_to_AT_keycodes[XK_D] = 0x23;
    rfb_keys_to_AT_keycodes[XK_e] = 0x24;
    rfb_keys_to_AT_keycodes[XK_E] = 0x24;
    rfb_keys_to_AT_keycodes[XK_4] = 0x25;
    rfb_keys_to_AT_keycodes[XK_dollar] = 0x25;
    rfb_keys_to_AT_keycodes[XK_3] = 0x26;
    rfb_keys_to_AT_keycodes[XK_numbersign] = 0x26;
    rfb_keys_to_AT_keycodes[XK_v] = 0x2A;
    rfb_keys_to_AT_keycodes[XK_V] = 0x2A;
    rfb_keys_to_AT_keycodes[XK_f] = 0x2B;
    rfb_keys_to_AT_keycodes[XK_F] = 0x2B;
    rfb_keys_to_AT_keycodes[XK_t] = 0x2C;
    rfb_keys_to_AT_keycodes[XK_T] = 0x2C;
    rfb_keys_to_AT_keycodes[XK_r] = 0x2D;
    rfb_keys_to_AT_keycodes[XK_R] = 0x2D;
    rfb_keys_to_AT_keycodes[XK_5] = 0x2E;
    rfb_keys_to_AT_keycodes[XK_percent] = 0x2E;
    rfb_keys_to_AT_keycodes[XK_n] = 0x31;
    rfb_keys_to_AT_keycodes[XK_N] = 0x31;
    rfb_keys_to_AT_keycodes[XK_b] = 0x32;
    rfb_keys_to_AT_keycodes[XK_B] = 0x32;
    rfb_keys_to_AT_keycodes[XK_h] = 0x33;
    rfb_keys_to_AT_keycodes[XK_H] = 0x33;
    rfb_keys_to_AT_keycodes[XK_g] = 0x34;
    rfb_keys_to_AT_keycodes[XK_G] = 0x34;
    rfb_keys_to_AT_keycodes[XK_y] = 0x35;
    rfb_keys_to_AT_keycodes[XK_Y] = 0x35;
    rfb_keys_to_AT_keycodes[XK_6] = 0x36;
    rfb_keys_to_AT_keycodes[XK_asciicircum] = 0x36;
    rfb_keys_to_AT_keycodes[XK_m] = 0x3A;
    rfb_keys_to_AT_keycodes[XK_M] = 0x3A;
    rfb_keys_to_AT_keycodes[XK_j] = 0x3B;
    rfb_keys_to_AT_keycodes[XK_J] = 0x3B;
    rfb_keys_to_AT_keycodes[XK_u] = 0x3C;
    rfb_keys_to_AT_keycodes[XK_U] = 0x3C;
    rfb_keys_to_AT_keycodes[XK_7] = 0x3D;
    rfb_keys_to_AT_keycodes[XK_ampersand] = 0x3D;
    rfb_keys_to_AT_keycodes[XK_8] = 0x3E;
    rfb_keys_to_AT_keycodes[XK_asterisk] = 0x3E;
    rfb_keys_to_AT_keycodes[XK_comma] = 0x41;
    rfb_keys_to_AT_keycodes[XK_less] = 0x41;
    rfb_keys_to_AT_keycodes[XK_k] = 0x42;
    rfb_keys_to_AT_keycodes[XK_K] = 0x42;
    rfb_keys_to_AT_keycodes[XK_i] = 0x43;
    rfb_keys_to_AT_keycodes[XK_I] = 0x43;
    rfb_keys_to_AT_keycodes[XK_o] = 0x44;
    rfb_keys_to_AT_keycodes[XK_O] = 0x44;
    rfb_keys_to_AT_keycodes[XK_0] = 0x45;
    rfb_keys_to_AT_keycodes[XK_parenright] = 0x45;
    rfb_keys_to_AT_keycodes[XK_9] = 0x46;
    rfb_keys_to_AT_keycodes[XK_parenleft] = 0x46;
    rfb_keys_to_AT_keycodes[XK_period] = 0x49;
    rfb_keys_to_AT_keycodes[XK_greater] = 0x49;
    rfb_keys_to_AT_keycodes[XK_slash] = 0x4A;
    rfb_keys_to_AT_keycodes[XK_question] = 0x4A;
    rfb_keys_to_AT_keycodes[XK_l] = 0x4B;
    rfb_keys_to_AT_keycodes[XK_L] = 0x4B;
    rfb_keys_to_AT_keycodes[XK_semicolon] = 0x4C;
    rfb_keys_to_AT_keycodes[XK_colon] = 0x4C;
    rfb_keys_to_AT_keycodes[XK_p] = 0x4D;
    rfb_keys_to_AT_keycodes[XK_P] = 0x4D;
    rfb_keys_to_AT_keycodes[XK_minus] = 0x4E;
    rfb_keys_to_AT_keycodes[XK_underscore] = 0x4E;
    rfb_keys_to_AT_keycodes[XK_apostrophe] = 0x52;
    rfb_keys_to_AT_keycodes[XK_quotedbl] = 0x52;
    rfb_keys_to_AT_keycodes[XK_bracketleft] = 0x54;
    rfb_keys_to_AT_keycodes[XK_braceleft] = 0x54;
    rfb_keys_to_AT_keycodes[XK_equal] = 0x55;
    rfb_keys_to_AT_keycodes[XK_plus] = 0x55;
    rfb_keys_to_AT_keycodes[XK_Return] = 0x5A;
    rfb_keys_to_AT_keycodes[XK_bracketright] = 0x5B;
    rfb_keys_to_AT_keycodes[XK_braceright] = 0x5B;
    rfb_keys_to_AT_keycodes[XK_backslash] = 0x5D;
    rfb_keys_to_AT_keycodes[XK_bar] = 0x5D;
    rfb_keys_to_AT_keycodes[XK_BackSpace] = 0x66;
    rfb_keys_to_AT_keycodes[XK_Escape] = 0x76;
}
// -- END GENERATED BY KEYS.PY

struct IOboard : board_base
{
    const int PIC_port = 0x04;
    const int CMD_SER = 0x01;
    const int CMD_KBD = 0x02;
    const int CMD_TIM = 0x03;
    std::vector<unsigned char> queue;

    enum { NONE, PENDING, SIGNALED } interrupt_status;

    IOboard() :
        interrupt_status(NONE)
    { }

    virtual bool io_read(int addr, unsigned char &data)
    {
        if(addr == PIC_port) {
            bool handled = false;
            if(queue.size() > 0) {
                data = queue[0];
                queue.erase(queue.begin());
                handled = true;
            }
            if(queue.size() > 0)
                interrupt_status = PENDING;
            else {
                interrupt_status = NONE;
            }
            return handled;
        }
        return false;
    }

    virtual bool board_get_interrupt(int& irq)
    {
        if(interrupt_status == PENDING) {
            irq = 0;
            interrupt_status = SIGNALED;
            return true;
        }
        return false;
    }
    
    void enqueue(unsigned char b)
    {
        queue.push_back(b);
        if(interrupt_status == NONE)
            interrupt_status = PENDING;
    }

    void enqueue_AT_keycode(unsigned char key)
    {
        enqueue(CMD_KBD);
        enqueue(key);
    }

    virtual bool handle_rfb_key(rfbBool down, rfbKeySym key, rfbClientPtr cl)
    {
        if(down) {
            if(key==XK_Escape) {
                rfbCloseClient(cl);
                quit = true;
            } else if(key==XK_F12) {
                /* close down server, disconnecting clients */
                rfbShutdownServer(cl->screen,TRUE);
                quit = true;
            } else if(key==XK_F11) {
                /* close down server, but wait for all clients to disconnect */
                rfbShutdownServer(cl->screen,FALSE);
                quit = true;
            } else if(key==XK_F11) {
                /* close down server, but wait for all clients to disconnect */
                rfbShutdownServer(cl->screen,FALSE);
                quit = true;
            } else {
                auto found = rfb_keys_to_AT_keycodes.find(key);
                if(found != rfb_keys_to_AT_keycodes.end()){
                    unsigned char kc = found->second;
                    enqueue_AT_keycode(kc);
                }
            }
        } else {
            auto found = rfb_keys_to_AT_keycodes.find(key);
            if(found != rfb_keys_to_AT_keycodes.end()){
                unsigned char kc = found->second;
                enqueue_AT_keycode(0xF0);
                enqueue_AT_keycode(kc);
            }
        }
        return true;
    }

    int listen_sock;
    const int server_port = 6606;
    void init(void)
    {
        printf("listening on port 6606 for serial port emulation\n");

        listen_sock = socket(PF_INET, SOCK_STREAM, 0);
        if(listen_sock < 0) {
            perror("socket");
            exit(EXIT_FAILURE);
        }
        fcntl(listen_sock, F_SETFL, O_NONBLOCK);

        int reuse = 1;
        if(setsockopt(listen_sock, SOL_SOCKET, SO_REUSEADDR, &reuse, sizeof(reuse)) == -1) {
            perror("setsockopt");
            exit(EXIT_FAILURE);
        }

        struct in_addr addr;
        struct sockaddr_in socket_addr;
        socket_addr.sin_family = AF_INET; // AF_UNIX;
        socket_addr.sin_port = htons(server_port);
        addr.s_addr = 0;
        socket_addr.sin_addr = addr;

        if(bind(listen_sock, (struct sockaddr*)&socket_addr, sizeof(socket_addr)) != 0) {
            perror("bind");
            exit(EXIT_FAILURE);
        }

	if(listen(listen_sock, 1) != 0) {
	    perror("listen");
	    exit(EXIT_FAILURE);
	}
    }

    int data_sock = -1;

    void idle()
    {
        if(data_sock > -1) {
            fd_set fds;
            FD_ZERO(&fds);
            FD_SET(data_sock, &fds);

            struct timeval timeout;
            timeout.tv_sec = 0;
            timeout.tv_usec = 1;
            if(select(data_sock + 1, &fds, NULL, NULL, &timeout) == -1) {
                perror("select");
                exit(EXIT_FAILURE);
            }

            static unsigned char buffer[128];
            if(FD_ISSET(data_sock, &fds)) {
                ssize_t count;
                count = recv(data_sock, buffer, sizeof(buffer), 0);
                if(count < 0) {
                    perror("recv");
                    exit(EXIT_FAILURE);
                } else if(count == 0) {
                    close(data_sock);
                    data_sock = -1;
                } else {
                    for(int i = 0; i < count; i++) {
                        enqueue(CMD_SER);
                        enqueue(buffer[i]);
                    }
                }
            }
        }

        if(data_sock == -1) {
            fd_set fds;
            FD_ZERO(&fds);
            FD_SET(listen_sock, &fds);

            struct timeval timeout;
            timeout.tv_sec = 0;
            timeout.tv_usec = 1;
            if(select(listen_sock + 1, &fds, NULL, NULL, &timeout) == -1) {
                perror("select");
                exit(EXIT_FAILURE);
            }

            if(FD_ISSET(listen_sock, &fds)) {
                struct sockaddr_in them;
                socklen_t addrlen = sizeof(them);
                data_sock = accept(listen_sock, (struct sockaddr *)&them, &addrlen);
                if(data_sock < 0)
                {
                    perror("accept");
                    exit(1);
                }

            }
        }
    }
};

struct PIC8259board : board_base
{
    const int PORT0 = 0x00;
    const int PORT1 = 0x01;
    virtual bool io_write(int addr, unsigned char data)
    {
        if(addr == PORT0) {
            return true;
        }
        if(addr == PORT1) {
            return true;
        }
        return false;
    }
};

struct ROMboard : board_base
{
    unsigned char rom_bytes[16384];
    int base_addr;
    ROMboard(unsigned char b[16384]) 
    {
        memcpy(rom_bytes, b, sizeof(rom_bytes));
        base_addr = 0x0000;
    }
    virtual bool memory_read(int addr, unsigned char &data)
    {
        if(addr >= base_addr && addr < base_addr + sizeof(rom_bytes)) {
            data = rom_bytes[addr - base_addr];
            if(debug) printf("read 0x%04X -> 0x%02X from ROM\n", addr, data);
            return true;
        }
        return false;
    }
};

struct VIDEOboard : board_base
{
    unsigned char fb_bytes[16384];
    int base_addr;

    rfbScreenInfoPtr rfb_server;
    int rfb_offset_x, rfb_offset_y;

    bool get_rfb_requirements(int& w, int& h)
    {
        w = video_board_width * video_rfb_scale_x;
        h = video_board_height * video_rfb_scale_y;
        return true;
    }
    void set_rfb(rfbScreenInfoPtr server, int offset_x, int offset_y)
    {
        rfb_server = server;
        rfb_offset_x = offset_x;
        rfb_offset_y = offset_y;
    }

    VIDEOboard()
    {
        base_addr = 0x4000;
        memset(fb_bytes, 0, sizeof(fb_bytes));
    }
    void init(void)
    {
        // make some nice RAM noise
        for(int i = 0 ; i < sizeof(fb_bytes); i++)
            memory_write(base_addr + i, random());
    }
    virtual bool memory_read(int addr, unsigned char &data)
    {
        if(addr >= base_addr && addr < base_addr + sizeof(fb_bytes)) {
            data = fb_bytes[addr - base_addr];
            if(debug) printf("read 0x%04X -> 0x%02X from VIDEO\n", addr, data);
            return true;
        }
        return false;
    }

    void set_video_pixel_in_rfb(int video_x, int video_y, bool set)
    {
        int rfb_x = video_x * video_rfb_scale_x + rfb_offset_x;
        int rfb_y = video_y * video_rfb_scale_y + rfb_offset_y;
        int v = set ? 255 : 0;

        for(int j = 0; j < video_rfb_scale_y; j++)
            for(int i = 0; i < video_rfb_scale_x; i++) {
                rfbDrawPixel(rfb_server, rfb_x + i, rfb_y + j, rfb_pixel(v, v, v));
            }
    }

    virtual bool memory_write(int addr, unsigned char data)
    {
        if(addr >= base_addr && addr < base_addr + sizeof(fb_bytes)) {
            fb_bytes[addr - base_addr] = data;
            if(debug) printf("wrote 0x%02X to VIDEO 0x%04X\n", data, addr);

            int pixel_start = (addr - base_addr) * 8;
            int pixel_row = pixel_start / video_board_width;
            if(pixel_row < video_board_height) {
                int pixel_column_start = pixel_start - (pixel_row * video_board_width);
                for(int i = 0; i < 8; i++) {
                    set_video_pixel_in_rfb(pixel_column_start + i, pixel_row, data & (0x80 >> i));
                }
            }

            return true;
        }
        return false;
    }
};

struct RAMboard : board_base
{
    unsigned char ram_bytes[32768];
    int base_addr;
    RAMboard() 
    {
        memset(ram_bytes, 0, sizeof(ram_bytes));
        base_addr = 0x8000;
    }
    virtual bool memory_read(int addr, unsigned char &data)
    {
        if(addr >= base_addr && addr < base_addr + sizeof(ram_bytes)) {
            data = ram_bytes[addr - base_addr];
            if(debug) printf("read 0x%04X -> 0x%02X from RAM\n", addr, data);
            return true;
        }
        return false;
    }
    virtual bool memory_write(int addr, unsigned char data)
    {
        if(addr >= base_addr && addr < base_addr + sizeof(ram_bytes)) {
            ram_bytes[addr - base_addr] = data;
            if(debug) printf("wrote 0x%02X to RAM 0x%04X\n", data, addr);
            return true;
        }
        return false;
    }
};

const int LCLEAR = 0x01; // LCD clear instruction
const int LRESET = 0x38; // LCD reset to normal instruction
const int LHALF1 = 0x80; // LCD move cursor to row 0
const int LHALF2 = 0xc0; // LCD move cursor to row 1

struct LCDboard : board_base
{
    const int LCDINST = 0x2; //  LCD instruction I/O port
    const int LCDDATA = 0x3; // LCD data I/O port
    const bool use_special_alice2_clear = true;

    unsigned char lcd[lcd_rows * lcd_columns];
    int cursor;
    rfbScreenInfoPtr rfb_server;

    int rfb_offset_x, rfb_offset_y;

    bool get_rfb_requirements(int& w, int& h)
    {
        w = lcd_columns * (fontwidth + 1) * font_scale;
        h = (fontheight + 1) * lcd_rows * font_scale;
        return true;
    }
    void set_rfb(rfbScreenInfoPtr server, int offset_x, int offset_y)
    {
        rfb_server = server;
        rfb_offset_x = offset_x;
        rfb_offset_y = offset_y;
    }

    LCDboard()
    {
        cursor = 0;
        memset(lcd, ' ', sizeof(lcd));
    }

    void init(void)
    {
        for(int i = 0; i < lcd_rows * lcd_columns; i++)
            draw_lcd_character(i);
    }

    virtual bool io_write(int addr, unsigned char data)
    {
        if(addr == LCDINST) {
            if(debug) printf("LCD instruction byte: 0x%02X\n", data);
            switch(data) {
                case LCLEAR: {
                    if(use_special_alice2_clear) {
                        static bool receivedFirstClear = false;
                        if(!receivedFirstClear) {
                            receivedFirstClear = true;
                            printf("using HOME instead of LCD CLEAR instruction\n");
                            printf("    (it seems we don't use CLEAR correctly)\n");
                        }
                        memset(lcd + cursor, ' ', sizeof(lcd) - cursor);
                        for(int i = 0; i < lcd_rows * lcd_columns; i++)
                            draw_lcd_character(i);
                        cursor = 0;
                    } else {
                        cursor = 0;
                        memset(lcd, ' ', sizeof(lcd));
                        for(int i = 0; i < lcd_rows * lcd_columns; i++)
                            draw_lcd_character(i);
                    }
                    break;
                }
                case LRESET:
                    cursor = 0;
                    break;
                case LHALF1:
                    cursor = 0;
                    break;
                case LHALF2:
                    cursor = lcd_rows;
                    break;
            }
            return true;
        }
        if(addr == LCDDATA) {
            if(debug)
                printf("LCD data byte: 0x%02X (%c)\n", data, data);

            lcd[cursor] = data;
            if(cursor < lcd_columns * lcd_rows)
                draw_lcd_character(cursor);
            cursor ++;

            return true;
        }
        return false;
    }

    void draw_lcd_character(int which)
    {
        int y = which / lcd_columns;
        int x = which - y * lcd_columns;
        int c = lcd[which];
        draw_glyph(rfb_server, 
            rfb_offset_x + (fontwidth + 1) * font_scale * x,
            rfb_offset_y + (fontheight + 1) * font_scale * y,
            c);
    }
};

static void handleKey(rfbBool down, rfbKeySym key, rfbClientPtr cl)
{
    for(auto b = boards.begin(); b != boards.end(); b++)
        if((*b)->handle_rfb_key(down, key, cl))
            break;
}

int main(int argc, char **argv)
{
    if(argc < 2) {
        fprintf(stderr, "%s rom.bin\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    FILE *fp = fopen(argv[1], "rb");
    if(fp == NULL) {
        fprintf(stderr, "failed to open %s for reading\n", argv[1]);
        exit(EXIT_FAILURE);
    }
    unsigned char b[16384];
    size_t length = fread(b, 1, sizeof(b), fp);
    if(length < 16384) {
        fprintf(stderr, "ROM read from %s was unexpectedly short (%zd bytes)\n", argv[1], length);
        exit(EXIT_FAILURE);
    }
    fclose(fp);

    populate_keycode_map();

    boards.push_back(new PIC8259board());
    boards.push_back(new ROMboard(b));
    boards.push_back(new RAMboard());
    boards.push_back(new VIDEOboard());
    boards.push_back(new LCDboard());
    boards.push_back(new IOboard());

    const int border_width = 4;
    const int border_height = 4;

    int need_width = border_width * 2;
    int need_height = border_height;

    for(auto b = boards.begin(); b != boards.end(); b++) {
        int w, h;
        if((*b)->get_rfb_requirements(w, h)) {
            need_width = std::max(need_width, w + border_width * 2);
            need_height += h + border_height;
        }
    }

    rfbScreenInfoPtr server = rfbGetScreen(&argc,argv,need_width,need_height,8,3,4);
    unsigned char* rfb_bytes = new unsigned char[need_width*need_height*4];
    server->frameBuffer = (char *)rfb_bytes;
    server->kbdAddEvent = handleKey;

    int y_offset = border_height;
    for(auto b = boards.begin(); b != boards.end(); b++) {
        int w, h;
        if((*b)->get_rfb_requirements(w, h)) {
            (*b)->set_rfb(server, (need_width - w) / 2, y_offset);
            y_offset += h + border_height;
        }
    }

    for(auto b = boards.begin(); b != boards.end(); b++) {
        (*b)->init();
    }

    Z80_STATE state;

    Z80Reset(&state);

    rfbInitServer(server);
    rfbProcessEvents(server, 1000);

    int prevcycles = 0, cycles;
    while(!quit && (cycles = Z80Emulate(&state, 10000)) > 0)
    {
        if(prevcycles / 10000 != (prevcycles + cycles) / 10000) {
            if(debug)printf("emulated %d cycles\n", cycles);
            prevcycles += cycles;
        }
        rfbProcessEvents(server, 1000);

        for(auto b = boards.begin(); b != boards.end(); b++) {
            int irq;
            if((*b)->board_get_interrupt(irq)) {
                // Pretend to be 8259 configured for Alice2:
                Z80_INTERRUPT_FETCH = true;
                Z80_INTERRUPT_FETCH_DATA = 0x3f00 + irq * 4;
                Z80Interrupt(&state, 0xCD);
                break;
            }
        }
        for(auto b = boards.begin(); b != boards.end(); b++) {
            (*b)->idle();
        }
    }


    return(0);
}

