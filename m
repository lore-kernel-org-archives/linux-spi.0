From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] spi: bcm53xx: use msecs_to_jiffies for conversion
Date: Sun,  8 Feb 2015 10:11:05 -0500
Message-ID: <1423408265-23116-1-git-send-email-hofrat@osadl.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicholas Mc Guire <hofrat@osadl.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Converting milliseconds to jiffies by "val * HZ / 1000" is technically
ok but msecs_to_jiffies(val) is the cleaner solution and handles all
corner cases correctly. 

This is only an API consolidation and should make things more readable

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Patch was compile-tested only with

Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)

 drivers/spi/spi-bcm53xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm53xx.c b/drivers/spi/spi-bcm53xx.c
index 17b34cb..1933ef3 100644
--- a/drivers/spi/spi-bcm53xx.c
+++ b/drivers/spi/spi-bcm53xx.c
@@ -44,7 +44,7 @@ static int bcm53xxspi_wait(struct bcm53xxspi *b53spi, unsigned int timeout_ms)
 	u32 tmp;
 
 	/* SPE bit has to be 0 before we read MSPI STATUS */
-	deadline = jiffies + BCM53XXSPI_SPE_TIMEOUT_MS * HZ / 1000;
+	deadline = jiffies + msecs_to_jiffies(BCM53XXSPI_SPE_TIMEOUT_MS);
 	do {
 		tmp = bcm53xxspi_read(b53spi, B53SPI_MSPI_SPCR2);
 		if (!(tmp & B53SPI_MSPI_SPCR2_SPE))
@@ -56,7 +56,7 @@ static int bcm53xxspi_wait(struct bcm53xxspi *b53spi, unsigned int timeout_ms)
 		goto spi_timeout;
 
 	/* Check status */
-	deadline = jiffies + timeout_ms * HZ / 1000;
+	deadline = jiffies + msecs_to_jiffies(timeout_ms);
 	do {
 		tmp = bcm53xxspi_read(b53spi, B53SPI_MSPI_MSPI_STATUS);
 		if (tmp & B53SPI_MSPI_MSPI_STATUS_SPIF) {
-- 
1.7.10.4
