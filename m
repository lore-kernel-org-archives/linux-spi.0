From: Stephen Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>
Subject: pxa2xx_spi: PXA27x SSP1 doesn't work with DMA
Date: Wed, 11 Jul 2007 09:26:15 -0700
Message-ID: <1184171175.6762.17.camel@truckin.grid-net.com>
References: <200707100913.22574.david-b@pacbell.net>
Reply-To: stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-XVdHo8UCtqKsw+lfKfa4"
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org,
	David Vrabel <david.vrabel-kQvG35nSl+M@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200707100913.22574.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--=-XVdHo8UCtqKsw+lfKfa4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


This is fine.  When I get more time, I will re-think handling of PXA2xx
version differences.

Stephen


--=-XVdHo8UCtqKsw+lfKfa4
Content-Description: 
Content-Disposition: inline; filename=pxa27x-ssp1-fix-dma-hack.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

pxa2xx_spi: add SSP types for the PXA27x

The PXA27x's SSP1 is not like the PXA25x's SSP, so add some more PXA27x
specific types so SSP1 works with DMA.

Signed-off-by: David Vrabel <david.vrabel-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Stephen Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>

diff -u linux-2.6.16.28/drivers/spi/pxa2xx_spi.c linux-2.6.16.28/drivers/spi/pxa2xx_spi.c
--- linux-2.6.16.28/drivers/spi/pxa2xx_spi.c
+++ linux-2.6.16.28/drivers/spi/pxa2xx_spi.c
@@ -1260,18 +1260,20 @@
 
 		switch (platform_info->ssp_type) {
 			case PXA25x_SSP:
+			case PXA27x_SSP1:
 				DRCMRRXSSDR = DRCMR_MAPVLD
 						| drv_data->rx_channel;
 				DRCMRTXSSDR = DRCMR_MAPVLD
 						| drv_data->tx_channel;
 				break;
 			case PXA25x_NSSP:
+			case PXA27x_SSP2:
 				DRCMRRXSS2DR = DRCMR_MAPVLD
 						| drv_data->rx_channel;
 				DRCMRTXSS2DR = DRCMR_MAPVLD
 						| drv_data->tx_channel;
 				break;
-			case PXA27x_SSP:
+			case PXA27x_SSP3:
 				DRCMRRXSS3DR = DRCMR_MAPVLD
 						| drv_data->rx_channel;
 				DRCMRTXSS3DR = DRCMR_MAPVLD
@@ -1359,14 +1361,16 @@
 	if (drv_data->master_info->enable_dma) {
 		switch (drv_data->ssp_type) {
 			case PXA25x_SSP:
+			case PXA27x_SSP1:
 				DRCMRRXSSDR = 0;
 				DRCMRTXSSDR = 0;
 				break;
 			case PXA25x_NSSP:
+			case PXA27x_SSP2:
 				DRCMRRXSS2DR = 0;
 				DRCMRTXSS2DR = 0;
 				break;
-			case PXA27x_SSP:
+			case PXA27x_SSP3:
 				DRCMRRXSS3DR = 0;
 				DRCMRTXSS3DR = 0;
 				break;
diff -u linux-2.6.16.28/include/asm-arm/arch-pxa/pxa2xx_spi.h linux-2.6.16.28/include/asm-arm/arch-pxa/pxa2xx_spi.h
--- linux-2.6.16.28/include/asm-arm/arch-pxa/pxa2xx_spi.h
+++ linux-2.6.16.28/include/asm-arm/arch-pxa/pxa2xx_spi.h
@@ -25,7 +25,10 @@
 	SSP_UNDEFINED = 0,
 	PXA25x_SSP,  /* pxa 210, 250, 255, 26x */
 	PXA25x_NSSP, /* pxa 255, 26x (including ASSP) */
-	PXA27x_SSP,
+	PXA27x_SSP1,
+	PXA27x_SSP2,
+	PXA27x_SSP3,
+	PXA27x_SSP = PXA27x_SSP3, /* for compatibility */
 };
 
 /* device.platform_data for SSP controller devices */

--=-XVdHo8UCtqKsw+lfKfa4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--=-XVdHo8UCtqKsw+lfKfa4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--=-XVdHo8UCtqKsw+lfKfa4--
