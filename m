From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-geni-qcom: Drop of.h include" to the spi tree
Date: Tue, 11 Feb 2020 15:51:48 +0000
Message-ID: <applied-20200204191206.97036-4-swboyd@chromium.org>
References: <20200204191206.97036-4-swboyd@chromium.org>
Cc: Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200204191206.97036-4-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-geni-qcom: Drop of.h include

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

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

>From 875014cb79ea4251e8800994640be1a8012b4133 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <swboyd@chromium.org>
Date: Tue, 4 Feb 2020 11:12:06 -0800
Subject: [PATCH] spi: spi-geni-qcom: Drop of.h include

This driver doesn't call any DT functions like of_get_property(). Remove
the of.h include as it isn't used.

Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Dilip Kota <dkota@codeaurora.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20200204191206.97036-4-swboyd@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index f0ca7f5ae714..c3972424af71 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -6,7 +6,6 @@
 #include <linux/io.h>
 #include <linux/log2.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/qcom-geni-se.h>
-- 
2.20.1
