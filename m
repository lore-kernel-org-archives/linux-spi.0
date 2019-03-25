From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: atmel-quadspi: Make atmel_qspi_get_name static" to the spi tree
Date: Mon, 25 Mar 2019 12:22:34 +0000 (GMT)
Message-ID: <20190325122234.3BA8011288F1@debutante.sirena.org.uk>
References: <20190321151656.16816-1-yuehaibing@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321151656.16816-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: atmel-quadspi: Make atmel_qspi_get_name static

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

>From 55e3dacaf538745b7d57dce43b9950687ff878ab Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 21 Mar 2019 23:16:56 +0800
Subject: [PATCH] spi: atmel-quadspi: Make atmel_qspi_get_name static

Fix sparse warning:

drivers/spi/atmel-quadspi.c:369:12: warning:
 symbol 'atmel_qspi_get_name' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index fffc21cd5f79..e54109759d34 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -366,7 +366,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	return err;
 }
 
-const char *atmel_qspi_get_name(struct spi_mem *spimem)
+static const char *atmel_qspi_get_name(struct spi_mem *spimem)
 {
 	return dev_name(spimem->spi->dev.parent);
 }
-- 
2.20.1
