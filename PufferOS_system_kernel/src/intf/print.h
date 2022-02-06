#pragma once
#include <stdint.h>
#include <stddef.h>


enum {
    black = 0,
	blue = 1,
	green = 2,
	cyan = 3,
	red = 4,
	magenta = 5,
	light_gray = 7,
	dark_gray = 8,
	pink = 13,
	yellow = 14,
	white = 15,
};

void clear();
void printC(char character);
void printf(char* str);
void nl();
void str_color(uint8_t foreground, uint8_t background);