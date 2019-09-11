From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 00/10] Speed up SPI simplex transfers on Raspberry Pi
Date: Wed, 11 Sep 2019 12:15:30 +0200
Message-ID: <cover.1568187525.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
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

Extend the BCM2835 SPI driver to handle simplex transfers internally,
thereby reducing their latency and CPU usage and obviating the need to
have the SPI core convert to full-duplex via SPI_CONTROLLER_MUST_TX/RX.


Changes since v2:

* Patch [03/10]: Round up struct spi_controller to cacheline size
  instead of putting it behind the driver-private data. (Mark Brown)

* Move patch "spi: bcm2835: Work around DONE bit erratum" to the front
  of the series to ease backporting to stable. (Mark Brown)
  (I don't think it's necessary to backport it, hence it's not marked
  for stable, but it might be autoselected by Sasha Levin's AI.)

* Add all collected Acked-by and Tested-by tags, rebase on for-5.4.


Link to v1:

https://lore.kernel.org/dmaengine/20190910112141.GM2036-GFdadSzt00ze9xe1eoZjHA@public.gmane.org/T/#t


Lukas Wunner (10):
  dmaengine: bcm2835: Allow reusable descriptors
  dmaengine: bcm2835: Allow cyclic transactions without interrupt
  spi: Guarantee cacheline alignment of driver-private data
  spi: bcm2835: Work around DONE bit erratum
  spi: bcm2835: Drop dma_pending flag
  spi: bcm2835: Cache CS register value for ->prepare_message()
  spi: bcm2835: Speed up TX-only DMA transfers by clearing RX FIFO
  dmaengine: bcm2835: Document struct bcm2835_dmadev
  dmaengine: bcm2835: Avoid accessing memory when copying zeroes
  spi: bcm2835: Speed up RX-only DMA transfers by zero-filling TX FIFO

 drivers/dma/bcm2835-dma.c |  38 +++-
 drivers/spi/spi-bcm2835.c | 407 +++++++++++++++++++++++++++++++-------
 drivers/spi/spi.c         |  11 +-
 3 files changed, 384 insertions(+), 72 deletions(-)

-- 
2.23.0
