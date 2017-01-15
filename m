From: "Giuseppe Lippolis" <giu.lippolis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: problem with spidev on RT5350
Date: Sun, 15 Jan 2017 21:16:02 +0100
Message-ID: <001001d26f6c$32022c40$960684c0$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: de
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Dear All,
I have a problem with the spidev driver.
My platform is a MIPS rt5350 (board dlink dwr-512). 
The board have two spi channel:
on the first is located the flash device

	&spi0 {
	        status = "okay";

	        mx25l6405d@0 {
	                #address-cells = <1>;
	                #size-cells = <1>;
	                compatible = "jedec,spi-nor";
	                reg = <0>;
	                spi-max-frequency = <30000000>;
	                m25p,fast-read;

on the second the si3210 (driver spidev) 

	&spi1 {
	        status = "okay";

	        spidev@1 {
	                #address-cells = <1>;
	                #size-cells = <1>;
	                compatible = "siliconlabs,si3210";

I'm running a LEDE distribution 
Reboot (SNAPSHOT, r2961+5-3e56748)

based on linux 4.4.42
root@lede:/tmp# uname -a
Linux lede 4.4.42 #0 Sat Jan 14 22:47:43 2017 mips GNU/Linux

As expected I'm able to see the /dev/spidev1.0 to address the second spi
channel.
root@lede:/tmp# spi-config -d /dev/spidev1.0 -q
/dev/spidev1.0: mode=3, lsb=0, bits=8, speed=1000000

Unfortunatly when I try to run the spidev_test I get an error:
root@lede:/tmp# spidev_test -D /dev/spidev1.0 -v -s 1000000 -p
"1234\xde\xad"
spi mode: 0x3
bits per word: 8
max speed: 1000000 Hz (1000 KHz)
can't send spi message: Invalid argument
Aborted

Running strace on the spidev_test:
	root@lede:/tmp# strace spidev_test -D /dev/spidev1.0 -v -s 1000000
-p "1234\xde\xad"
	execve("/sbin/spidev_test", ["spidev_test", "-D", "/dev/spidev1.0",
"-v", "-s", "1000000", "-p", "1234\\xde\\xad"], [/* 14 vars */]) = 0
	set_thread_area(0x770f1e50)             = 0
	set_tid_address(0x770ead90)             = 1130
	open("/etc/ld-musl-mipsel-sf.path", O_RDONLY|O_LARGEFILE|O_CLOEXEC)
= -1 ENOENT (No such file or directory)
	open("/lib/libgcc_s.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
	fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
	fstat64(3, {st_mode=S_IFREG|0644, st_size=76975, ...}) = 0
	read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\10\0\1\0\0\0\20(\0\0004\0\0\0"..., 936)
= 936
	mmap2(NULL, 143360, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x77023000
	mmap2(0x77045000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x12000) = 0x77045000
	close(3)                                = 0
	mprotect(0x411000, 4096, PROT_READ)     = 0
	open("/dev/spidev1.0", O_RDWR|O_LARGEFILE) = 3
	ioctl(3, SPI_IOC_WR_MODE32, 0x4120a8)   = 0
	ioctl(3, SPI_IOC_RD_MODE32, 0x4120a8)   = 0
	ioctl(3, SPI_IOC_WR_BITS_PER_WORD, 0x412024) = 0
	ioctl(3, SPI_IOC_RD_BITS_PER_WORD, 0x412024) = 0
	ioctl(3, SPI_IOC_WR_MAX_SPEED_HZ, 0x412020) = 0
	ioctl(3, SPI_IOC_RD_MAX_SPEED_HZ, 0x412020) = 0
	ioctl(1, TIOCGWINSZ, 0x7f9b1720)        = 0
	writev(1, [{iov_base="spi mode: 0x3", iov_len=13}, {iov_base="\n",
iov_len=1}], 2spi mode: 0x3 ) = 14
	writev(1, [{iov_base="bits per word: 8", iov_len=16},
{iov_base="\n", iov_len=1}], 2bits per word: 8 ) = 17
	writev(1, [{iov_base="max speed: 1000000 Hz (1000", iov_len=27},
{iov_base=" KHz)\n", iov_len=6}], 2max speed: 1000000 Hz (1000 KHz) ) = 33
	ioctl(3, SPI_IOC_MESSAGE(32), 0x7f9b1ba0) = -1 EINVAL (Invalid
argument)
	writev(2, [{iov_base="", iov_len=0}, {iov_base="can't send spi
message", iov_len=22}], 2can't send spi message) = 22
	writev(2, [{iov_base="", iov_len=0}, {iov_base=":", iov_len=1}], 2:)
= 1
	writev(2, [{iov_base="", iov_len=0}, {iov_base=" ", iov_len=1}], 2 )
= 1
	writev(2, [{iov_base="", iov_len=0}, {iov_base="Invalid argument",
iov_len=16}], 2Invalid argument) = 16
	writev(2, [{iov_base="", iov_len=0}, {iov_base="\n", iov_len=1}], 2
) = 1
	rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1 RT_2], [], 16) = 0
	gettid()                                = 1130
	tkill(1130, SIGIOT)                     = 0
	rt_sigprocmask(SIG_SETMASK, [], NULL, 16) = 0
	--- SIGIOT {si_signo=SIGIOT, si_code=SI_TKILL, si_pid=1130,
si_uid=0} ---
	+++ killed by SIGIOT +++
	Aborted

report an ioctl error:
	ioctl(3, SPI_IOC_MESSAGE(32), 0x7f9b1ba0) = -1 EINVAL (Invalid
argument)

I enabled the debug info on the spidev module and added some logging to
trace the called functions:
this is the results:
	[  467.136250] spidev printk spidev_open function
	[  467.156910] spidev printk spidev_ioctl function
	[  467.156987] spidev spi1.0: spidev_ioctl function
	[  467.157031] spidev spi1.0: force spi mode3
	[  467.165372] spidev spi1.0: spi mode 0
	[  467.165408] spidev spi1.0: ioctl spi_dev_put
	[  467.187424] spidev printk spidev_ioctl function
	[  467.187500] spidev spi1.0: spidev_ioctl function
	[  467.187538] spidev spi1.0: ioctl spi_dev_put
	[  467.199564] spidev printk spidev_ioctl function
	[  467.199642] spidev spi1.0: spidev_ioctl function
	[  467.199692] spidev spi1.0: 8 bits per word
	[  467.199717] spidev spi1.0: ioctl spi_dev_put
	[  467.206843] spidev printk spidev_ioctl function
	[  467.206919] spidev spi1.0: spidev_ioctl function
	[  467.206956] spidev spi1.0: ioctl spi_dev_put
	[  467.210687] spidev printk spidev_ioctl function
	[  467.210761] spidev spi1.0: spidev_ioctl function
	[  467.210809] spidev spi1.0: ioctl spi_dev_put
	[  467.213595] spidev printk spidev_ioctl function
	[  467.213671] spidev spi1.0: spidev_ioctl function
	[  467.213707] spidev spi1.0: ioctl spi_dev_put
	[  467.227711] spidev printk spidev_ioctl function
	[  467.227787] spidev spi1.0: spidev_ioctl function
	[  467.227824] spidev spi1.0: ioctl default switch
	[  467.227858] spidev spi1.0: ioctl default switch spidev_message
	[  467.227883] spidev spi1.0: spidev_message function
	[  467.227927] spidev spi1.0:   xfer len 6 rx tx 8bits 0 usec
1000000Hz
	[  467.227955] spidev spi1.0: spidev_sync function
	[  467.227984] spidev spi1.0: ioctl spi_dev_put
	[  467.276286] spidev printk spidev_release function

It seems that the spidev_ioctl run up to the end, where I add:
        mutex_unlock(&spidev->buf_lock);
        dev_dbg(&spi->dev, "ioctl spi_dev_put\n");
        spi_dev_put(spi);
        return retval;

Do someone have any help for me?
Thanks,
Bye.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
