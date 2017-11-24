From: Maxime Chevallier <maxime.chevallier@smile.fr>
Subject: [PATCH] spi: a3700: Fix event detection when waiting for interrupt
Date: Fri, 24 Nov 2017 13:11:50 +0100
Message-ID: <1511525510-29964-1-git-send-email-maxime.chevallier@smile.fr>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
        gregory.clement@free-electrons.com,
        miquel.raynal@free-electrons.com,
        Maxime Chevallier <maxime.chevallier@smile.fr>
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When waiting for an interrupt event, there is a short window where
an interrupt can occur before we start waiting for it, but after
the initial flag checking.

The current implementation documents that case, but clears the wait_mask
before doing the check, making it non-effective.

The function also returns early in some cases, skipping the part where
we mask the interrupt that we waited for.

This commit reworks the function so that we correctly check for the
wait_mask before clearing it, and we always mask the interrupt if we
enabled it previously.

Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
---
 drivers/spi/spi-armada-3700.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 77fe55c..fe58685 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -333,6 +333,7 @@ static bool a3700_spi_wait_completion(struct spi_device *spi)
 {
 	struct a3700_spi *a3700_spi;
 	unsigned int timeout;
+	bool completed = true;
 	unsigned int ctrl_reg;
 	unsigned long timeout_jiffies;
 
@@ -357,10 +358,9 @@ static bool a3700_spi_wait_completion(struct spi_device *spi)
 	timeout = wait_for_completion_timeout(&a3700_spi->done,
 					      timeout_jiffies);
 
-	a3700_spi->wait_mask = 0;
 
 	if (timeout)
-		return true;
+		goto done;
 
 	/* there might be the case that right after we checked the
 	 * status bits in this routine and before start to wait for
@@ -372,12 +372,16 @@ static bool a3700_spi_wait_completion(struct spi_device *spi)
 	 */
 	ctrl_reg = spireg_read(a3700_spi, A3700_SPI_IF_CTRL_REG);
 	if (a3700_spi->wait_mask & ctrl_reg)
-		return true;
+		goto done;
 
+	/* Timeout was reached */
+	completed = false;
+done:
 	spireg_write(a3700_spi, A3700_SPI_INT_MASK_REG, 0);
 
-	/* Timeout was reached */
-	return false;
+	a3700_spi->wait_mask = 0;
+
+	return completed;
 }
 
 static bool a3700_spi_transfer_wait(struct spi_device *spi,
-- 
2.1.4
