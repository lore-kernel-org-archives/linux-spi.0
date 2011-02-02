From: Russ Gorby <russ.gorby-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] serial: ifx6x60: expanded info available from platform data
Date: Wed,  2 Feb 2011 12:56:58 -0800
Message-ID: <1296680218-2693-2-git-send-email-russ.gorby__45126.9506979317$1296680054$gmane$org@intel.com>
References: <[PATCH 0/1] ifx6x60 expanded platform data patch: 01/26/2011>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org> (maintainer:SPI
	SUBSYSTEM),
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> (maintainer:SPI SUBSYSTEM),
	Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <[PATCH 0/1] ifx6x60 expanded platform data patch: 01/26/2011>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Some platform attributes (e.g. max_hz, use_dma) were being intuited
from the modem type. These things should be specified by the platform
data.

Added max_hz, use_dma to ifx_modem_platform_data definition,
replaced is_6160 w/ modem_type, and changed clients accordingly

Signed-off-by: Russ Gorby <russ.gorby-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/tty/serial/ifx6x60.c  |   33 +++++++++++++++++----------------
 drivers/tty/serial/ifx6x60.h  |    4 +++-
 include/linux/spi/ifx_modem.h |   19 ++++++++++++-------
 3 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index ab93763..c42de71 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -8,7 +8,7 @@
  *		      Jan Dumon <j.dumon-x9gZzRpC1QbQT0dZR+AlfA@public.gmane.org>
  *
  * Copyright (C) 2009, 2010 Intel Corp
- * Russ Gorby <richardx.r.gorby-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ * Russ Gorby <russ.gorby-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -732,7 +732,7 @@ static void ifx_spi_io(unsigned long data)
 		/*
 		 * setup dma pointers
 		 */
-		if (ifx_dev->is_6160) {
+		if (ifx_dev->use_dma) {
 			ifx_dev->spi_msg.is_dma_mapped = 1;
 			ifx_dev->tx_dma = ifx_dev->tx_bus;
 			ifx_dev->rx_dma = ifx_dev->rx_bus;
@@ -960,7 +960,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 {
 	int ret;
 	int srdy;
-	struct ifx_modem_platform_data *pl_data = NULL;
+	struct ifx_modem_platform_data *pl_data;
 	struct ifx_spi_device *ifx_dev;
 
 	if (saved_ifx_dev) {
@@ -968,6 +968,12 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
+	pl_data = (struct ifx_modem_platform_data *)spi->dev.platform_data;
+	if (!pl_data) {
+		dev_err(&spi->dev, "missing platform data!");
+		return -ENODEV;
+	}
+
 	/* initialize structure to hold our device variables */
 	ifx_dev = kzalloc(sizeof(struct ifx_spi_device), GFP_KERNEL);
 	if (!ifx_dev) {
@@ -983,7 +989,9 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	init_timer(&ifx_dev->spi_timer);
 	ifx_dev->spi_timer.function = ifx_spi_timeout;
 	ifx_dev->spi_timer.data = (unsigned long)ifx_dev;
-	ifx_dev->is_6160 = pl_data->is_6160;
+	ifx_dev->modem = pl_data->modem_type;
+	ifx_dev->use_dma = pl_data->use_dma;
+	ifx_dev->max_hz = pl_data->max_hz;
 
 	/* ensure SPI protocol flags are initialized to enable transfer */
 	ifx_dev->spi_more = 0;
@@ -1025,18 +1033,11 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 		goto error_ret;
 	}
 
-	pl_data = (struct ifx_modem_platform_data *)spi->dev.platform_data;
-	if (pl_data) {
-		ifx_dev->gpio.reset = pl_data->rst_pmu;
-		ifx_dev->gpio.po = pl_data->pwr_on;
-		ifx_dev->gpio.mrdy = pl_data->mrdy;
-		ifx_dev->gpio.srdy = pl_data->srdy;
-		ifx_dev->gpio.reset_out = pl_data->rst_out;
-	} else {
-		dev_err(&spi->dev, "missing platform data!");
-		ret = -ENODEV;
-		goto error_ret;
-	}
+	ifx_dev->gpio.reset = pl_data->rst_pmu;
+	ifx_dev->gpio.po = pl_data->pwr_on;
+	ifx_dev->gpio.mrdy = pl_data->mrdy;
+	ifx_dev->gpio.srdy = pl_data->srdy;
+	ifx_dev->gpio.reset_out = pl_data->rst_out;
 
 	dev_info(&spi->dev, "gpios %d, %d, %d, %d, %d",
 		 ifx_dev->gpio.reset, ifx_dev->gpio.po, ifx_dev->gpio.mrdy,
diff --git a/drivers/tty/serial/ifx6x60.h b/drivers/tty/serial/ifx6x60.h
index deb7b8d..0ec39b5 100644
--- a/drivers/tty/serial/ifx6x60.h
+++ b/drivers/tty/serial/ifx6x60.h
@@ -88,7 +88,9 @@ struct ifx_spi_device {
 	dma_addr_t rx_dma;
 	dma_addr_t tx_dma;
 
-	int is_6160;				/* Modem type */
+	int modem;		/* Modem type */
+	int use_dma;		/* provide dma-able addrs in SPI msg */
+	long max_hz;		/* max SPI frequency */
 
 	spinlock_t write_lock;
 	int write_pending;
diff --git a/include/linux/spi/ifx_modem.h b/include/linux/spi/ifx_modem.h
index a68f3b1..394fec9 100644
--- a/include/linux/spi/ifx_modem.h
+++ b/include/linux/spi/ifx_modem.h
@@ -2,13 +2,18 @@
 #define LINUX_IFX_MODEM_H
 
 struct ifx_modem_platform_data {
-	unsigned short rst_out; /* modem reset out */
-	unsigned short pwr_on;  /* power on */
-	unsigned short rst_pmu; /* reset modem */
-	unsigned short tx_pwr;  /* modem power threshold */
-	unsigned short srdy;    /* SRDY */
-	unsigned short mrdy;    /* MRDY */
-	unsigned short is_6160;	/* Modem type */
+	unsigned short rst_out;		/* modem reset out */
+	unsigned short pwr_on;		/* power on */
+	unsigned short rst_pmu;		/* reset modem */
+	unsigned short tx_pwr;		/* modem power threshold */
+	unsigned short srdy;		/* SRDY */
+	unsigned short mrdy;		/* MRDY */
+	unsigned char modem_type;	/* Modem type */
+	unsigned long max_hz;		/* max SPI frequency */
+	unsigned short use_dma:1;	/* spi protocol driver supplies
+					   dma-able addrs */
 };
+#define IFX_MODEM_6160	1
+#define IFX_MODEM_6260	2
 
 #endif
-- 
1.7.2.3


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
