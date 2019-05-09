From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] spi: Allow selecting BCM2835 SPI controllers on ARCH_BRCMSTB
Date: Thu,  9 May 2019 13:36:00 -0700
Message-ID: <20190509203600.6867-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: stefan.wahren@i2se.com, Florian Fainelli <f.fainelli@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>, eric@anholt.net,
 Mark Brown <broonie@kernel.org>, bcm-kernel-feedback-list@Broadcom.com,
 wahrenst@gmx.net
To: linux-arm-kernel@lists.infradead.org
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

ARCH_BRCMSTB platforms have the BCM2835 SPI controllers (normal and
auxiliary), allow selecting the two drivers on such platforms.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/spi/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 0fba8f400c59..3ee152feee2b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -119,7 +119,7 @@ config SPI_AXI_SPI_ENGINE
 config SPI_BCM2835
 	tristate "BCM2835 SPI controller"
 	depends on GPIOLIB
-	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on ARCH_BCM2835 || ARCH_BRCMSTB || COMPILE_TEST
 	help
 	  This selects a driver for the Broadcom BCM2835 SPI master.
 
@@ -130,7 +130,7 @@ config SPI_BCM2835
 
 config SPI_BCM2835AUX
 	tristate "BCM2835 SPI auxiliary controller"
-	depends on (ARCH_BCM2835 && GPIOLIB) || COMPILE_TEST
+	depends on ((ARCH_BCM2835 || ARCH_BRCMSTB) && GPIOLIB) || COMPILE_TEST
 	help
 	  This selects a driver for the Broadcom BCM2835 SPI aux master.
 
-- 
2.17.1
