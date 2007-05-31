From: "Andrea Paterniani" <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
Subject: [patch 2.6.22-rc3] SPI -- Freescale iMX SPI
	controller driver
Date: Thu, 31 May 2007 12:33:17 +0200
Message-ID: <FLEPLOLKEPNLMHOILNHPKEHEDHAA.a.paterniani@swapp-eng.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: camilo.id-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: "Linux ARM Kernel" <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>,
	"Andrew Morton" <akpm-3NddpPZAyC0@public.gmane.org>, <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	"SPI Devel General" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	<camilo.id-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Subject: [patch-2.6.22-rc3-spi_imx] arm: SPI controller driver for Freescale iMX
From: Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>

Kernel version: linux-2.6.22-rc3.
This is patch fixes 2 bugs:
> SPI_DMA_RHDMA bad value.
> Missing return value in setup() function (lost passing from
patch-2.6.20-rc4-spi_imx to patch-2.6.20-rc6-spi_imx).

Signed-off-by: Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
---

diff -uprN -X linux-2.6.22-rc3/Documentation/dontdiff linux-2.6.22-rc3/drivers/spi/spi_imx.c
linux-2.6.22-rc3-spi_imx/drivers/spi/spi_imx.c
--- linux-2.6.22-rc3/drivers/spi/spi_imx.c	2007-04-26 05:08:32.000000000 +0200
+++ linux-2.6.22-rc3-spi_imx/drivers/spi/spi_imx.c	2007-05-31 12:09:07.000000000 +0200
@@ -121,7 +121,7 @@
 							32.768 KHz Clock */

 /* SPI DMA Register Bit Fields & Masks */
-#define SPI_DMA_RHDMA	(0xF << 4)	/* RXFIFO Half Status */
+#define SPI_DMA_RHDMA	(0x1 << 4)	/* RXFIFO Half Status */
 #define SPI_DMA_RFDMA	(0x1 << 5)      /* RXFIFO Full Status */
 #define SPI_DMA_TEDMA	(0x1 << 6)      /* TXFIFO Empty Status */
 #define SPI_DMA_THDMA	(0x1 << 7)      /* TXFIFO Half Status */
@@ -1355,6 +1355,7 @@ static int setup(struct spi_device *spi)
 		spi->bits_per_word,
 		spi_speed_hz(SPI_CONTROL_DATARATE_MIN),
 		spi->max_speed_hz);
+	return status;

 err_first_setup:
 	kfree(chip);


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
