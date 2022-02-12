// code for printing library goes here

#pragma once

#include <stdint.h>
#include <stddef.h>

enum {
    black = 0,
	blue = 1,
	green = 2,
	red = 4,
	pink = 13,
	yellow = 14,
	white = 15,
};

void clear();
void printfC(char character);
void printf(char* string);
void str_color(uint8_t foreground, uint8_t background);
void idt_init();
void kb_init(void);


