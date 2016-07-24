From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pic32-sqi: fixup wait_for_completion_timeout return handling" to the spi tree
Date: Sun, 24 Jul 2016 22:06:49 +0100
Message-ID: <E1bRQbp-0004CG-G7@debutante>
References: <1469300915-30903-1-git-send-email-hofrat@osadl.org>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469300915-30903-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: pic32-sqi: fixup wait_for_completion_timeout return handling

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

>From 33d5097dbf650b84238c6ebdfea4a335f64f9608 Mon Sep 17 00:00:00 2001
From: Nicholas Mc Guire <hofrat@osadl.org>
Date: Sat, 23 Jul 2016 21:08:35 +0200
Subject: [PATCH] spi: pic32-sqi: fixup wait_for_completion_timeout return
 handling

wait_for_completion_timeout returns unsigned long not int so the check for
<= 0 should be == 0 here, and the type unsigned long. The function return
is set to -ETIMEDOUT to reflect the actual problem.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pic32-sqi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index ca3c8d94b290..c41abddab318 100644
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
2.8.1
