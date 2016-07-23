From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] spi: pic32-sqi: fixup wait_for_completion_timeout return handling
Date: Sat, 23 Jul 2016 21:08:35 +0200
Message-ID: <1469300915-30903-1-git-send-email-hofrat@osadl.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicholas Mc Guire <hofrat@osadl.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

wait_for_completion_timeout returns unsigned long not int so the check for
<= 0 should be == 0 here, and the type unsigned long. The function return
is set to -ETIMEDOUT to reflect the actual problem.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

the only call site of pic32_sqi_one_messag() is in
drivers/spi/spi.c:__spi_pump_messages() (via struct spi_master
master->transfer_one_message) which is checking for non-zero
return only so technically -EIO is fine, for consistency this
should probably be -ETIMEDOUT though.

Compile tested with: pic32mzda_defconfig + CONFIG_SPI=y,
CONFIG_SPI_PIC32_SQI=m

Patch is against 4.7.0-rc7 (localversion-next -next-20160719)

 drivers/spi/spi-pic32-sqi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index ca3c8d9..c41abdd 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -354,6 +354,7 @@ static int pic32_sqi_one_message(struct spi_master *master,
 	struct spi_transfer *xfer;
 	struct pic32_sqi *sqi;
 	int ret = 0, mode;
+	unsigned long timeout;
 	u32 val;
 
 	sqi = spi_master_get_devdata(master);
@@ -419,10 +420,10 @@ static int pic32_sqi_one_message(struct spi_master *master,
 	writel(val, sqi->regs + PESQI_BD_CTRL_REG);
 
 	/* wait for xfer completion */
-	ret = wait_for_completion_timeout(&sqi->xfer_done, 5 * HZ);
-	if (ret <= 0) {
+	timeout = wait_for_completion_timeout(&sqi->xfer_done, 5 * HZ);
+	if (timeout == 0) {
 		dev_err(&sqi->master->dev, "wait timedout/interrupted\n");
-		ret = -EIO;
+		ret = -ETIMEDOUT;
 		msg->status = ret;
 	} else {
 		/* success */
-- 
2.1.4
