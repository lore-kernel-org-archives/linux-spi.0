From: Jiucheng Xu <Jiucheng.Xu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] spi/mpc8xxx:Fix the wrong pointer of getting the platform data
Date: Thu, 12 Jul 2012 11:18:14 +0800
Message-ID: <1342063094-19299-1-git-send-email-Jiucheng.Xu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Xu Jiucheng <Jiucheng.Xu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

From: Xu Jiucheng <Jiucheng.Xu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

In the spi_alloc_device(), the parent pointer of spi deivce has
been changed from master->dev.parent to &master->dev for device
unregistration, so the pointer of getting the platform data as
this 'spi->dev.parent->platform_data' is wrong.

Signed-off-by: Xu Jiucheng <Jiucheng.Xu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi_fsl_spi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi_fsl_spi.c b/drivers/spi/spi_fsl_spi.c
index 7963c9b..7d164d3 100644
--- a/drivers/spi/spi_fsl_spi.c
+++ b/drivers/spi/spi_fsl_spi.c
@@ -139,7 +139,7 @@ static void fsl_spi_change_mode(struct spi_device *spi)
 static void fsl_spi_chipselect(struct spi_device *spi, int value)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
-	struct fsl_spi_platform_data *pdata = spi->dev.parent->platform_data;
+	struct fsl_spi_platform_data *pdata = mpc8xxx_spi->dev->platform_data;
 	bool pol = spi->mode & SPI_CS_HIGH;
 	struct spi_mpc8xxx_cs	*cs = spi->controller_state;
 
@@ -934,7 +934,8 @@ err:
 
 static void fsl_spi_cs_control(struct spi_device *spi, bool on)
 {
-	struct device *dev = spi->dev.parent;
+	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	struct device *dev = mpc8xxx_spi->dev;
 	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(dev->platform_data);
 	u16 cs = spi->chip_select;
 	int gpio = pinfo->gpios[cs];
-- 
1.6.4



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
