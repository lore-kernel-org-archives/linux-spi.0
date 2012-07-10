From: Hui Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] spi/imx: use gpio_is_valid to determine if a gpio is
Date: Tue, 10 Jul 2012 17:44:23 +0800
Message-ID: <1341913463-10128-3-git-send-email-jason77.wang@gmail.com>
References: <1341913463-10128-1-git-send-email-jason77.wang@gmail.com>
	<1341913463-10128-2-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1341913463-10128-2-git-send-email-jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Use gpio_is_valid() to replace "gpio >= 0" or "gpio < 0".

Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Signed-off-by: Hui Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-imx.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index c12052f..e834ff8 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -626,7 +626,7 @@ static void spi_imx_chipselect(struct spi_device *spi, int is_active)
 	int active = is_active != BITBANG_CS_INACTIVE;
 	int dev_is_lowactive = !(spi->mode & SPI_CS_HIGH);
 
-	if (gpio < 0)
+	if (!gpio_is_valid(gpio))
 		return;
 
 	gpio_set_value(gpio, dev_is_lowactive ^ active);
@@ -736,7 +736,7 @@ static int spi_imx_setup(struct spi_device *spi)
 	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n", __func__,
 		 spi->mode, spi->bits_per_word, spi->max_speed_hz);
 
-	if (gpio >= 0)
+	if (gpio_is_valid(gpio))
 		gpio_direction_output(gpio, spi->mode & SPI_CS_HIGH ? 0 : 1);
 
 	spi_imx_chipselect(spi, BITBANG_CS_INACTIVE);
@@ -789,11 +789,11 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 
 	for (i = 0; i < master->num_chipselect; i++) {
 		int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
-		if (cs_gpio < 0 && mxc_platform_info)
+		if (!gpio_is_valid(cs_gpio) && mxc_platform_info)
 			cs_gpio = mxc_platform_info->chipselect[i];
 
 		spi_imx->chipselect[i] = cs_gpio;
-		if (cs_gpio < 0)
+		if (!gpio_is_valid(cs_gpio))
 			continue;
 
 		ret = gpio_request(spi_imx->chipselect[i], DRIVER_NAME);
@@ -895,7 +895,7 @@ out_release_mem:
 	release_mem_region(res->start, resource_size(res));
 out_gpio_free:
 	while (--i >= 0) {
-		if (spi_imx->chipselect[i] >= 0)
+		if (gpio_is_valid(spi_imx->chipselect[i]))
 			gpio_free(spi_imx->chipselect[i]);
 	}
 	spi_master_put(master);
@@ -920,7 +920,7 @@ static int __devexit spi_imx_remove(struct platform_device *pdev)
 	iounmap(spi_imx->base);
 
 	for (i = 0; i < master->num_chipselect; i++)
-		if (spi_imx->chipselect[i] >= 0)
+		if (gpio_is_valid(spi_imx->chipselect[i]))
 			gpio_free(spi_imx->chipselect[i]);
 
 	spi_master_put(master);
-- 
1.7.6


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
