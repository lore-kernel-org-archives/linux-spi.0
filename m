From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] spi: butterfly: remove multiple blank lines
Date: Wed,  2 Dec 2015 19:17:48 +0530
Message-ID: <1449064071-4915-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

checkpatch complains about multiple blank lines.

Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
---
 drivers/spi/spi-butterfly.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/spi/spi-butterfly.c b/drivers/spi/spi-butterfly.c
index 9a95862..f520eaa 100644
--- a/drivers/spi/spi-butterfly.c
+++ b/drivers/spi/spi-butterfly.c
@@ -27,7 +27,6 @@
 
 #include <linux/mtd/partitions.h>
 
-
 /*
  * This uses SPI to talk with an "AVR Butterfly", which is a $US20 card
  * with a battery powered AVR microcontroller and lots of goodies.  You
@@ -37,7 +36,6 @@
  * and use this custom parallel port cable.
  */
 
-
 /* DATA output bits (pins 2..9 == D0..D7) */
 #define	butterfly_nreset (1 << 1)		/* pin 3 */
 
@@ -52,14 +50,11 @@
 /* CONTROL output bits */
 #define	spi_cs_bit	PARPORT_CONTROL_SELECT	/* pin 17 */
 
-
-
 static inline struct butterfly *spidev_to_pp(struct spi_device *spi)
 {
 	return spi->controller_data;
 }
 
-
 struct butterfly {
 	/* REVISIT ... for now, this must be first */
 	struct spi_bitbang	bitbang;
@@ -140,7 +135,6 @@ static void butterfly_chipselect(struct spi_device *spi, int value)
 	parport_frob_control(pp->port, spi_cs_bit, value ? spi_cs_bit : 0);
 }
 
-
 /* we only needed to implement one mode here, and choose SPI_MODE_0 */
 
 #define spidelay(X)	do { } while (0)
@@ -186,7 +180,6 @@ static struct flash_platform_data flash = {
 	.nr_parts	= ARRAY_SIZE(partitions),
 };
 
-
 /* REVISIT remove this ugly global and its "only one" limitation */
 static struct butterfly *butterfly;
 
@@ -262,7 +255,6 @@ static void butterfly_attach(struct parport *p)
 	parport_write_data(pp->port, pp->lastbyte);
 	msleep(100);
 
-
 	/*
 	 * Start SPI ... for now, hide that we're two physical busses.
 	 */
@@ -334,7 +326,6 @@ static struct parport_driver butterfly_driver = {
 	.detach =	butterfly_detach,
 };
 
-
 static int __init butterfly_init(void)
 {
 	return parport_register_driver(&butterfly_driver);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
