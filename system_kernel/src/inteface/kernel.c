// // #include "std.h"
// // void main(){
// //     clear();
// //     printf("PufferOS Kernel with C compatability");
// //     nl(); nl();
// //     idt_init();
// //     kb_init();
// // }

#include "std.h"
void main() {
    clear();
    printf("hello");
    idt_init();
	kb_init();
}


