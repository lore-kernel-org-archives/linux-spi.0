From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH 1/2] spi: tegra20-sflash: cleanup wait_for_completion return handling
Date: Sun,  1 Feb 2015 08:00:04 -0500
Message-ID: <1422795604-29004-1-git-send-email-hofrat@osadl.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

return type of wait_for_completion_timeout is unsigned long not int, this
patch adds an appropriate variable and fixes up the assignment.
As the string in dev_err already states "timeout" there
is little point in printing the 0 here.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

This patch was only compile tested with tegra_defconfig
(implies CONFIG_SPI_TEGRA20_SFLASH=y)

Patch is against 3.19.0-rc6 -next-20150130

 drivers/spi/spi-tegra20-sflash.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index b6558bb..48a7c74 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -323,6 +323,7 @@ static int tegra_sflash_transfer_one_message(struct spi_master *master,
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
 	int ret;
+	unsigned long dma_timeout;
 
 	msg->status = 0;
 	msg->actual_length = 0;
@@ -337,11 +338,11 @@ static int tegra_sflash_transfer_one_message(struct spi_master *master,
 			goto exit;
 		}
 		is_first_msg = false;
-		ret = wait_for_completion_timeout(&tsd->xfer_completion,
+		dma_timeout = wait_for_completion_timeout(&tsd->xfer_completion,
 						SPI_DMA_TIMEOUT);
-		if (WARN_ON(ret == 0)) {
+		if (WARN_ON(dma_timeout == 0)) {
 			dev_err(tsd->dev,
-				"spi trasfer timeout, err %d\n", ret);
+				"spi trasfer timeout\n");
 			ret = -EIO;
 			goto exit;
 		}
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
