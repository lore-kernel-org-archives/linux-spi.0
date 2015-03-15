From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH/RFC] spi: sh-msiof: Fix MSIOF address for DMAC
Date: Sun, 15 Mar 2015 23:36:32 +0900
Message-ID: <1426430192-3271-1-git-send-email-ykaneko0929@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Mark Brown <broonie@kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
To: linux-spi@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>

MSIOF Base Address H'E6xx can be accessed by CPU and DMAC.
MSIOF Base Address H'E7xx for DMAC was removed from H/W manual.

Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

Hi Geert-san,

I have also found patches to address this problem in DTS files
which seems to be a good way to handle this problem. I plan to send
them separately. I'm unsure if this driver change is also appropriate.


This patch is based on the for-next branch of Mark Brown's spi tree.

 drivers/spi/spi-sh-msiof.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index e57eec0..88ec049 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1,6 +1,7 @@
 /*
  * SuperH MSIOF SPI Master Interface
  *
+ * Copyright (C) 2014-2015 Renesas Electronics Corporation
  * Copyright (c) 2009 Magnus Damm
  * Copyright (C) 2014 Glider bvba
  *
@@ -1072,10 +1073,7 @@ static int sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
 		return 0;
 	}
 
-	/* The DMA engine uses the second register set, if present */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res)
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	master = p->master;
 	master->dma_tx = sh_msiof_request_dma_chan(dev, DMA_MEM_TO_DEV,
-- 
1.9.1

