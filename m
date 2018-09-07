From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pic32: remove unnecessary of_node_get()" to the spi tree
Date: Fri,  7 Sep 2018 17:09:04 +0100 (BST)
Message-ID: <20180907160904.2783D1122A6D@debutante.sirena.org.uk>
References: <1536272214-26219-1-git-send-email-khoroshilov@ispras.ru>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, linux-spi@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536272214-26219-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: pic32: remove unnecessary of_node_get()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From b9a947dd756b7af84ababa57e0524788f91a5382 Mon Sep 17 00:00:00 2001
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Fri, 7 Sep 2018 01:16:54 +0300
Subject: [PATCH] spi: pic32: remove unnecessary of_node_get()

Almost all spi drivers assign spi master->dev.of_node from
its parent platform device without additional refcounting.
It seems of_node_get() in pic32_spi_probe() is unnecessary
and there is no corresponding of_node_put().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pic32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index f8a45af1fa9f..46ff76193ee1 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -774,7 +774,7 @@ static int pic32_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_master;
 
-	master->dev.of_node	= of_node_get(pdev->dev.of_node);
+	master->dev.of_node	= pdev->dev.of_node;
 	master->mode_bits	= SPI_MODE_3 | SPI_MODE_0 | SPI_CS_HIGH;
 	master->num_chipselect	= 1; /* single chip-select */
 	master->max_speed_hz	= clk_get_rate(pic32s->clk);
-- 
2.19.0.rc1
