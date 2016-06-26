From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: ti-qspi: spelling mistake: "trasnfers" -> "transfers"" to the spi tree
Date: Sun, 26 Jun 2016 13:03:19 +0100
Message-ID: <E1bH8mV-0002fI-7a@debutante>
References: <1466701294-8033-1-git-send-email-colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466701294-8033-1-git-send-email-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: ti-qspi: spelling mistake: "trasnfers" -> "transfers"

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

>From 77cca63acc444d0eee66d3631659831b6339c95e Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 23 Jun 2016 18:01:34 +0100
Subject: [PATCH] spi: ti-qspi: spelling mistake: "trasnfers" -> "transfers"

trivial fix to spelling mistake in dev_dbg message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ti-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 443f664534e1..e0e5c6aaa5cb 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -141,7 +141,7 @@ static int ti_qspi_setup(struct spi_device *spi)
 	u32 clk_ctrl_reg, clk_rate, clk_mask;
 
 	if (spi->master->busy) {
-		dev_dbg(qspi->dev, "master busy doing other trasnfers\n");
+		dev_dbg(qspi->dev, "master busy doing other transfers\n");
 		return -EBUSY;
 	}
 
-- 
2.8.1
