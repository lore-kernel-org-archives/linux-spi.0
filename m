From: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: [PATCH] spi: tegra: fix spelling mistake: "trasfer" -> "transfer"
Date: Sun, 23 Apr 2017 18:14:36 +0100
Message-ID: <20170423171436.6717-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>

trivial fix to spelling mistake in dbg_err messages

Signed-off-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
---
 drivers/spi/spi-tegra114.c       | 2 +-
 drivers/spi/spi-tegra20-sflash.c | 2 +-
 drivers/spi/spi-tegra20-slink.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 73779cecc3bb..08012ae5aa66 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -837,7 +837,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 						SPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
 			dev_err(tspi->dev,
-				"spi trasfer timeout, err %d\n", ret);
+				"spi transfer timeout, err %d\n", ret);
 			ret = -EIO;
 			goto complete_xfer;
 		}
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index b6558bb6f9df..2c797ee2664d 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -341,7 +341,7 @@ static int tegra_sflash_transfer_one_message(struct spi_master *master,
 						SPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
 			dev_err(tsd->dev,
-				"spi trasfer timeout, err %d\n", ret);
+				"spi transfer timeout, err %d\n", ret);
 			ret = -EIO;
 			goto exit;
 		}
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 85c91f58b42f..0c06ce424210 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -824,7 +824,7 @@ static int tegra_slink_transfer_one(struct spi_master *master,
 					  SLINK_DMA_TIMEOUT);
 	if (WARN_ON(ret == 0)) {
 		dev_err(tspi->dev,
-			"spi trasfer timeout, err %d\n", ret);
+			"spi transfer timeout, err %d\n", ret);
 		return -EIO;
 	}
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
