From: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 02/14] spi/spi-atmel: add support transfer on CS1, 2, 3,
	not only on CS0
Date: Tue, 19 Mar 2013 15:43:01 +0800
Message-ID: <1363678981-3724-1-git-send-email-wenyou.yang@atmel.com>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, JM.Lin-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org
To: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1363678866-3567-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/spi/spi-atmel.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 0928dee..64e2795 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -255,11 +255,6 @@ static bool atmel_spi_is_v2(struct atmel_spi *as)
  * Master on Chip Select 0.")  No workaround exists for that ... so for
  * nCS0 on that chip, we (a) don't use the GPIO, (b) can't support CS_HIGH,
  * and (c) will trigger that first erratum in some cases.
- *
- * TODO: Test if the atmel_spi_is_v2() branch below works on
- * AT91RM9200 if we use some other register than CSR0. However, don't
- * do this unconditionally since AP7000 has an errata where the BITS
- * field in CSR0 overrides all other CSRs.
  */
 
 static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
@@ -269,18 +264,22 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 	u32 mr;
 
 	if (atmel_spi_is_v2(as)) {
-		/*
-		 * Always use CSR0. This ensures that the clock
-		 * switches to the correct idle polarity before we
-		 * toggle the CS.
+		spi_writel(as, CSR0 + 4 * spi->chip_select, asd->csr);
+		/* For the low SPI version, there is a issue that PDC transfer
+		 * on CS1,2,3 needs SPI_CSR0.BITS config as SPI_CSR1,2,3.BITS
 		 */
 		spi_writel(as, CSR0, asd->csr);
 		if (as->caps.has_wdrbt) {
-			spi_writel(as, MR, SPI_BF(PCS, 0x0e) | SPI_BIT(WDRBT)
-				| SPI_BIT(MODFDIS) | SPI_BIT(MSTR));
+			spi_writel(as, MR,
+					SPI_BF(PCS, ~(0x01 << spi->chip_select))
+					| SPI_BIT(WDRBT)
+					| SPI_BIT(MODFDIS)
+					| SPI_BIT(MSTR));
 		} else {
-			spi_writel(as, MR, SPI_BF(PCS, 0x0e) | SPI_BIT(MODFDIS)
-				| SPI_BIT(MSTR));
+			spi_writel(as, MR,
+					SPI_BF(PCS, ~(0x01 << spi->chip_select))
+					| SPI_BIT(MODFDIS)
+					| SPI_BIT(MSTR));
 		}
 		mr = spi_readl(as, MR);
 		gpio_set_value(asd->npcs_pin, active);
-- 
1.7.9.5


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
