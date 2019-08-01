From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5/5] spi: Reduce kthread priority
Date: Thu, 01 Aug 2019 13:13:53 +0200
Message-ID: <20190801111541.917256884@infradead.org>
References: <20190801111348.530242235@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: mingo@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

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
---
 drivers/platform/chrome/cros_ec_spi.c |    2 +-
 drivers/spi/spi.c                     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -706,7 +706,7 @@ static int cros_ec_spi_devm_high_pri_all
 					   struct cros_ec_spi *ec_spi)
 {
 	struct sched_param sched_priority = {
-		.sched_priority = MAX_RT_PRIO - 1,
+		.sched_priority = MAX_RT_PRIO / 2,
 	};
 	int err;
 
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1434,7 +1434,7 @@ static void spi_pump_messages(struct kth
  */
 static void spi_set_thread_rt(struct spi_controller *ctlr)
 {
-	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
+	struct sched_param param = { .sched_priority = MAX_RT_PRIO / 2 };
 
 	dev_info(&ctlr->dev,
 		"will run message pump with realtime priority\n");
