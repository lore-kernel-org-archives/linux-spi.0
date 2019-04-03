From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: gpio: Drop unused spi_to_pdata()" to the spi tree
Date: Wed,  3 Apr 2019 05:42:36 +0100 (BST)
Message-ID: <20190403044236.A56CF440082@finisterre.ee.mobilebroadband>
References: <20190403040133.1459-2-andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403040133.1459-2-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: gpio: Drop unused spi_to_pdata()

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

>From 4d9f8fed42694016b015cbfe201effe8aff0d1b3 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:22 -0700
Subject: [PATCH] spi: gpio: Drop unused spi_to_pdata()

Spi_to_pdata() is not used anywhere in the code. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 53b35c56a557..675fd65ebf1d 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -96,12 +96,6 @@ spi_to_spi_gpio(const struct spi_device *spi)
 	return spi_gpio;
 }
 
-static inline struct spi_gpio_platform_data *__pure
-spi_to_pdata(const struct spi_device *spi)
-{
-	return &spi_to_spi_gpio(spi)->pdata;
-}
-
 /* These helpers are in turn called by the bitbang inlines */
 static inline void setsck(const struct spi_device *spi, int is_on)
 {
-- 
2.20.1
