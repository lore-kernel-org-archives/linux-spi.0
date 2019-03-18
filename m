From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/2] spi: pxa2xx: Adjust DMA burst size per platform
Date: Mon, 18 Mar 2019 16:41:42 +0200
Message-ID: <20190318144144.42367-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>
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

On some platforms DMA burst size is not the same as hard coded default.
Fix the driver to support them.

In v3:
- drop threshold print since it's easy to calculate constant (Jarkko)
- split one more unrelated change to a separate patch,
  but independent from this series  (Jarkko)

In v2:
- drop unrelated changes (Jarkko, Robert)
- don't include Robert's tag due to changes in the patch

Andy Shevchenko (2):
  spi: pxa2xx: Introduce DMA burst size support
  spi: pxa2xx: Debug print DMA burst size

 drivers/spi/spi-pxa2xx-dma.c   | 4 +++-
 drivers/spi/spi-pxa2xx-pci.c   | 4 ++++
 drivers/spi/spi-pxa2xx.c       | 4 ++++
 include/linux/spi/pxa2xx_spi.h | 1 +
 4 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.20.1
