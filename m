From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: atmel: fix gpio chip-select in case of non-DT platform" to the spi tree
Date: Thu, 28 Jan 2016 23:52:19 +0100
Message-ID: <E1aOvQJ-00049b-1c@finisterre>
References: <1453913312-18108-1-git-send-email-nicolas.ferre@atmel.com>
Cc: linux-spi@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>,
	Cyrille Pitchen <cyrille.pitchen@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Mans Rullgard <mans@mansr.com>,
	Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1453913312-18108-1-git-send-email-nicolas.ferre@atmel.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: atmel: fix gpio chip-select in case of non-DT platform

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

>From 70f340df24518d36eeaefb6652d492f250115c19 Mon Sep 17 00:00:00 2001
From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Date: Wed, 27 Jan 2016 17:48:32 +0100
Subject: [PATCH] spi: atmel: fix gpio chip-select in case of non-DT platform

The non-DT platform that uses this driver (actually the AVR32) was taking a bad
branch for determining if the IP would use gpio for CS.
Adding the presence of DT as a condition fixes this issue.

Fixes: 4820303480a1 ("spi: atmel: add support for the internal chip-select of the spi controller")
Reported-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
[nicolas.ferre@atmel.com: extract from ml discussion]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Tested-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-atmel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index aebad36..8feac59 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1571,6 +1571,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 
 	as->use_cs_gpios = true;
 	if (atmel_spi_is_v2(as) &&
+	    pdev->dev.of_node &&
 	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
 		as->use_cs_gpios = false;
 		master->num_chipselect = 4;
-- 
2.6.4
