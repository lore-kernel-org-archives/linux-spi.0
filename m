From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] spi: pl08x: do not select S3C64XX_PL080
Date: Wed, 28 Jan 2015 14:27:06 +0100
Message-ID: <2608153.sC21ihDxEF@wuerfel>
References: <1957186.KORYFIrP42@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, linux-samsung-soc@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1957186.KORYFIrP42@wuerfel>
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

The pl08x driver originally selected S3C64XX_PL080 to avoid having
the legacy Samsung DMA interfaces. Those are now gone, so the
select is no longer needed, but it now causes problems when
CONFIG_DMA_ENGINE is disabled:

arch/arm/plat-samsung/built-in.o: In function `s3c64xx_spi0_set_platdata':
:(.init.text+0x518): undefined reference to `pl08x_filter_id'

This simply removes the 'select' to avoid this problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9b81b39de54e..7727660e9702 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -470,7 +470,6 @@ config SPI_S3C24XX_FIQ
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
 	depends on (PLAT_SAMSUNG || ARCH_EXYNOS)
-	select S3C64XX_PL080 if ARCH_S3C64XX
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
