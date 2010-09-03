From: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 5/6] SPI: S3C64XX: Define new clk src indicator
Date: Fri,  3 Sep 2010 10:37:02 +0900
Message-ID: <1283477822-31260-1-git-send-email-jassi.brar@samsung.com>
References: <1OrKX4-0007cO-1K>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1OrKX4-0007cO-1K>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Since the driver is meant to manage SPI of newer SoCs as well, we
need to define a new structure member for latest SoC that has the
SPI clock control/scaling block moved from the controller to the
platform's clock management unit.
The flag should be set to 'true' by any SoC that has SPI controller
clock managed by CMU.

Signed-off-by: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index e5aba8f..b226f74 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -32,6 +32,8 @@ struct s3c64xx_spi_csinfo {
  * struct s3c64xx_spi_info - SPI Controller defining structure
  * @src_clk_nr: Clock source index for the CLK_CFG[SPI_CLKSEL] field.
  * @src_clk_name: Platform name of the corresponding clock.
+ * @clk_from_cmu: If the SPI clock/prescalar control block is present
+ *     by the platform's clock-management-unit and not in SPI controller.
  * @num_cs: Number of CS this controller emulates.
  * @cfg_gpio: Configure pins for this SPI controller.
  * @fifo_lvl_mask: All tx fifo_lvl fields start at offset-6
@@ -41,6 +43,7 @@ struct s3c64xx_spi_csinfo {
 struct s3c64xx_spi_info {
 	int src_clk_nr;
 	char *src_clk_name;
+	bool clk_from_cmu;
 
 	int num_cs;
 
-- 
1.6.2.5


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
