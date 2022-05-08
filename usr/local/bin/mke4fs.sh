#!/bin/sh -e
echo y | mke2fs -t ext4 -b 4096 -i 16384 -G 32 -m 0 -E num_backup_sb=0 -O ^64bit,^bigalloc,dir_index,^dir_nlink,^encrypt,^ext_attr,extent,^extra_isize,filetype,flex_bg,^has_journal,^huge_file,^inline_data,large_file,^meta_bg,^metadata_csum,^mmp,^project,^quota,^resize_inode,^sparse_super,sparse_super2,^uninit_bg "$1"
#uninit_bg!

tune2fs -o ^acl,^user_xattr -E mount_opts=lazytime "$1"
#