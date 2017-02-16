From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rspi: Replaces "n" by "len" in qspi_transfer_*()" to the spi tree
Date: Thu, 16 Feb 2017 19:05:11 +0000
Message-ID: <E1ceRMd-0007vG-Uw@debutante>
References: <1487155852-12102-3-git-send-email-cv-dong@jinso.co.jp>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        geert+renesas@glider.be, linux-spi@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
        ryusuke.sakato.bx@renesas.com, linux-renesas-soc@vger.kernel.org,
        nv-dung@jinso.co.jp, h-inayoshi@jinso.co.jp, cm-hiep@jinso.co.jp,
        linux-spi@vger.kernel.org
To: DongCV <cv-dong@jinso.co.jp>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1487155852-12102-3-git-send-email-cv-dong@jinso.co.jp>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: rspi: Replaces "n" by "len" in qspi_transfer_*()

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

>From ad16d4a83ddc86151b4a6efe257ba74eb30f9f8e Mon Sep 17 00:00:00 2001
From: DongCV <cv-dong@jinso.co.jp>
Date: Wed, 15 Feb 2017 19:50:52 +0900
Subject: [PATCH] spi: rspi: Replaces "n" by "len" in qspi_transfer_*()

This patch replaced "n" by "len" bytes of data in qspi_transfer_in() and
qspi_transfer_out() function. This will make improving readability.

Signed-off-by: DongCV <cv-dong@jinso.co.jp>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 2ee130138066..bc3c8686f4d9 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -808,7 +808,7 @@ static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
 			for (i = 0; i < len; i++)
 				rspi_write_data(rspi, *tx++);
 		} else {
-			ret = rspi_pio_transfer(rspi, tx, NULL, n);
+			ret = rspi_pio_transfer(rspi, tx, NULL, len);
 			if (ret < 0)
 				return ret;
 		}
@@ -845,7 +845,7 @@ static int qspi_transfer_in(struct rspi_data *rspi, struct spi_transfer *xfer)
 			for (i = 0; i < len; i++)
 				*rx++ = rspi_read_data(rspi);
 		} else {
-			ret = rspi_pio_transfer(rspi, NULL, rx, n);
+			ret = rspi_pio_transfer(rspi, NULL, rx, len);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.11.0
