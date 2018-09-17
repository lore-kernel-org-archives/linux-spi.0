From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] spi: Gracefully handle power supplies with disabled PM
Date: Mon, 17 Sep 2018 14:10:41 +0200
Message-ID: <20180917121041.21084-1-lkundrak@v3.sk>
Cc: linux-spi@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This allows use of SPI when power management is disables, such as on
early boot;

See also: commit 31eb74318054 ("PM / runtime: Fix handling of suppliers
with disabled runtime PM")

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ec395a6baf9c..6546564e41d0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1212,7 +1212,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 
 	if (!was_busy && ctlr->auto_runtime_pm) {
 		ret = pm_runtime_get_sync(ctlr->dev.parent);
-		if (ret < 0) {
+		if (ret < 0 && ret != -EACCES) {
 			pm_runtime_put_noidle(ctlr->dev.parent);
 			dev_err(&ctlr->dev, "Failed to power device: %d\n",
 				ret);
-- 
2.17.1
