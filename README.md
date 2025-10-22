# dotfiles
> I use Alpine Linux both on Window WSL and bare metal

This is what I am working on right now and it's great!  

## Philosophy
* My toolset must be a small selection of quality tools, each serving a distinct purpose,  
  so I can master all of them over time.
* Limiting that building fatigue while working and lowering overhead is a priority and dictates  
  the selection of these tools.
* Pragmatism, minimalism and modernity(when sensible). I will use what works to get to my goals  
  and I won't adopt something just because it's new and shiny!
* Keeping things as default as possible to limit time wasted configuring things, but I will  
  update stuff now and then if worth it.
* I must be able to use my most important tools over SSH without any issues.

## My awesome toolset
* kernel: linux
* package manager: apk
* userland: busybox
* archiver: atool
* transfer: curl
* hashing/encryption: openssl
* editors: vi and helix
* multiplexer: tmux
* modernity: fd, rg, sk and jq
* shell: zsh
* langs: each takes 6 months to 2 years minimum to truly understand
  * ash(shell scripting)
  * awk(pattern scanning and processing)
  * asm/c(systems programming, clang/llvm toolchain with lldb and make)
  * go(cloud work)
  * node(webdev)
  * elixir(functional)
  * sqlite(local database)
  * typst(typesetting)
* hacking: strace, ltrace and rizin
* vcs: git(with github-cli)
* remote: openssh, rsync and rclone
* mobile: adb, fastboot and scrcpy
* containers: docker and kubernetes
* infrastructure: aws, azure, tencent, terraform and polumi
* init: openrc
* libc: musl

Use [manned.org](https://manned.org/) to access manual pages.

## Installation
* On [Windows WSL](./wsl/WSL.md)
* On [bare metal](./metal/METAL.md)

## Authoritative documentation links
* [Alpine Linux](https://alpinelinux.org)
* [Linux](https://www.kernel.org)
* [Busybox](https://busybox.net)
* [Curl](https://curl.se)
* [Helix](https://helix-editor.com)
* [Tmux](https://tmux.github.io)
* [LLVM](https://llvm.org)
* [GNU Make](https://www.gnu.org/software/make)
* [Go](https://go.dev)
* [JavaScript](https://tc39.es)
* [TypeScript](https://www.typescriptlang.org)
* [NodeJS](https://nodejs.org)
* [Elixir](https://elixir-lang.org)
* [Sqlite](https://sqlite.org)
* [Typst](https://typst.app)
* [Rizin](https://rizin.re)
* [Git](https://git-scm.com/docs)
* [GitHub](https://docs.github.com)
* [Markdown Oxide](https://oxide.md)
* [OpenSSH](https://www.openssh.com)
* [Docker](https://docs.docker.com)
* [Kubernetes](https://kubernetes.io)
* [AWS](https://docs.aws.amazon.com)
* [Azure](https://learn.microsoft.com/en-us/azure)
* [Tencent](https://www.tencentcloud.com/document/product)
* [HashiCorp](https://developer.hashicorp.com)
* [Polumi](https://www.pulumi.com)

## Backup
Once satisfied with the system looks you can easily clone it using `dd`!
```sh
cat /proc/partitions
dd if=/dev/nvme0n1 bs=4M of=/dev/nvme0n2
```
Then to restore it you simply would.
```sh
dd if=/dev/nvme0n2 bs=4M of=/dev/nvme0n1
```

## Conclusion
This is made by myself for myself.  
Clone disks or use images instead of reinstalling if you can as this takes like an hour to do.  
Remember to sync stuff with an entry in `crontab -e` on Google Drive or AWS!
