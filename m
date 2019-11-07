From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm-qspi: Convert to use CS GPIO descriptors" to the spi tree
Date: Thu,  7 Nov 2019 13:13:40 +0000 (GMT)
Message-ID: <20191107131340.3F28427431C3@ypsilon.sirena.org.uk>
References: <20191107044235.4864-2-chris.packham@alliedtelesis.co.nz>
Cc: bcm-kernel-feedback-list@broadcom.com, broonie@kernel.org,
        kdasu.kdev@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107044235.4864-2-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: bcm-qspi: Convert to use CS GPIO descriptors

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From 27fb2313f28d8c82adace68bf49f12fe810ba58c Mon Sep 17 00:00:00 2001
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Thu, 7 Nov 2019 17:42:34 +1300
Subject: [PATCH] spi: bcm-qspi: Convert to use CS GPIO descriptors

Set use_gpio_descriptors to true and avoid asserting the native chip
select if the spi core has done it for us.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Link: https://lore.kernel.org/r/20191107044235.4864-2-chris.packham@alliedtelesis.co.nz
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm-qspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 7a3531856491..85bad70f59e3 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -803,7 +803,8 @@ static int bcm_qspi_bspi_exec_mem_op(struct spi_device *spi,
 			return -EIO;
 
 	from = op->addr.val;
-	bcm_qspi_chip_select(qspi, spi->chip_select);
+	if (!spi->cs_gpiod)
+		bcm_qspi_chip_select(qspi, spi->chip_select);
 	bcm_qspi_write(qspi, MSPI, MSPI_WRITE_LOCK, 0);
 
 	/*
@@ -882,7 +883,8 @@ static int bcm_qspi_transfer_one(struct spi_master *master,
 	int slots;
 	unsigned long timeo = msecs_to_jiffies(100);
 
-	bcm_qspi_chip_select(qspi, spi->chip_select);
+	if (!spi->cs_gpiod)
+		bcm_qspi_chip_select(qspi, spi->chip_select);
 	qspi->trans_pos.trans = trans;
 	qspi->trans_pos.byte = 0;
 
@@ -1234,6 +1236,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	master->cleanup = bcm_qspi_cleanup;
 	master->dev.of_node = dev->of_node;
 	master->num_chipselect = NUM_CHIPSELECT;
+	master->use_gpio_descriptors = true;
 
 	qspi->big_endian = of_device_is_big_endian(dev->of_node);
 
-- 
2.20.1
