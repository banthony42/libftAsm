%ifdef OSX
%define MACH_SYSCALL(nb)	0x2000000 | nb
%define STDOUT				1
%define READ				3
%define WRITE				4
%endif

%ifdef LINUX
%define MACH_SYSCALL(nb)	nb
%define READ				0
%define WRITE				1
%endif
