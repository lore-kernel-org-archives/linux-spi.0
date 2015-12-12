From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: davinci: use dev_err() for error reporting" to the spi tree
Date: Sat, 12 Dec 2015 23:08:07 +0000
Message-ID: <E1a7tGp-0002sx-OT@finisterre>
References: <83b3c0bb63ff958d10c773ab7bf128393cc7ddad.1449764266.git.nsekhar@ti.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <83b3c0bb63ff958d10c773ab7bf128393cc7ddad.1449764266.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: davinci: use dev_err() for error reporting

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 21c015b776d4013b656bca8a4f42b953297b8b8c Mon Sep 17 00:00:00 2001
From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Date: Thu, 10 Dec 2015 21:59:05 +0530
Subject: [PATCH] spi: davinci: use dev_err() for error reporting

Use dev_err() for reporting errors rather than
dev_dbg().

Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 57d6960..fddb7a3 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -477,33 +477,33 @@ static int davinci_spi_check_error(struct davinci_spi *dspi, int int_status)
 	struct device *sdev = dspi->bitbang.master->dev.parent;
 
 	if (int_status & SPIFLG_TIMEOUT_MASK) {
-		dev_dbg(sdev, "SPI Time-out Error\n");
+		dev_err(sdev, "SPI Time-out Error\n");
 		return -ETIMEDOUT;
 	}
 	if (int_status & SPIFLG_DESYNC_MASK) {
-		dev_dbg(sdev, "SPI Desynchronization Error\n");
+		dev_err(sdev, "SPI Desynchronization Error\n");
 		return -EIO;
 	}
 	if (int_status & SPIFLG_BITERR_MASK) {
-		dev_dbg(sdev, "SPI Bit error\n");
+		dev_err(sdev, "SPI Bit error\n");
 		return -EIO;
 	}
 
 	if (dspi->version == SPI_VERSION_2) {
 		if (int_status & SPIFLG_DLEN_ERR_MASK) {
-			dev_dbg(sdev, "SPI Data Length Error\n");
+			dev_err(sdev, "SPI Data Length Error\n");
 			return -EIO;
 		}
 		if (int_status & SPIFLG_PARERR_MASK) {
-			dev_dbg(sdev, "SPI Parity Error\n");
+			dev_err(sdev, "SPI Parity Error\n");
 			return -EIO;
 		}
 		if (int_status & SPIFLG_OVRRUN_MASK) {
-			dev_dbg(sdev, "SPI Data Overrun error\n");
+			dev_err(sdev, "SPI Data Overrun error\n");
 			return -EIO;
 		}
 		if (int_status & SPIFLG_BUF_INIT_ACTIVE_MASK) {
-			dev_dbg(sdev, "SPI Buffer Init Active\n");
+			dev_err(sdev, "SPI Buffer Init Active\n");
 			return -EBUSY;
 		}
 	}
-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
