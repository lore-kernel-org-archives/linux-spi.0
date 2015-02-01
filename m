From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] spi: tegra114: cleanup wait_for_completion return handling
Date: Sun,  1 Feb 2015 08:55:11 -0500
Message-ID: <1422798911-1626-1-git-send-email-hofrat@osadl.org>
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
As the string in dev_err already explicitly states "timeout" there
is little point in printing the 0 here which also just says "timeout".

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

This patch was only compile tested with tegra_defconfig
(implies CONFIG_SPI_TEGRA114=y)

Patch is against 3.19.0-rc6 -next-20150130

 drivers/spi/spi-tegra114.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 73779ce..0dfb422 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -807,6 +807,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
 	int ret;
+	unsigned long dma_timeout;
 	bool skip = false;
 
 	msg->status = 0;
@@ -833,11 +834,10 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 		}
 
 		is_first_msg = false;
-		ret = wait_for_completion_timeout(&tspi->xfer_completion,
-						SPI_DMA_TIMEOUT);
-		if (WARN_ON(ret == 0)) {
-			dev_err(tspi->dev,
-				"spi trasfer timeout, err %d\n", ret);
+		dma_timeout = wait_for_completion_timeout(
+				&tspi->xfer_completion, SPI_DMA_TIMEOUT);
+		if (WARN_ON(dma_timeout == 0)) {
+			dev_err(tspi->dev, "spi trasfer timeout\n");
 			ret = -EIO;
 			goto complete_xfer;
 		}
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
