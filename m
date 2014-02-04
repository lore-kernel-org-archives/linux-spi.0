From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 08/17] spi: pl022: Fully gate clocks at request inactivity
Date: Tue,  4 Feb 2014 16:58:49 +0100
Message-ID: <1391529538-21685-9-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Cc: Alessandro Rubini <rubini@unipv.it>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	Chris Ball <chris@printf.net>, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
To: Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use clk_disable_unprepare and clk_prepare_enable from the runtime PM
callbacks, to fully gate|ungate clocks. Potentially this will save more
power, depending on the clock tree for the current SOC.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/spi/spi-pl022.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index db829a1..2bb238f 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2355,7 +2355,7 @@ static int pl022_runtime_suspend(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
 
-	clk_disable(pl022->clk);
+	clk_disable_unprepare(pl022->clk);
 	pinctrl_pm_select_idle_state(dev);
 
 	return 0;
@@ -2366,7 +2366,7 @@ static int pl022_runtime_resume(struct device *dev)
 	struct pl022 *pl022 = dev_get_drvdata(dev);
 
 	pinctrl_pm_select_default_state(dev);
-	clk_enable(pl022->clk);
+	clk_prepare_enable(pl022->clk);
 
 	return 0;
 }
-- 
1.7.9.5

