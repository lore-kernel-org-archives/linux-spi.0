From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 2/3] spi: bcm2835: avoid 64 bit arithmetic and allow to
 configure polling limit
Date: Sun, 24 Feb 2019 16:23:10 +0000
Message-ID: <20190224162311.23899-2-kernel@martin.sperl.org>
References: <20190224162311.23899-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
 Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190224162311.23899-1-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

In analogy to commit d704afffe65c ("spi: bcm2835aux: Avoid 64-bit
arithmetic in xfer len calc") avoid 64 bit calculations and make
the polling interval configurable as a module parameter.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
Note this patch requires the effective_speed_hz patch to be included

---
 drivers/spi/spi-bcm2835.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 0ccc6a2733c6..dcf922ca2603 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -38,6 +38,12 @@
 #include <linux/of_irq.h>
 #include <linux/spi/spi.h>

+/* define polling limits */
+unsigned int polling_limit_us = 30;
+module_param(polling_limit_us, uint, 0664);
+MODULE_PARM_DESC(polling_limit_us,
+		 "time in us to run a transfer in polling mode\n");
+
 /* SPI register offsets */
 #define BCM2835_SPI_CS			0x00
 #define BCM2835_SPI_FIFO		0x04
@@ -74,8 +80,6 @@

 #define BCM2835_SPI_FIFO_SIZE		64
 #define BCM2835_SPI_FIFO_SIZE_3_4	48
-#define BCM2835_SPI_POLLING_LIMIT_US	30
-#define BCM2835_SPI_POLLING_JIFFIES	2
 #define BCM2835_SPI_DMA_MIN_LENGTH	96
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)
@@ -784,8 +788,7 @@ static void bcm2835_dma_init(struct spi_master *master, struct device *dev)
 static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 					 struct spi_device *spi,
 					 struct spi_transfer *tfr,
-					 u32 cs,
-					 unsigned long long xfer_time_us)
+					 u32 cs)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	unsigned long timeout;
@@ -802,8 +805,8 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 	 */
 	bcm2835_wr_fifo_blind(bs, BCM2835_SPI_FIFO_SIZE);

-	/* set the timeout */
-	timeout = jiffies + BCM2835_SPI_POLLING_JIFFIES;
+	/* set the timeout to at least 2 jiffies */
+	timeout = jiffies + 2 + HZ * polling_limit_us / 1000000;

 	/* loop until finished the transfer */
 	while (bs->rx_len) {
@@ -840,8 +843,7 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 				    struct spi_transfer *tfr)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
-	unsigned long spi_hz, clk_hz, cdiv;
-	unsigned long long xfer_time_us;
+	unsigned long spi_hz, clk_hz, cdiv, hz_per_byte, byte_limit;
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);

 	/* set clock */
@@ -882,16 +884,18 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	bs->tx_len = tfr->len;
 	bs->rx_len = tfr->len;

-	/* calculate the estimated time in us the transfer runs */
-	xfer_time_us = (unsigned long long)tfr->len
-		* 9 /* clocks/byte - SPI-HW waits 1 clock after each byte */
-		* 1000000;
-	do_div(xfer_time_us, tfr->effective_speed_hz);
+	/* Calculate the estimated time in us the transfer runs.  Note that
+	 * there is 1 idle clocks cycles after each byte transferredo - so
+	 *  9 cycles/byte.  This is used to find the number
+	 * of Hz per byte per polling limit.  E.g., we can transfer 1 byte in
+	 * 30 us per 300,000 Hz of bus clock.
+	 */
+	hz_per_byte = polling_limit_us ? (9 * 1000000) / polling_limit_us : 0;
+	byte_limit = hz_per_byte ? tfr->effective_speed_hz / hz_per_byte : 1;

 	/* for short requests run polling*/
-	if (xfer_time_us <= BCM2835_SPI_POLLING_LIMIT_US)
-		return bcm2835_spi_transfer_one_poll(master, spi, tfr,
-						     cs, xfer_time_us);
+	if (tfr->len < byte_limit)
+		return bcm2835_spi_transfer_one_poll(master, spi, tfr, cs);

 	/* run in dma mode if conditions are right */
 	if (master->can_dma && bcm2835_spi_can_dma(master, spi, tfr))
--
2.11.0
