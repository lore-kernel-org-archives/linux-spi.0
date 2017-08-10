From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: fix 64-bit build warning" to the spi tree
Date: Thu, 10 Aug 2017 16:43:13 +0100
Message-ID: <E1dfpc9-0001ut-6M@finisterre>
References: <20170810121335.2581513-2-arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Varadarajan Narayanan <varada@codeaurora.org>,
        Matthew McClintock <mmcclint@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170810121335.2581513-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: qup: fix 64-bit build warning

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

>From 88a19814de71aafe4de4868e1e13cd8b9a06a861 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 10 Aug 2017 14:13:27 +0200
Subject: [PATCH] spi: qup: fix 64-bit build warning

On 64-bit systems, pointers are wider than 'int' variables,
so we get a warning about a cast between them:

drivers/spi/spi-qup.c:1060:23: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

This changes the code to use the correct uintptr_t cast.

Fixes: 4d023737b2ef ("spi: qup: Fix QUP version identify method")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index e9ecd67cd817..974a8ce58b68 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1057,7 +1057,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	else if (!ret)
 		master->can_dma = spi_qup_can_dma;
 
-	controller->qup_v1 = (int)of_device_get_match_data(dev);
+	controller->qup_v1 = (uintptr_t)of_device_get_match_data(dev);
 
 	if (!controller->qup_v1)
 		master->set_cs = spi_qup_set_cs;
-- 
2.13.2
