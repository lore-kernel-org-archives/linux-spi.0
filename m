From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] SPI: fix building SPI_PXA on MMP
Date: Mon,  7 Aug 2017 17:42:55 +0200
Message-ID: <20170807154409.205269-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mika Westeberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org

When the audio driver selects CONFIG_PXA_SSP on ARCH_MMP as a
loadable module, and the PXA SPI driver is built-in, we get
a link error in the SPI driver:

drivers/spi/spi-pxa2xx.o: In function `pxa2xx_spi_remove':
spi-pxa2xx.c:(.text+0x5f0): undefined reference to `pxa_ssp_free'
drivers/spi/spi-pxa2xx.o: In function `pxa2xx_spi_probe':
spi-pxa2xx.c:(.text+0xeac): undefined reference to `pxa_ssp_request'
spi-pxa2xx.c:(.text+0x1468): undefined reference to `pxa_ssp_free'
spi-pxa2xx.c:(.text+0x15bc): undefined reference to `pxa_ssp_free'

The problem is that the PXA SPI driver only uses 'select SSP'
specifically when building it for PXA, but we can also build it
for PCI, which is meant for Intel x86 SoCs that use the same SPI
block. When the sound driver forces the SSP to be a loadable
module, the IS_ENABLED() check in include/linux/pxa2xx_ssp.h
triggers but the spi driver can't reference the exported symbols.

I had a different approach before, making the PCI case depend
on X86, which fixed the problem by avoiding the MMP case.

This goes a different route, making the driver select PXA_SSP
also on MMP, which has an SSP that none of the boards in mainline
Linux use for SPI. There is no harm in always enabling the build
on MMP (PCI or not PCI), so I do that too, to document that this
hardware is actually available on MMP.

Link: https://patchwork.kernel.org/patch/8879921/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9b31351fe429..f9f9b0940746 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -518,8 +518,8 @@ config SPI_PPC4xx
 
 config SPI_PXA2XX
 	tristate "PXA2xx SSP SPI master"
-	depends on (ARCH_PXA || PCI || ACPI)
-	select PXA_SSP if ARCH_PXA
+	depends on (ARCH_PXA || ARCH_MMP || PCI || ACPI)
+	select PXA_SSP if ARCH_PXA || ARCH_MMP
 	help
 	  This enables using a PXA2xx or Sodaville SSP port as a SPI master
 	  controller. The driver can be configured to use any SSP port and
-- 
2.9.0
