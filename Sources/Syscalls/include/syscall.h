#import <unistd.h>

#ifdef __thumb__
#define syscall(x)   asm volatile("swi\t"#x ::: "r0", "r1", "r2", "r3")
#else
#define syscall(x)   asm volatile("swi\t"#x"<<16" ::: "r0", "r1", "r2", "r3")
#endif

static inline void wait_for_vblank(void) {
	syscall(0x05);
}

static inline uint16_t sqrt_u32(uint32_t value) {
	register uint32_t r0 asm("r0") = value;
	asm volatile(
		"swi 0x060000\n"
		: "+r" (r0)
		: "r" (r0)
		: "r1", "r2", "r3"
	);
	return r0;
}