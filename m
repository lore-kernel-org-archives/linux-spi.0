From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: armada-3700: fix unsigned compare than zero on irq" to the spi tree
Date: Wed, 14 Dec 2016 18:03:34 +0000
Message-ID: <E1cHDtu-0007BJ-Cm@debutante>
References: <20161213102812.9029-1-colin.king@canonical.com>
Cc: Romain Perier <romain.perier@free-electrons.com>,
        Mark Brown <broonie@kernel.org>,
        Romain Perier <romain.perier@free-electrons.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161213102812.9029-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: armada-3700: fix unsigned compare than zero on irq

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

>From f6f0083cca66e673cca6fa26b52b107b5570081d Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Tue, 13 Dec 2016 10:28:12 +0000
Subject: [PATCH] spi: armada-3700: fix unsigned compare than zero on irq

spi->irq is an unsigned integer hence the check if status is less than
zero has no effect.  Fix this by replacing spi->irq with an int irq
so the less than zero compare will correctly detect errors.

Issue found with static analysis with CoverityScan, CID1388567

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Romain Perier <romain.perier@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-armada-3700.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index e89da0af45d2..4e921782652f 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -800,7 +800,7 @@ static int a3700_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct a3700_spi *spi;
 	u32 num_cs = 0;
-	int ret = 0;
+	int irq, ret = 0;
 
 	master = spi_alloc_master(dev, sizeof(*spi));
 	if (!master) {
@@ -846,12 +846,13 @@ static int a3700_spi_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	spi->irq = platform_get_irq(pdev, 0);
-	if (spi->irq < 0) {
-		dev_err(dev, "could not get irq: %d\n", spi->irq);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "could not get irq: %d\n", irq);
 		ret = -ENXIO;
 		goto error;
 	}
+	spi->irq = irq;
 
 	init_completion(&spi->done);
 
-- 
2.11.0
