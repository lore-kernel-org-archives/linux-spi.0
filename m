From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: make sure all transfer has bits_per_word set
Date: Fri, 9 Nov 2012 14:36:45 +0530
Message-ID: <1352452005-13789-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

When spi client does the spi transfer and does not sets
the bits_per_word for each transfer then set it as default
of spi device in spi core before calling low level transfer.

Removing the similar code from spi-tegra20-slink driver as
it is not required.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
---
When reviewing the change
	[PATCH] spi: tegra: add spi driver for SLINK controller
it was suggested by Mark and Stephen that we should move the
bits_per_word setting to the core as it almost exist in all driver.
Creating this patch for doing this.

Creating teh patch 
 drivers/spi/spi-tegra20-slink.c |    3 +--
 drivers/spi/spi.c               |   11 ++++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index b8985be..07dc735 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -727,8 +727,7 @@ static int tegra_slink_start_transfer_one(struct spi_device *spi,
 	unsigned long command;
 	unsigned long command2;
 
-	bits_per_word = t->bits_per_word ? t->bits_per_word :
-					spi->bits_per_word;
+	bits_per_word = t->bits_per_word;
 	speed = t->speed_hz ? t->speed_hz : spi->max_speed_hz;
 	if (!speed)
 		speed = tspi->spi_max_frequency;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fc0da39..6891a03 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1193,6 +1193,7 @@ EXPORT_SYMBOL_GPL(spi_setup);
 static int __spi_async(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_master *master = spi->master;
+	struct spi_transfer *xfer;
 
 	/* Half-duplex links include original MicroWire, and ones with
 	 * only one data pin like SPI_3WIRE (switches direction) or where
@@ -1201,7 +1202,6 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 	 */
 	if ((master->flags & SPI_MASTER_HALF_DUPLEX)
 			|| (spi->mode & SPI_3WIRE)) {
-		struct spi_transfer *xfer;
 		unsigned flags = master->flags;
 
 		list_for_each_entry(xfer, &message->transfers, transfer_list) {
@@ -1214,6 +1214,15 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 		}
 	}
 
+	/**
+	 * Set transfer bits_per_word as spi device default if it is not
+	 * set for this transfer.
+	 */
+	list_for_each_entry(xfer, &message->transfers, transfer_list) {
+		if (!xfer->bits_per_word)
+			xfer->bits_per_word = spi->bits_per_word;
+	}
+
 	message->spi = spi;
 	message->status = -EINPROGRESS;
 	return master->transfer(spi, message);
-- 
1.7.1.1


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
