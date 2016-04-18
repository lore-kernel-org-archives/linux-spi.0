From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dln2: Pass of_node to spi master" to the spi tree
Date: Mon, 18 Apr 2016 14:11:09 +0100
Message-ID: <E1as8xJ-00026C-ER@debutante>
References: <692686e5329a437499fbfb2c235e049979b415a3.1460722225.git.leonard.crestez@intel.com>
Cc: Laurentiu Palcu <laurentiu.palcu@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>,
	Laurentiu Palcu <laurentiu.palcu@intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <692686e5329a437499fbfb2c235e049979b415a3.1460722225.git.leonard.crestez@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: dln2: Pass of_node to spi master

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

>From 83835fb07836eac1b35e98b919bf757ff7f77aad Mon Sep 17 00:00:00 2001
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Date: Fri, 15 Apr 2016 15:10:52 +0300
Subject: [PATCH] spi: dln2: Pass of_node to spi master

This allows defining SPI devices connected to a DLN2 using devicetree.

This already works for i2c because of a similar patch:
3b10db23: i2c: dln2: set the device tree node of the adapter

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Acked-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dln2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index 3b7d91d94fea..4e8a8629d514 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -683,6 +683,7 @@ static int dln2_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct dln2_spi *dln2;
 	struct dln2_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
 	int ret;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*dln2));
@@ -700,6 +701,8 @@ static int dln2_spi_probe(struct platform_device *pdev)
 	}
 
 	dln2->master = master;
+	dln2->master->dev.parent = dev;
+	dln2->master->dev.of_node = dev->of_node;
 	dln2->pdev = pdev;
 	dln2->port = pdata->port;
 	/* cs/mode can never be 0xff, so the first transfer will set them */
-- 
2.8.0.rc3
