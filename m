From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi/s3c64xx: Add missing static storage class specifiers
Date: Fri,  3 Aug 2012 10:08:12 +0530
Message-ID: <1343968692-13691-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Silences the following sparse warnings:
drivers/spi/spi-s3c64xx.c:1482:32: warning:
symbol 's3c2443_spi_port_config' was not declared. Should it be static?
drivers/spi/spi-s3c64xx.c:1489:32: warning:
symbol 's3c6410_spi_port_config' was not declared. Should it be static?
drivers/spi/spi-s3c64xx.c:1495:32: warning:
symbol 's5p64x0_spi_port_config' was not declared. Should it be static?
drivers/spi/spi-s3c64xx.c:1501:32: warning:
symbol 's5pc100_spi_port_config' was not declared. Should it be static?
drivers/spi/spi-s3c64xx.c:1508:32: warning:
symbol 's5pv210_spi_port_config' was not declared. Should it be static?
drivers/spi/spi-s3c64xx.c:1515:32: warning:
symbol 'exynos4_spi_port_config' was not declared. Should it be static?

Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index d24ec80..9a86dfe 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1477,40 +1477,40 @@ static const struct dev_pm_ops s3c64xx_spi_pm = {
 			   s3c64xx_spi_runtime_resume, NULL)
 };
 
-struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
+static struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
 	.fifo_lvl_mask	= { 0x7f },
 	.rx_lvl_offset	= 13,
 	.tx_st_done	= 21,
 	.high_speed	= true,
 };
 
-struct s3c64xx_spi_port_config s3c6410_spi_port_config = {
+static struct s3c64xx_spi_port_config s3c6410_spi_port_config = {
 	.fifo_lvl_mask	= { 0x7f, 0x7F },
 	.rx_lvl_offset	= 13,
 	.tx_st_done	= 21,
 };
 
-struct s3c64xx_spi_port_config s5p64x0_spi_port_config = {
+static struct s3c64xx_spi_port_config s5p64x0_spi_port_config = {
 	.fifo_lvl_mask	= { 0x1ff, 0x7F },
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 };
 
-struct s3c64xx_spi_port_config s5pc100_spi_port_config = {
+static struct s3c64xx_spi_port_config s5pc100_spi_port_config = {
 	.fifo_lvl_mask	= { 0x7f, 0x7F },
 	.rx_lvl_offset	= 13,
 	.tx_st_done	= 21,
 	.high_speed	= true,
 };
 
-struct s3c64xx_spi_port_config s5pv210_spi_port_config = {
+static struct s3c64xx_spi_port_config s5pv210_spi_port_config = {
 	.fifo_lvl_mask	= { 0x1ff, 0x7F },
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.high_speed	= true,
 };
 
-struct s3c64xx_spi_port_config exynos4_spi_port_config = {
+static struct s3c64xx_spi_port_config exynos4_spi_port_config = {
 	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F },
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
-- 
1.7.4.1


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
