fn main() {
	println!("
	cargo:rustc-link-arg=-Wl,-T,/usr/local/rust/elf64-std.ld
	cargo:rustc-link-arg=-no-pie");
}
