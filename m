From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.22-rc2-git] SPI: add 3wire mode flag
Date: Tue, 22 May 2007 12:42:48 -0700
Message-ID: <200705221242.49050.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Kaiwan N Billimoria <kaiwan-IEKcLuOed2vyqGx8YZ3XskEOCMrvLtNR@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Add a new spi->mode bit:  SPI_3WIRE, for chips where the SI and SO signals
are shared (and which are thus only half duplex).  Update the LM70 driver
to require support for that hardware mode from the controller.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/hwmon/lm70.c    |    4 ++++
 include/linux/spi/spi.h |    1 +
 2 files changed, 5 insertions(+)

--- g26.orig/include/linux/spi/spi.h	2007-05-22 08:59:25.000000000 -0700
+++ g26/include/linux/spi/spi.h	2007-05-22 09:07:52.000000000 -0700
@@ -76,6 +76,7 @@ struct spi_device {
 #define	SPI_MODE_3	(SPI_CPOL|SPI_CPHA)
 #define	SPI_CS_HIGH	0x04			/* chipselect active high? */
 #define	SPI_LSB_FIRST	0x08			/* per-word bits-on-wire */
+#define	SPI_3WIRE	0x10			/* SI/SO signals shared */
 	u8			bits_per_word;
 	int			irq;
 	void			*controller_state;
--- g26.orig/drivers/hwmon/lm70.c	2007-05-22 09:00:24.000000000 -0700
+++ g26/drivers/hwmon/lm70.c	2007-05-22 09:06:44.000000000 -0700
@@ -96,6 +96,10 @@ static int __devinit lm70_probe(struct s
 	struct lm70 *p_lm70;
 	int status;
 
+	/* signaling is SPI_MODE_0 on a 3-wire link (shared SI/SO) */
+	if ((spi->mode & (SPI_CPOL|SPI_CPHA)) || !spi->mode & SPI_3WIRE)
+		return -EINVAL;
+
 	p_lm70 = kzalloc(sizeof *p_lm70, GFP_KERNEL);
 	if (!p_lm70)
 		return -ENOMEM;

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
