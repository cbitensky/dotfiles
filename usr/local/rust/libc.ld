ENTRY(_start)
PHDRS {
	text PT_LOAD FILEHDR PHDRS;
	interp PT_INTERP;
	dynamic PT_DYNAMIC;
}

SECTIONS {
	. = SIZEOF_HEADERS;

	t : {
		KEEP (*(.init))
		*(.text*)
		KEEP (*(.fini))
		*(.rodata*)
		*(.data*)
		PROVIDE_HIDDEN (__init_array_start = .);
		PROVIDE_HIDDEN (__init_array_end = .);
	} :text

	b : {
		*(.bss*)
	} :text

	i : {
		*(.interp)
	} :interp

	d : {
		*(.dynamic)
		*(.got)
		*(.got.*)
		*(.gnu.*)
		*(.dynsym)
	} :dynamic

	/DISCARD/ : {
		*(.comment)
		*(.note.*)
	}
}
