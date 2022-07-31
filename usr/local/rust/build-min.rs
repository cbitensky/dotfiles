fn main() {
	println!("
	cargo:rustc-link-arg=-Wl,-T,elf64-min.ld
	cargo:rustc-link-arg=-nostartfiles
	cargo:rustc-link-arg=-no-pie");
}
