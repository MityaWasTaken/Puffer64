# PufferOS_system_kernel
System Kernel for PufferOS with support for the C programming lanugage. repo comes with the iso file and object files incase there is an error or bug.
Speaking of errors or bugs. There is currently a triple fault exception for the input driver. In order to avoid this issue. You can just comment out `idt_init();` in `kernel.c`. That should fix the error. But in turn, the os will lose all dynamic functionality. So no matter if the input driver is perfect. Not including that function will also prevent it from working.
