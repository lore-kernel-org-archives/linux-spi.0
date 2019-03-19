From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 2/2] spi: pxa2xx: Debug print DMA burst size
Date: Tue, 19 Mar 2019 17:48:43 +0200
Message-ID: <20190319154843.74684-3-andriy.shevchenko@linux.intel.com>
References: <20190319154843.74684-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190319154843.74684-1-andriy.shevchenko@linux.intel.com>
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

It's useful during debug to see what DMA burst size is.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 461c6b796b8f..f008836f7e27 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1333,6 +1333,9 @@ static int setup(struct spi_device *spi)
 			dev_warn(&spi->dev,
 				 "in setup: DMA burst size reduced to match bits_per_word\n");
 		}
+		dev_dbg(&spi->dev,
+			"in setup: DMA burst size set to %u\n",
+			chip->dma_burst_size);
 	}
 
 	switch (drv_data->ssp_type) {
-- 
2.20.1
