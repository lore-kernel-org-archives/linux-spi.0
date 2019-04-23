From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V2 5/6] spi: bcm2835: make the lower limit for dma mode
 configurable
Date: Tue, 23 Apr 2019 20:15:12 +0000
Message-ID: <20190423201513.8073-6-kernel@martin.sperl.org>
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

Under some circumstances the default 96 byte limit is not optimal.

The polling and interrupt mode of the spi-bcm2835 controller exhibit a
1 idle clock cycle which is missing when using DMA.

So when transferring a longer spi_transfer to some low spec MCU devices
without SPI FIFOs like a ATMega it means that the SPI has to get reduced
by a factor of 2 or more when using DMA mode compared to using PIO modes
to give the MCU enough time to handle the incoming spi byte and prepare
the next byte to get delivered - these extra 4+ CPU cycles that the idle
spi clock is providing allows bigger transfers to work at faster speeds
(assuming highly optimized MCU code).
So forcing the transfer to use PIO mode to geth this behaviour for
longer transfers is of advantage.

The oposite is true when (ab)using the spi MOSI line alone to control a
WS2812B RGB LED stripe, where the DMA mode makes it possible to use the
MOSI lines alone (with correct encoding) to control the LED.

So both extremes have there use cases and with this patch we allow to
control the policy on a controller wide basis.

Right now we only allow to control the limit on a controller wide basis,
but in the future it may be possible to configure this on a per spi_device
basis.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 2d702db8689c..755e1e6d2252 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -73,7 +73,6 @@
 
 #define BCM2835_SPI_FIFO_SIZE		64
 #define BCM2835_SPI_FIFO_SIZE_3_4	48
-#define BCM2835_SPI_DMA_MIN_LENGTH	96
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)
 
@@ -85,6 +84,12 @@ module_param(polling_limit_us, uint, 0664);
 MODULE_PARM_DESC(polling_limit_us,
 		 "time in us to run a transfer in polling mode\n");
 
+/* define minimum transfer length for which we may use DMA */
+unsigned int dma_min_bytes_limit = 96;
+module_param(dma_min_bytes_limit, uint, 0664);
+MODULE_PARM_DESC(dma_min_bytes_limit,
+		 "minimum number of bytes to run a transfer in dma mode - 0 disables dma-mode completely\n");
+
 /**
  * struct bcm2835_spi - BCM2835 SPI controller
  * @regs: base address of register map
@@ -631,7 +636,7 @@ static bool bcm2835_spi_can_dma(struct spi_master *master,
 				struct spi_transfer *tfr)
 {
 	/* we start DMA efforts only on bigger transfers */
-	if (tfr->len < BCM2835_SPI_DMA_MIN_LENGTH)
+	if (!dma_min_bytes_limit || tfr->len < dma_min_bytes_limit)
 		return false;
 
 	/* BCM2835_SPI_DLEN has defined a max transfer size as
-- 
2.11.0
