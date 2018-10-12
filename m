From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Make GPIO CSs honour the SPI_NO_CS flag" to the spi tree
Date: Fri, 12 Oct 2018 19:03:37 +0200 (CEST)
Message-ID: <20181012170337.681EC440078@finisterre.ee.mobilebroadband>
References: <1539336198-84179-1-git-send-email-phil@raspberrypi.org>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Phil Elwell <phil@raspberrypi.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539336198-84179-1-git-send-email-phil@raspberrypi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Make GPIO CSs honour the SPI_NO_CS flag

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

>From 25972d0c33deb5c49708baa48e7796c8d0348e98 Mon Sep 17 00:00:00 2001
From: Phil Elwell <phil@raspberrypi.org>
Date: Fri, 12 Oct 2018 10:23:18 +0100
Subject: [PATCH] spi: Make GPIO CSs honour the SPI_NO_CS flag

The SPI configuration state includes an SPI_NO_CS flag that disables
all CS line manipulation, for applications that want to manage their
own chip selects. However, this flag is ignored by the GPIO CS code
in the SPI framework.

Correct this omission with a trivial patch.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fcbd4cfd2818..ea3e5e146764 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -775,7 +775,9 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 		enable = !enable;
 
 	if (gpio_is_valid(spi->cs_gpio)) {
-		gpio_set_value(spi->cs_gpio, !enable);
+		/* Honour the SPI_NO_CS flag */
+		if (!(spi->mode & SPI_NO_CS))
+			gpio_set_value(spi->cs_gpio, !enable);
 		/* Some SPI masters need both GPIO CS & slave_select */
 		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
 		    spi->controller->set_cs)
-- 
2.19.0
