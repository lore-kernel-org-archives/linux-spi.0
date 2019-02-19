From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] spi: pxa2xx: Setup maximum supported DMA transfer length
Date: Tue, 19 Feb 2019 23:21:28 +0300
Message-ID: <20190219202128.24993-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

When the commit b6ced294fb61

   ("spi: pxa2xx: Switch to SPI core DMA mapping functionality")

switches to SPI core provided DMA helpers, it missed to setup maximum
supported DMA transfer length for the controller and thus users
mistakenly try to send more data than supported with the following
warning:

  ili9341 spi-PRP0001:01: DMA disabled for transfer length 153600 greater than 65536

Setup maximum supported DMA transfer length in order to make users know
the limit.

Fixes: b6ced294fb61 ("spi: pxa2xx: Switch to SPI core DMA mapping functionality")
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 3458912b4efa..a90d0d5b18a5 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1711,6 +1711,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 			platform_info->enable_dma = false;
 		} else {
 			master->can_dma = pxa2xx_spi_can_dma;
+			master->max_dma_len = MAX_DMA_LEN;
 		}
 	}
 
-- 
2.20.1
