From: <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] SPI IMX: Set inactive state of SPI clock (SCLK CTL) according
	to SPI clock polarity
Date: Tue, 28 Aug 2012 15:21:30 +0200
Message-ID: <1346160090-16278-1-git-send-email-knut.wohlrab@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
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

From: Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>

Add the setting of the inactive state ECSPIx_CONFIGREG:SCLK CTL 
according to the clock polarity ECSPIx_CONFIGREG:SCLK POL:

Device tree _without_ "spi-cpol":
	0 = clock active high polarity = inactive state low

Device tree with "spi-cpol":
	1 = clock active low polarity = inactive state high

Are there real world examples for a need of an individual setting of 
clock polarity/inactive state?

Signed-off-by: Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-imx.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e834ff8..d64655b 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -197,6 +197,7 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
 #define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
 #define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
 #define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
+#define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs) + 20))
 
 #define MX51_ECSPI_INT		0x10
 #define MX51_ECSPI_INT_TEEN		(1 <<  0)
@@ -287,9 +288,10 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	if (config->mode & SPI_CPHA)
 		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
 
-	if (config->mode & SPI_CPOL)
+	if (config->mode & SPI_CPOL) {
 		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
-
+		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
+	}
 	if (config->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
 
-- 
1.7.0.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
