From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V2 4/6] spi: bcm2835: make the polling duration limits
 configurable
Date: Tue, 23 Apr 2019 20:15:11 +0000
Message-ID: <20190423201513.8073-5-kernel@martin.sperl.org>
References: <20190423201513.8073-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
 Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190423201513.8073-1-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
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

Under some circumstances the default 30 us polling limit is not optimal
and may lead to long delays because we are waiting on an interrupt.
with this patch we have the possibility to influence this policy.

So make this limit (in us) configurable via a module parameters
(but also modifyable via /sys/modules/...)

This replicates similar code found in spi-bcm2835aux.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Changelog:
  V1 -> V2: applied feedback by Stefan Wahren
            reorganized patchset
	    added extra rational, descriptions

---
 drivers/spi/spi-bcm2835.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 3140d952c03a..2d702db8689c 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -73,14 +73,18 @@

 #define BCM2835_SPI_FIFO_SIZE		64
 #define BCM2835_SPI_FIFO_SIZE_3_4	48
-#define BCM2835_SPI_POLLING_LIMIT_US	30
-#define BCM2835_SPI_POLLING_JIFFIES	2
 #define BCM2835_SPI_DMA_MIN_LENGTH	96
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)

 #define DRV_NAME	"spi-bcm2835"

+/* define polling limits */
+unsigned int polling_limit_us = 30;
+module_param(polling_limit_us, uint, 0664);
+MODULE_PARM_DESC(polling_limit_us,
+		 "time in us to run a transfer in polling mode\n");
+
 /**
  * struct bcm2835_spi - BCM2835 SPI controller
  * @regs: base address of register map
@@ -739,8 +743,8 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 	 */
 	bcm2835_wr_fifo_blind(bs, BCM2835_SPI_FIFO_SIZE);

-	/* set the timeout */
-	timeout = jiffies + BCM2835_SPI_POLLING_JIFFIES;
+	/* set the timeout to at least 2 jiffies */
+	timeout = jiffies + 2 + HZ * polling_limit_us / 1000000;

 	/* loop until finished the transfer */
 	while (bs->rx_len) {
@@ -775,8 +779,8 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 				    struct spi_transfer *tfr)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
-	unsigned long spi_hz, clk_hz, cdiv;
-	unsigned long spi_used_hz;
+	unsigned long spi_hz, clk_hz, cdiv, spi_used_hz;
+	unsigned long hz_per_byte, byte_limit;
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);

 	/* set clock */
@@ -823,9 +827,11 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	 * per byte per polling limit.  E.g., we can transfer 1 byte in 30 us
 	 * per 300,000 Hz of bus clock.
 	 */
-#define HZ_PER_BYTE ((9 * 1000000) / BCM2835_SPI_POLLING_LIMIT_US)
+	hz_per_byte = polling_limit_us ? (9 * 1000000) / polling_limit_us : 0;
+	byte_limit = hz_per_byte ? spi_used_hz / hz_per_byte : 1;
+
 	/* run in polling mode for short transfers */
-	if (tfr->len < spi_used_hz / HZ_PER_BYTE)
+	if (tfr->len < byte_limit)
 		return bcm2835_spi_transfer_one_poll(master, spi, tfr, cs);

 	/* run in dma mode if conditions are right
--
2.11.0
