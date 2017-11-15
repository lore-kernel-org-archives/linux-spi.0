From: Radu Pirea <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [RFC PATCH 1/2] Revert "spi: atmel: fix corrupted data issue on SAM9 family SoCs"
Date: Wed, 15 Nov 2017 18:35:31 +0200
Message-ID: <1510763732-10151-2-git-send-email-radu.pirea@microchip.com>
References: <1510763732-10151-1-git-send-email-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Radu Pirea <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1510763732-10151-1-git-send-email-radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This reverts commit 7094576ccdc3acfe1e06a1e2ab547add375baf7f.

A better fix was found and DMA for SAM9 SoCs must be enabled.

Signed-off-by: Radu Pirea <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f95da36..4e5e51f 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -269,7 +269,6 @@ struct atmel_spi_caps {
 	bool	is_spi2;
 	bool	has_wdrbt;
 	bool	has_dma_support;
-	bool	has_pdc_support;
 };
 
 /*
@@ -1426,28 +1425,7 @@ static void atmel_get_caps(struct atmel_spi *as)
 
 	as->caps.is_spi2 = version > 0x121;
 	as->caps.has_wdrbt = version >= 0x210;
-#ifdef CONFIG_SOC_SAM_V4_V5
-	/*
-	 * Atmel SoCs based on ARM9 (SAM9x) cores should not use spi_map_buf()
-	 * since this later function tries to map buffers with dma_map_sg()
-	 * even if they have not been allocated inside DMA-safe areas.
-	 * On SoCs based on Cortex A5 (SAMA5Dx), it works anyway because for
-	 * those ARM cores, the data cache follows the PIPT model.
-	 * Also the L2 cache controller of SAMA5D2 uses the PIPT model too.
-	 * In case of PIPT caches, there cannot be cache aliases.
-	 * However on ARM9 cores, the data cache follows the VIVT model, hence
-	 * the cache aliases issue can occur when buffers are allocated from
-	 * DMA-unsafe areas, by vmalloc() for instance, where cache coherency is
-	 * not taken into account or at least not handled completely (cache
-	 * lines of aliases are not invalidated).
-	 * This is not a theorical issue: it was reproduced when trying to mount
-	 * a UBI file-system on a at91sam9g35ek board.
-	 */
-	as->caps.has_dma_support = false;
-#else
 	as->caps.has_dma_support = version >= 0x212;
-#endif
-	as->caps.has_pdc_support = version < 0x212;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -1588,7 +1566,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		} else if (ret == -EPROBE_DEFER) {
 			return ret;
 		}
-	} else if (as->caps.has_pdc_support) {
+	} else {
 		as->use_pdc = true;
 	}
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
