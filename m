From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH v2 1/6] spi: Move spi code from Documentation to tools
Date: Wed, 18 Nov 2015 14:30:37 -0800
Message-ID: <7d50143a1228f2fe38df5919ca02fc707f61e442.1447880230.git.stillcompiling@gmail.com>
References: <cover.1447880230.git.stillcompiling@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Anton Bondarenko <anton.bondarenko.sama@gmail.com>,
	Joshua Clayton <stillcompiling@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1447880230.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1447880230.git.stillcompiling@gmail.com>
References: <cover.1447880230.git.stillcompiling@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Jon Corbet requested this code moved with the last changeset,
https://lkml.org/lkml/2015/3/1/144,
but the patch was not applied because it missed the Makefile.
Moved spidev_test, spidev_fdx and their Makefile infrastructure.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 Documentation/Makefile          |   2 +-
 Documentation/spi/Makefile      |   8 -
 Documentation/spi/spidev_fdx.c  | 158 --------------------
 Documentation/spi/spidev_test.c | 318 ----------------------------------------
 tools/Makefile                  |   7 +-
 tools/spi/Makefile              |   4 +
 tools/spi/spidev_fdx.c          | 158 ++++++++++++++++++++
 tools/spi/spidev_test.c         | 318 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 485 insertions(+), 488 deletions(-)
 delete mode 100644 Documentation/spi/Makefile
 delete mode 100644 Documentation/spi/spidev_fdx.c
 delete mode 100644 Documentation/spi/spidev_test.c
 create mode 100644 tools/spi/Makefile
 create mode 100644 tools/spi/spidev_fdx.c
 create mode 100644 tools/spi/spidev_test.c

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6883a1b..f642cb9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,4 +1,4 @@
 subdir-y := accounting arm auxdisplay blackfin connector \
 	filesystems filesystems ia64 laptops mic misc-devices \
-	networking pcmcia prctl ptp spi timers vDSO video4linux \
+	networking pcmcia prctl ptp timers vDSO video4linux \
 	watchdog
diff --git a/Documentation/spi/Makefile b/Documentation/spi/Makefile
deleted file mode 100644
index efa2558..0000000
--- a/Documentation/spi/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# List of programs to build
-hostprogs-y := spidev_test spidev_fdx
-
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
-
-HOSTCFLAGS_spidev_test.o += -I$(objtree)/usr/include
-HOSTCFLAGS_spidev_fdx.o += -I$(objtree)/usr/include
diff --git a/Documentation/spi/spidev_fdx.c b/Documentation/spi/spidev_fdx.c
deleted file mode 100644
index 0ea3e51..0000000
--- a/Documentation/spi/spidev_fdx.c
+++ /dev/null
@@ -1,158 +0,0 @@
-#include <stdio.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <fcntl.h>
-#include <string.h>
-
-#include <sys/ioctl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-
-#include <linux/types.h>
-#include <linux/spi/spidev.h>
-
-
-static int verbose;
-
-static void do_read(int fd, int len)
-{
-	unsigned char	buf[32], *bp;
-	int		status;
-
-	/* read at least 2 bytes, no more than 32 */
-	if (len < 2)
-		len = 2;
-	else if (len > sizeof(buf))
-		len = sizeof(buf);
-	memset(buf, 0, sizeof buf);
-
-	status = read(fd, buf, len);
-	if (status < 0) {
-		perror("read");
-		return;
-	}
-	if (status != len) {
-		fprintf(stderr, "short read\n");
-		return;
-	}
-
-	printf("read(%2d, %2d): %02x %02x,", len, status,
-		buf[0], buf[1]);
-	status -= 2;
-	bp = buf + 2;
-	while (status-- > 0)
-		printf(" %02x", *bp++);
-	printf("\n");
-}
-
-static void do_msg(int fd, int len)
-{
-	struct spi_ioc_transfer	xfer[2];
-	unsigned char		buf[32], *bp;
-	int			status;
-
-	memset(xfer, 0, sizeof xfer);
-	memset(buf, 0, sizeof buf);
-
-	if (len > sizeof buf)
-		len = sizeof buf;
-
-	buf[0] = 0xaa;
-	xfer[0].tx_buf = (unsigned long)buf;
-	xfer[0].len = 1;
-
-	xfer[1].rx_buf = (unsigned long) buf;
-	xfer[1].len = len;
-
-	status = ioctl(fd, SPI_IOC_MESSAGE(2), xfer);
-	if (status < 0) {
-		perror("SPI_IOC_MESSAGE");
-		return;
-	}
-
-	printf("response(%2d, %2d): ", len, status);
-	for (bp = buf; len; len--)
-		printf(" %02x", *bp++);
-	printf("\n");
-}
-
-static void dumpstat(const char *name, int fd)
-{
-	__u8	lsb, bits;
-	__u32	mode, speed;
-
-	if (ioctl(fd, SPI_IOC_RD_MODE32, &mode) < 0) {
-		perror("SPI rd_mode");
-		return;
-	}
-	if (ioctl(fd, SPI_IOC_RD_LSB_FIRST, &lsb) < 0) {
-		perror("SPI rd_lsb_fist");
-		return;
-	}
-	if (ioctl(fd, SPI_IOC_RD_BITS_PER_WORD, &bits) < 0) {
-		perror("SPI bits_per_word");
-		return;
-	}
-	if (ioctl(fd, SPI_IOC_RD_MAX_SPEED_HZ, &speed) < 0) {
-		perror("SPI max_speed_hz");
-		return;
-	}
-
-	printf("%s: spi mode 0x%x, %d bits %sper word, %d Hz max\n",
-		name, mode, bits, lsb ? "(lsb first) " : "", speed);
-}
-
-int main(int argc, char **argv)
-{
-	int		c;
-	int		readcount = 0;
-	int		msglen = 0;
-	int		fd;
-	const char	*name;
-
-	while ((c = getopt(argc, argv, "hm:r:v")) != EOF) {
-		switch (c) {
-		case 'm':
-			msglen = atoi(optarg);
-			if (msglen < 0)
-				goto usage;
-			continue;
-		case 'r':
-			readcount = atoi(optarg);
-			if (readcount < 0)
-				goto usage;
-			continue;
-		case 'v':
-			verbose++;
-			continue;
-		case 'h':
-		case '?':
-usage:
-			fprintf(stderr,
-				"usage: %s [-h] [-m N] [-r N] /dev/spidevB.D\n",
-				argv[0]);
-			return 1;
-		}
-	}
-
-	if ((optind + 1) != argc)
-		goto usage;
-	name = argv[optind];
-
-	fd = open(name, O_RDWR);
-	if (fd < 0) {
-		perror("open");
-		return 1;
-	}
-
-	dumpstat(name, fd);
-
-	if (msglen)
-		do_msg(fd, msglen);
-
-	if (readcount)
-		do_read(fd, readcount);
-
-	close(fd);
-	return 0;
-}
diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
deleted file mode 100644
index 135b3f5..0000000
--- a/Documentation/spi/spidev_test.c
+++ /dev/null
@@ -1,318 +0,0 @@
-/*
- * SPI testing utility (using spidev driver)
- *
- * Copyright (c) 2007  MontaVista Software, Inc.
- * Copyright (c) 2007  Anton Vorontsov <avorontsov@ru.mvista.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License.
- *
- * Cross-compile with cross-gcc -I/path/to/cross-kernel/include
- */
-
-#include <stdint.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <getopt.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <linux/types.h>
-#include <linux/spi/spidev.h>
-
-#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
-
-static void pabort(const char *s)
-{
-	perror(s);
-	abort();
-}
-
-static const char *device = "/dev/spidev1.1";
-static uint32_t mode;
-static uint8_t bits = 8;
-static uint32_t speed = 500000;
-static uint16_t delay;
-static int verbose;
-
-uint8_t default_tx[] = {
-	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-	0x40, 0x00, 0x00, 0x00, 0x00, 0x95,
-	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-	0xF0, 0x0D,
-};
-
-uint8_t default_rx[ARRAY_SIZE(default_tx)] = {0, };
-char *input_tx;
-
-static void hex_dump(const void *src, size_t length, size_t line_size, char *prefix)
-{
-	int i = 0;
-	const unsigned char *address = src;
-	const unsigned char *line = address;
-	unsigned char c;
-
-	printf("%s | ", prefix);
-	while (length-- > 0) {
-		printf("%02X ", *address++);
-		if (!(++i % line_size) || (length == 0 && i % line_size)) {
-			if (length == 0) {
-				while (i++ % line_size)
-					printf("__ ");
-			}
-			printf(" | ");  /* right close */
-			while (line < address) {
-				c = *line++;
-				printf("%c", (c < 33 || c == 255) ? 0x2E : c);
-			}
-			printf("\n");
-			if (length > 0)
-				printf("%s | ", prefix);
-		}
-	}
-}
-
-/*
- *  Unescape - process hexadecimal escape character
- *      converts shell input "\x23" -> 0x23
- */
-static int unescape(char *_dst, char *_src, size_t len)
-{
-	int ret = 0;
-	char *src = _src;
-	char *dst = _dst;
-	unsigned int ch;
-
-	while (*src) {
-		if (*src == '\\' && *(src+1) == 'x') {
-			sscanf(src + 2, "%2x", &ch);
-			src += 4;
-			*dst++ = (unsigned char)ch;
-		} else {
-			*dst++ = *src++;
-		}
-		ret++;
-	}
-	return ret;
-}
-
-static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
-{
-	int ret;
-
-	struct spi_ioc_transfer tr = {
-		.tx_buf = (unsigned long)tx,
-		.rx_buf = (unsigned long)rx,
-		.len = len,
-		.delay_usecs = delay,
-		.speed_hz = speed,
-		.bits_per_word = bits,
-	};
-
-	if (mode & SPI_TX_QUAD)
-		tr.tx_nbits = 4;
-	else if (mode & SPI_TX_DUAL)
-		tr.tx_nbits = 2;
-	if (mode & SPI_RX_QUAD)
-		tr.rx_nbits = 4;
-	else if (mode & SPI_RX_DUAL)
-		tr.rx_nbits = 2;
-	if (!(mode & SPI_LOOP)) {
-		if (mode & (SPI_TX_QUAD | SPI_TX_DUAL))
-			tr.rx_buf = 0;
-		else if (mode & (SPI_RX_QUAD | SPI_RX_DUAL))
-			tr.tx_buf = 0;
-	}
-
-	ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
-	if (ret < 1)
-		pabort("can't send spi message");
-
-	if (verbose)
-		hex_dump(tx, len, 32, "TX");
-	hex_dump(rx, len, 32, "RX");
-}
-
-static void print_usage(const char *prog)
-{
-	printf("Usage: %s [-DsbdlHOLC3]\n", prog);
-	puts("  -D --device   device to use (default /dev/spidev1.1)\n"
-	     "  -s --speed    max speed (Hz)\n"
-	     "  -d --delay    delay (usec)\n"
-	     "  -b --bpw      bits per word \n"
-	     "  -l --loop     loopback\n"
-	     "  -H --cpha     clock phase\n"
-	     "  -O --cpol     clock polarity\n"
-	     "  -L --lsb      least significant bit first\n"
-	     "  -C --cs-high  chip select active high\n"
-	     "  -3 --3wire    SI/SO signals shared\n"
-	     "  -v --verbose  Verbose (show tx buffer)\n"
-	     "  -p            Send data (e.g. \"1234\\xde\\xad\")\n"
-	     "  -N --no-cs    no chip select\n"
-	     "  -R --ready    slave pulls low to pause\n"
-	     "  -2 --dual     dual transfer\n"
-	     "  -4 --quad     quad transfer\n");
-	exit(1);
-}
-
-static void parse_opts(int argc, char *argv[])
-{
-	while (1) {
-		static const struct option lopts[] = {
-			{ "device",  1, 0, 'D' },
-			{ "speed",   1, 0, 's' },
-			{ "delay",   1, 0, 'd' },
-			{ "bpw",     1, 0, 'b' },
-			{ "loop",    0, 0, 'l' },
-			{ "cpha",    0, 0, 'H' },
-			{ "cpol",    0, 0, 'O' },
-			{ "lsb",     0, 0, 'L' },
-			{ "cs-high", 0, 0, 'C' },
-			{ "3wire",   0, 0, '3' },
-			{ "no-cs",   0, 0, 'N' },
-			{ "ready",   0, 0, 'R' },
-			{ "dual",    0, 0, '2' },
-			{ "verbose", 0, 0, 'v' },
-			{ "quad",    0, 0, '4' },
-			{ NULL, 0, 0, 0 },
-		};
-		int c;
-
-		c = getopt_long(argc, argv, "D:s:d:b:lHOLC3NR24p:v", lopts, NULL);
-
-		if (c == -1)
-			break;
-
-		switch (c) {
-		case 'D':
-			device = optarg;
-			break;
-		case 's':
-			speed = atoi(optarg);
-			break;
-		case 'd':
-			delay = atoi(optarg);
-			break;
-		case 'b':
-			bits = atoi(optarg);
-			break;
-		case 'l':
-			mode |= SPI_LOOP;
-			break;
-		case 'H':
-			mode |= SPI_CPHA;
-			break;
-		case 'O':
-			mode |= SPI_CPOL;
-			break;
-		case 'L':
-			mode |= SPI_LSB_FIRST;
-			break;
-		case 'C':
-			mode |= SPI_CS_HIGH;
-			break;
-		case '3':
-			mode |= SPI_3WIRE;
-			break;
-		case 'N':
-			mode |= SPI_NO_CS;
-			break;
-		case 'v':
-			verbose = 1;
-			break;
-		case 'R':
-			mode |= SPI_READY;
-			break;
-		case 'p':
-			input_tx = optarg;
-			break;
-		case '2':
-			mode |= SPI_TX_DUAL;
-			break;
-		case '4':
-			mode |= SPI_TX_QUAD;
-			break;
-		default:
-			print_usage(argv[0]);
-			break;
-		}
-	}
-	if (mode & SPI_LOOP) {
-		if (mode & SPI_TX_DUAL)
-			mode |= SPI_RX_DUAL;
-		if (mode & SPI_TX_QUAD)
-			mode |= SPI_RX_QUAD;
-	}
-}
-
-int main(int argc, char *argv[])
-{
-	int ret = 0;
-	int fd;
-	uint8_t *tx;
-	uint8_t *rx;
-	int size;
-
-	parse_opts(argc, argv);
-
-	fd = open(device, O_RDWR);
-	if (fd < 0)
-		pabort("can't open device");
-
-	/*
-	 * spi mode
-	 */
-	ret = ioctl(fd, SPI_IOC_WR_MODE32, &mode);
-	if (ret == -1)
-		pabort("can't set spi mode");
-
-	ret = ioctl(fd, SPI_IOC_RD_MODE32, &mode);
-	if (ret == -1)
-		pabort("can't get spi mode");
-
-	/*
-	 * bits per word
-	 */
-	ret = ioctl(fd, SPI_IOC_WR_BITS_PER_WORD, &bits);
-	if (ret == -1)
-		pabort("can't set bits per word");
-
-	ret = ioctl(fd, SPI_IOC_RD_BITS_PER_WORD, &bits);
-	if (ret == -1)
-		pabort("can't get bits per word");
-
-	/*
-	 * max speed hz
-	 */
-	ret = ioctl(fd, SPI_IOC_WR_MAX_SPEED_HZ, &speed);
-	if (ret == -1)
-		pabort("can't set max speed hz");
-
-	ret = ioctl(fd, SPI_IOC_RD_MAX_SPEED_HZ, &speed);
-	if (ret == -1)
-		pabort("can't get max speed hz");
-
-	printf("spi mode: 0x%x\n", mode);
-	printf("bits per word: %d\n", bits);
-	printf("max speed: %d Hz (%d KHz)\n", speed, speed/1000);
-
-	if (input_tx) {
-		size = strlen(input_tx+1);
-		tx = malloc(size);
-		rx = malloc(size);
-		size = unescape((char *)tx, input_tx, size);
-		transfer(fd, tx, rx, size);
-		free(rx);
-		free(tx);
-	} else {
-		transfer(fd, default_tx, default_rx, sizeof(default_tx));
-	}
-
-	close(fd);
-
-	return ret;
-}
diff --git a/tools/Makefile b/tools/Makefile
index 9a617ad..d238a96 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -11,6 +11,7 @@ help:
 	@echo '  lguest     - a minimal 32-bit x86 hypervisor'
 	@echo '  perf       - Linux performance measurement and analysis tool'
 	@echo '  selftests  - various kernel selftests'
+	@echo '  spi        - spi tools'
 	@echo '  turbostat  - Intel CPU idle stats and freq reporting tool'
 	@echo '  usb        - USB testing tools'
 	@echo '  virtio     - vhost test module'
@@ -41,7 +42,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup firewire hv guest usb virtio vm net: FORCE
+cgroup firewire hv guest spi usb virtio vm net: FORCE
 	$(call descend,$@)
 
 liblockdep: FORCE
@@ -91,7 +92,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-cgroup_clean hv_clean firewire_clean lguest_clean usb_clean virtio_clean vm_clean net_clean:
+cgroup_clean hv_clean firewire_clean lguest_clean spi_clean usb_clean virtio_clean vm_clean net_clean:
 	$(call descend,$(@:_clean=),clean)
 
 liblockdep_clean:
@@ -113,7 +114,7 @@ tmon_clean:
 	$(call descend,thermal/tmon,clean)
 
 clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean lguest_clean \
-		perf_clean selftests_clean turbostat_clean usb_clean virtio_clean \
+		perf_clean selftests_clean spi_clean turbostat_clean usb_clean virtio_clean \
 		vm_clean net_clean x86_energy_perf_policy_clean tmon_clean
 
 .PHONY: FORCE
diff --git a/tools/spi/Makefile b/tools/spi/Makefile
new file mode 100644
index 0000000..cd0db62
--- /dev/null
+++ b/tools/spi/Makefile
@@ -0,0 +1,4 @@
+all: spidev_test spidev_fdx
+
+clean:
+	$(RM) spidev_test spidev_fdx
diff --git a/tools/spi/spidev_fdx.c b/tools/spi/spidev_fdx.c
new file mode 100644
index 0000000..0ea3e51
--- /dev/null
+++ b/tools/spi/spidev_fdx.c
@@ -0,0 +1,158 @@
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <string.h>
+
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include <linux/types.h>
+#include <linux/spi/spidev.h>
+
+
+static int verbose;
+
+static void do_read(int fd, int len)
+{
+	unsigned char	buf[32], *bp;
+	int		status;
+
+	/* read at least 2 bytes, no more than 32 */
+	if (len < 2)
+		len = 2;
+	else if (len > sizeof(buf))
+		len = sizeof(buf);
+	memset(buf, 0, sizeof buf);
+
+	status = read(fd, buf, len);
+	if (status < 0) {
+		perror("read");
+		return;
+	}
+	if (status != len) {
+		fprintf(stderr, "short read\n");
+		return;
+	}
+
+	printf("read(%2d, %2d): %02x %02x,", len, status,
+		buf[0], buf[1]);
+	status -= 2;
+	bp = buf + 2;
+	while (status-- > 0)
+		printf(" %02x", *bp++);
+	printf("\n");
+}
+
+static void do_msg(int fd, int len)
+{
+	struct spi_ioc_transfer	xfer[2];
+	unsigned char		buf[32], *bp;
+	int			status;
+
+	memset(xfer, 0, sizeof xfer);
+	memset(buf, 0, sizeof buf);
+
+	if (len > sizeof buf)
+		len = sizeof buf;
+
+	buf[0] = 0xaa;
+	xfer[0].tx_buf = (unsigned long)buf;
+	xfer[0].len = 1;
+
+	xfer[1].rx_buf = (unsigned long) buf;
+	xfer[1].len = len;
+
+	status = ioctl(fd, SPI_IOC_MESSAGE(2), xfer);
+	if (status < 0) {
+		perror("SPI_IOC_MESSAGE");
+		return;
+	}
+
+	printf("response(%2d, %2d): ", len, status);
+	for (bp = buf; len; len--)
+		printf(" %02x", *bp++);
+	printf("\n");
+}
+
+static void dumpstat(const char *name, int fd)
+{
+	__u8	lsb, bits;
+	__u32	mode, speed;
+
+	if (ioctl(fd, SPI_IOC_RD_MODE32, &mode) < 0) {
+		perror("SPI rd_mode");
+		return;
+	}
+	if (ioctl(fd, SPI_IOC_RD_LSB_FIRST, &lsb) < 0) {
+		perror("SPI rd_lsb_fist");
+		return;
+	}
+	if (ioctl(fd, SPI_IOC_RD_BITS_PER_WORD, &bits) < 0) {
+		perror("SPI bits_per_word");
+		return;
+	}
+	if (ioctl(fd, SPI_IOC_RD_MAX_SPEED_HZ, &speed) < 0) {
+		perror("SPI max_speed_hz");
+		return;
+	}
+
+	printf("%s: spi mode 0x%x, %d bits %sper word, %d Hz max\n",
+		name, mode, bits, lsb ? "(lsb first) " : "", speed);
+}
+
+int main(int argc, char **argv)
+{
+	int		c;
+	int		readcount = 0;
+	int		msglen = 0;
+	int		fd;
+	const char	*name;
+
+	while ((c = getopt(argc, argv, "hm:r:v")) != EOF) {
+		switch (c) {
+		case 'm':
+			msglen = atoi(optarg);
+			if (msglen < 0)
+				goto usage;
+			continue;
+		case 'r':
+			readcount = atoi(optarg);
+			if (readcount < 0)
+				goto usage;
+			continue;
+		case 'v':
+			verbose++;
+			continue;
+		case 'h':
+		case '?':
+usage:
+			fprintf(stderr,
+				"usage: %s [-h] [-m N] [-r N] /dev/spidevB.D\n",
+				argv[0]);
+			return 1;
+		}
+	}
+
+	if ((optind + 1) != argc)
+		goto usage;
+	name = argv[optind];
+
+	fd = open(name, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		return 1;
+	}
+
+	dumpstat(name, fd);
+
+	if (msglen)
+		do_msg(fd, msglen);
+
+	if (readcount)
+		do_read(fd, readcount);
+
+	close(fd);
+	return 0;
+}
diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
new file mode 100644
index 0000000..135b3f5
--- /dev/null
+++ b/tools/spi/spidev_test.c
@@ -0,0 +1,318 @@
+/*
+ * SPI testing utility (using spidev driver)
+ *
+ * Copyright (c) 2007  MontaVista Software, Inc.
+ * Copyright (c) 2007  Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * Cross-compile with cross-gcc -I/path/to/cross-kernel/include
+ */
+
+#include <stdint.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <linux/types.h>
+#include <linux/spi/spidev.h>
+
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
+
+static void pabort(const char *s)
+{
+	perror(s);
+	abort();
+}
+
+static const char *device = "/dev/spidev1.1";
+static uint32_t mode;
+static uint8_t bits = 8;
+static uint32_t speed = 500000;
+static uint16_t delay;
+static int verbose;
+
+uint8_t default_tx[] = {
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0x40, 0x00, 0x00, 0x00, 0x00, 0x95,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xF0, 0x0D,
+};
+
+uint8_t default_rx[ARRAY_SIZE(default_tx)] = {0, };
+char *input_tx;
+
+static void hex_dump(const void *src, size_t length, size_t line_size, char *prefix)
+{
+	int i = 0;
+	const unsigned char *address = src;
+	const unsigned char *line = address;
+	unsigned char c;
+
+	printf("%s | ", prefix);
+	while (length-- > 0) {
+		printf("%02X ", *address++);
+		if (!(++i % line_size) || (length == 0 && i % line_size)) {
+			if (length == 0) {
+				while (i++ % line_size)
+					printf("__ ");
+			}
+			printf(" | ");  /* right close */
+			while (line < address) {
+				c = *line++;
+				printf("%c", (c < 33 || c == 255) ? 0x2E : c);
+			}
+			printf("\n");
+			if (length > 0)
+				printf("%s | ", prefix);
+		}
+	}
+}
+
+/*
+ *  Unescape - process hexadecimal escape character
+ *      converts shell input "\x23" -> 0x23
+ */
+static int unescape(char *_dst, char *_src, size_t len)
+{
+	int ret = 0;
+	char *src = _src;
+	char *dst = _dst;
+	unsigned int ch;
+
+	while (*src) {
+		if (*src == '\\' && *(src+1) == 'x') {
+			sscanf(src + 2, "%2x", &ch);
+			src += 4;
+			*dst++ = (unsigned char)ch;
+		} else {
+			*dst++ = *src++;
+		}
+		ret++;
+	}
+	return ret;
+}
+
+static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
+{
+	int ret;
+
+	struct spi_ioc_transfer tr = {
+		.tx_buf = (unsigned long)tx,
+		.rx_buf = (unsigned long)rx,
+		.len = len,
+		.delay_usecs = delay,
+		.speed_hz = speed,
+		.bits_per_word = bits,
+	};
+
+	if (mode & SPI_TX_QUAD)
+		tr.tx_nbits = 4;
+	else if (mode & SPI_TX_DUAL)
+		tr.tx_nbits = 2;
+	if (mode & SPI_RX_QUAD)
+		tr.rx_nbits = 4;
+	else if (mode & SPI_RX_DUAL)
+		tr.rx_nbits = 2;
+	if (!(mode & SPI_LOOP)) {
+		if (mode & (SPI_TX_QUAD | SPI_TX_DUAL))
+			tr.rx_buf = 0;
+		else if (mode & (SPI_RX_QUAD | SPI_RX_DUAL))
+			tr.tx_buf = 0;
+	}
+
+	ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
+	if (ret < 1)
+		pabort("can't send spi message");
+
+	if (verbose)
+		hex_dump(tx, len, 32, "TX");
+	hex_dump(rx, len, 32, "RX");
+}
+
+static void print_usage(const char *prog)
+{
+	printf("Usage: %s [-DsbdlHOLC3]\n", prog);
+	puts("  -D --device   device to use (default /dev/spidev1.1)\n"
+	     "  -s --speed    max speed (Hz)\n"
+	     "  -d --delay    delay (usec)\n"
+	     "  -b --bpw      bits per word \n"
+	     "  -l --loop     loopback\n"
+	     "  -H --cpha     clock phase\n"
+	     "  -O --cpol     clock polarity\n"
+	     "  -L --lsb      least significant bit first\n"
+	     "  -C --cs-high  chip select active high\n"
+	     "  -3 --3wire    SI/SO signals shared\n"
+	     "  -v --verbose  Verbose (show tx buffer)\n"
+	     "  -p            Send data (e.g. \"1234\\xde\\xad\")\n"
+	     "  -N --no-cs    no chip select\n"
+	     "  -R --ready    slave pulls low to pause\n"
+	     "  -2 --dual     dual transfer\n"
+	     "  -4 --quad     quad transfer\n");
+	exit(1);
+}
+
+static void parse_opts(int argc, char *argv[])
+{
+	while (1) {
+		static const struct option lopts[] = {
+			{ "device",  1, 0, 'D' },
+			{ "speed",   1, 0, 's' },
+			{ "delay",   1, 0, 'd' },
+			{ "bpw",     1, 0, 'b' },
+			{ "loop",    0, 0, 'l' },
+			{ "cpha",    0, 0, 'H' },
+			{ "cpol",    0, 0, 'O' },
+			{ "lsb",     0, 0, 'L' },
+			{ "cs-high", 0, 0, 'C' },
+			{ "3wire",   0, 0, '3' },
+			{ "no-cs",   0, 0, 'N' },
+			{ "ready",   0, 0, 'R' },
+			{ "dual",    0, 0, '2' },
+			{ "verbose", 0, 0, 'v' },
+			{ "quad",    0, 0, '4' },
+			{ NULL, 0, 0, 0 },
+		};
+		int c;
+
+		c = getopt_long(argc, argv, "D:s:d:b:lHOLC3NR24p:v", lopts, NULL);
+
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 'D':
+			device = optarg;
+			break;
+		case 's':
+			speed = atoi(optarg);
+			break;
+		case 'd':
+			delay = atoi(optarg);
+			break;
+		case 'b':
+			bits = atoi(optarg);
+			break;
+		case 'l':
+			mode |= SPI_LOOP;
+			break;
+		case 'H':
+			mode |= SPI_CPHA;
+			break;
+		case 'O':
+			mode |= SPI_CPOL;
+			break;
+		case 'L':
+			mode |= SPI_LSB_FIRST;
+			break;
+		case 'C':
+			mode |= SPI_CS_HIGH;
+			break;
+		case '3':
+			mode |= SPI_3WIRE;
+			break;
+		case 'N':
+			mode |= SPI_NO_CS;
+			break;
+		case 'v':
+			verbose = 1;
+			break;
+		case 'R':
+			mode |= SPI_READY;
+			break;
+		case 'p':
+			input_tx = optarg;
+			break;
+		case '2':
+			mode |= SPI_TX_DUAL;
+			break;
+		case '4':
+			mode |= SPI_TX_QUAD;
+			break;
+		default:
+			print_usage(argv[0]);
+			break;
+		}
+	}
+	if (mode & SPI_LOOP) {
+		if (mode & SPI_TX_DUAL)
+			mode |= SPI_RX_DUAL;
+		if (mode & SPI_TX_QUAD)
+			mode |= SPI_RX_QUAD;
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = 0;
+	int fd;
+	uint8_t *tx;
+	uint8_t *rx;
+	int size;
+
+	parse_opts(argc, argv);
+
+	fd = open(device, O_RDWR);
+	if (fd < 0)
+		pabort("can't open device");
+
+	/*
+	 * spi mode
+	 */
+	ret = ioctl(fd, SPI_IOC_WR_MODE32, &mode);
+	if (ret == -1)
+		pabort("can't set spi mode");
+
+	ret = ioctl(fd, SPI_IOC_RD_MODE32, &mode);
+	if (ret == -1)
+		pabort("can't get spi mode");
+
+	/*
+	 * bits per word
+	 */
+	ret = ioctl(fd, SPI_IOC_WR_BITS_PER_WORD, &bits);
+	if (ret == -1)
+		pabort("can't set bits per word");
+
+	ret = ioctl(fd, SPI_IOC_RD_BITS_PER_WORD, &bits);
+	if (ret == -1)
+		pabort("can't get bits per word");
+
+	/*
+	 * max speed hz
+	 */
+	ret = ioctl(fd, SPI_IOC_WR_MAX_SPEED_HZ, &speed);
+	if (ret == -1)
+		pabort("can't set max speed hz");
+
+	ret = ioctl(fd, SPI_IOC_RD_MAX_SPEED_HZ, &speed);
+	if (ret == -1)
+		pabort("can't get max speed hz");
+
+	printf("spi mode: 0x%x\n", mode);
+	printf("bits per word: %d\n", bits);
+	printf("max speed: %d Hz (%d KHz)\n", speed, speed/1000);
+
+	if (input_tx) {
+		size = strlen(input_tx+1);
+		tx = malloc(size);
+		rx = malloc(size);
+		size = unescape((char *)tx, input_tx, size);
+		transfer(fd, tx, rx, size);
+		free(rx);
+		free(tx);
+	} else {
+		transfer(fd, default_tx, default_rx, sizeof(default_tx));
+	}
+
+	close(fd);
+
+	return ret;
+}
-- 
2.5.0
