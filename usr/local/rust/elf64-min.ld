OUTPUT_FORMAT("elf64-x86-64")
ENTRY(_start)
PHDRS {
	text PT_LOAD FILEHDR PHDRS;
	/*tls PT_TLS;*/
	interp PT_INTERP;
	dynamic PT_DYNAMIC;
}

SECTIONS
{
	. = SIZEOF_HEADERS;
	t : {
		KEEP (*(.init))
		*(.text*)
		KEEP (*(.fini))
		*(.rodata*)
		*(.data*)
		*(.bss*)
	} :text
	.init_array : {
		PROVIDE_HIDDEN (__init_array_start = .);
		KEEP (*(SORT_BY_INIT_PRIORITY(.init_array*)))
		PROVIDE_HIDDEN (__init_array_end = .);
	} :text
	.rel : { *(.data.rel*) } :text

	td : { *(.tdata*) } :text :tls
	tb : { *(.tbss*) } :text :tls

	i : {
		*(.interp)
	} :text :interp

	d : {
		*(.dynamic)
		*(.got)
		*(.got.*)
		*(.gnu.*)
		*(.dynsym)
	} :dynamic :text

	/DISCARD/ : { *(.note*) }
}
