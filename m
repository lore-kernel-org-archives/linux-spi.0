From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 3/9] spi/pxa2xx: Use define for SSSR_TFL_MASK instead of plain
	numbers
Date: Thu,  2 Dec 2010 18:47:31 +0100
Message-ID: <1291312057-7933-4-git-send-email-bigeasy@linutronix.de>
References: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
	Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1291312057-7933-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/plat-pxa/include/plat/ssp.h |    3 ++-
 drivers/spi/pxa2xx_spi.c             |    8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/ssp.h b/arch/arm/plat-pxa/include/plat/ssp.h
index fe43150..21c12ca 100644
--- a/arch/arm/plat-pxa/include/plat/ssp.h
+++ b/arch/arm/plat-pxa/include/plat/ssp.h
@@ -82,7 +82,8 @@
 #define SSSR_TFS	(1 << 5)	/* Transmit FIFO Service Request */
 #define SSSR_RFS	(1 << 6)	/* Receive FIFO Service Request */
 #define SSSR_ROR	(1 << 7)	/* Receive FIFO Overrun */
-
+#define SSSR_TFL_MASK   (0xf << 8)	/* Transmit FIFO Level mask */
+#define SSSR_RFL_MASK   (0xf << 12)	/* Receive FIFO Level mask */
 
 /* extra bits in PXA255, PXA26x and PXA27x SSP ports */
 #define SSCR0_TISSP		(1 << 4)	/* TI Sync Serial Protocol */
diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 1865c23..5508344 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -224,7 +224,7 @@ static int null_writer(struct driver_data *drv_data)
 	void __iomem *reg = drv_data->ioaddr;
 	u8 n_bytes = drv_data->n_bytes;
 
-	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
+	if (((read_SSSR(reg) & SSSR_TFL_MASK) == SSSR_TFL_MASK)
 		|| (drv_data->tx == drv_data->tx_end))
 		return 0;
 
@@ -252,7 +252,7 @@ static int u8_writer(struct driver_data *drv_data)
 {
 	void __iomem *reg = drv_data->ioaddr;
 
-	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
+	if (((read_SSSR(reg) & SSSR_TFL_MASK) == SSSR_TFL_MASK)
 		|| (drv_data->tx == drv_data->tx_end))
 		return 0;
 
@@ -279,7 +279,7 @@ static int u16_writer(struct driver_data *drv_data)
 {
 	void __iomem *reg = drv_data->ioaddr;
 
-	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
+	if (((read_SSSR(reg) & SSSR_TFL_MASK) == SSSR_TFL_MASK)
 		|| (drv_data->tx == drv_data->tx_end))
 		return 0;
 
@@ -306,7 +306,7 @@ static int u32_writer(struct driver_data *drv_data)
 {
 	void __iomem *reg = drv_data->ioaddr;
 
-	if (((read_SSSR(reg) & 0x00000f00) == 0x00000f00)
+	if (((read_SSSR(reg) & SSSR_TFL_MASK) == SSSR_TFL_MASK)
 		|| (drv_data->tx == drv_data->tx_end))
 		return 0;
 
-- 
1.7.3.2


------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
