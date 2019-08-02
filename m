From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Reduce kthread priority" to the spi tree
Date: Fri,  2 Aug 2019 12:22:09 +0100 (BST)
Message-ID: <20190802112209.5A97A2742E8F@ypsilon.sirena.org.uk>
References: <20190801111541.917256884@infradead.org>
Cc: Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mingo@kernel.org,
        Peter Zijlstra (Intel) <peterz@infradead.org>,
        peterz@infradead.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801111541.917256884@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Reduce kthread priority

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

>From 4ff13d00ebd5533947b083c66d44da3243a2d559 Mon Sep 17 00:00:00 2001
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 1 Aug 2019 13:13:53 +0200
Subject: [PATCH] spi: Reduce kthread priority

The SPI thingies request FIFO-99 by default, reduce this to FIFO-50.

FIFO-99 is the very highest priority available to SCHED_FIFO and
it not a suitable default; it would indicate the SPI work is the
most important work on the machine.

Cc: Benson Leung <bleung@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20190801111541.917256884@infradead.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/platform/chrome/cros_ec_spi.c | 2 +-
 drivers/spi/spi.c                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 006a8ff64057..714306bc3f79 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -706,7 +706,7 @@ static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
 					   struct cros_ec_spi *ec_spi)
 {
 	struct sched_param sched_priority = {
-		.sched_priority = MAX_RT_PRIO - 1,
+		.sched_priority = MAX_RT_PRIO / 2,
 	};
 	int err;
 
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9fd7926e80c0..8e83c9567353 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1434,7 +1434,7 @@ static void spi_pump_messages(struct kthread_work *work)
  */
 static void spi_set_thread_rt(struct spi_controller *ctlr)
 {
-	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
+	struct sched_param param = { .sched_priority = MAX_RT_PRIO / 2 };
 
 	dev_info(&ctlr->dev,
 		"will run message pump with realtime priority\n");
-- 
2.20.1
