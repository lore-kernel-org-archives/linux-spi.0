From: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 6/6] spi/ath79: add shutdown handler
Date: Thu, 27 Dec 2012 10:42:29 +0100
Message-ID: <1356601349-23617-7-git-send-email-juhosg@openwrt.org>
References: <1356601349-23617-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1356601349-23617-1-git-send-email-juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The SPI controller of the AR7xxx/AR9xxx SoCs
have a special mode which allows the SoC to
directly read data from SPI flash chips. In
this mode, the content of the SPI flash chip
can be accessed via a memory mapped region.

During early init time, the kernel expects
that the flash chip is accessible through
that memory region because it reads board
specific values (e.g. MAC address, WiFi
calibration data) from the flash on various
boards.

This is working if the kernel is loaded
directly by the bootloader because that
leaves the SPI controller in the special
mode. However it is not working in a kexec'd
kernel because the SPI driver does not restore
the special mode during shutdown.

The patch adds a shutdown handler to fix this
issue.

Signed-off-by: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-ath79.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 842acd8..73e491e 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -293,7 +293,7 @@ err_put_master:
 	return ret;
 }
 
-static int ath79_spi_remove(struct platform_device *pdev)
+static void __ath79_spi_remove(struct platform_device *pdev)
 {
 	struct ath79_spi *sp = platform_get_drvdata(pdev);
 
@@ -304,13 +304,23 @@ static int ath79_spi_remove(struct platform_device *pdev)
 	iounmap(sp->base);
 	platform_set_drvdata(pdev, NULL);
 	spi_master_put(sp->bitbang.master);
+}
 
+static int ath79_spi_remove(struct platform_device *pdev)
+{
+	__ath79_spi_remove(pdev);
 	return 0;
 }
 
+static void ath79_spi_shutdown(struct platform_device *pdev)
+{
+	__ath79_spi_remove(pdev);
+}
+
 static struct platform_driver ath79_spi_driver = {
 	.probe		= ath79_spi_probe,
 	.remove		= ath79_spi_remove,
+	.shutdown	= ath79_spi_shutdown,
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
-- 
1.7.10


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
