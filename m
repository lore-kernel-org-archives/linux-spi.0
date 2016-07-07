From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pxa2xx: Clear all RFT bits in reset_sccr1() on Intel Quark" to the spi tree
Date: Thu, 07 Jul 2016 12:01:34 +0200
Message-ID: <E1bL67i-0000rX-MS@finisterre>
References: <1467796091-142927-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-spi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1467796091-142927-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: pxa2xx: Clear all RFT bits in reset_sccr1() on Intel Quark

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

>From 152bc19e2fc2b7fce7ffbc2a9cea94b147223702 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 6 Jul 2016 12:08:11 +0300
Subject: [PATCH] spi: pxa2xx: Clear all RFT bits in reset_sccr1() on Intel
 Quark

It seems the commit e5262d0568dc ("spi: spi-pxa2xx: SPI support for Intel Quark
X1000") misses one place to be adapted for Intel Quark, i.e. in reset_sccr1().

Clear all RFT bits when call reset_sccr1() on Intel Quark.

Fixes: e5262d0568dc ("spi: spi-pxa2xx: SPI support for Intel Quark X1000")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-pxa2xx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index fe07c0592b44..daf28443b7ad 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -585,7 +585,14 @@ static void reset_sccr1(struct driver_data *drv_data)
 	u32 sccr1_reg;
 
 	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1) & ~drv_data->int_cr1;
-	sccr1_reg &= ~SSCR1_RFT;
+	switch (drv_data->ssp_type) {
+	case QUARK_X1000_SSP:
+		sccr1_reg &= ~QUARK_X1000_SSCR1_RFT;
+		break;
+	default:
+		sccr1_reg &= ~SSCR1_RFT;
+		break;
+	}
 	sccr1_reg |= chip->threshold;
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
 }
-- 
2.8.1
