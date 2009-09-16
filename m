From: Dragos Carp <dragos.carp-+ybMorV4k0dBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] mpc52xx_psc_spi: enlarge clock range
Date: Wed, 16 Sep 2009 13:07:50 +0200
Message-ID: <4AB0C706.5020601@toptica.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060603010800070304030800"
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

--------------060603010800070304030800
Content-Type: text/plain;
	charset="US-ASCII"
Content-Disposition: inline

allow spi clock values bellow 78kbps down to ca. 300bps

Signed-off-by: Dragos Carp <dragos.carp-+ybMorV4k0dBDgjK7y7TUQ@public.gmane.org>
---
 mpc52xx_psc_spi.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)


--------------060603010800070304030800
Content-Type: text/plain;
	name="mpc52xx_psc_spi.patch"
Content-Disposition: attachment;
	filename="mpc52xx_psc_spi.patch"

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 1b74d5c..b15882a 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -78,7 +78,8 @@ static void mpc52xx_psc_spi_activate_cs(struct spi_device *spi)
 	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(spi->master);
 	struct mpc52xx_psc __iomem *psc = mps->psc;
 	u32 sicr;
-	u16 ccr;
+	u32 ccr;
+	u32 bitclkdiv;
 
 	sicr = in_be32(&psc->sicr);
 
@@ -98,17 +99,16 @@ static void mpc52xx_psc_spi_activate_cs(struct spi_device *spi)
 		sicr &= ~0x10000000;
 	out_be32(&psc->sicr, sicr);
 
-	/* Set clock frequency and bits per word
-	 * Because psc->ccr is defined as 16bit register instead of 32bit
-	 * just set the lower byte of BitClkDiv
-	 */
-	ccr = in_be16((u16 __iomem *)&psc->ccr);
-	ccr &= 0xFF00;
-	if (cs->speed_hz)
-		ccr |= (MCLK / cs->speed_hz - 1) & 0xFF;
-	else /* by default SPI Clk 1MHz */
-		ccr |= (MCLK / 1000000 - 1) & 0xFF;
-	out_be16((u16 __iomem *)&psc->ccr, ccr);
+	/* Set clock frequency */
+	bitclkdiv = MCLK / (cs->speed_hz ? cs->speed_hz : 1000000) - 1;
+	bitclkdiv &= 0xFFFF;
+	bitclkdiv |= (bitclkdiv & 0xFF) << 16;	/* byte swapped */
+	bitclkdiv &= 0x00FFFF00;
+	ccr = in_be32(&psc->ccr);
+	ccr &= 0xFF0000FF;
+	ccr |= bitclkdiv;
+	out_be32(&psc->ccr, ccr);
+	
 	mps->bits_per_word = cs->bits_per_word;
 
 	if (mps->cs_control)
@@ -333,7 +333,7 @@ static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 	/* Configure 8bit codec mode as a SPI master and use EOF flags */
 	/* SICR_SIM_CODEC8|SICR_GENCLK|SICR_SPI|SICR_MSTR|SICR_USEEOF */
 	out_be32(&psc->sicr, 0x0180C800);
-	out_be16((u16 __iomem *)&psc->ccr, 0x070F); /* default SPI Clk 1MHz */
+	out_be32(&psc->ccr, 0x07130000); /* default SPI Clk 1MHz */
 
 	/* Set 2ms DTL delay */
 	out_8(&psc->ctur, 0x00);

--------------060603010800070304030800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
--------------060603010800070304030800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--------------060603010800070304030800--
