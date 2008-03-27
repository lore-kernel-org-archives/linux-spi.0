From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/3] Blackfin SPI Driver: Fix peripheral
	pins initialization bug in SPI probe
Date: Wed, 26 Mar 2008 18:28:31 -0700
Message-ID: <1206581312-25869-3-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vitja Makarov <vitja.makarov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <>
References: <>
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

From: Vitja Makarov <vitja.makarov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Fix bug in SPI probe: first initialize peripheral pins,
and just after register spi master device. This fixes
problems with SPI drivers built-in kernel.

Singed-off-by: Vitja Makarov <vitja.makarov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index c93c9d6..a4bf3af 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -1294,6 +1294,12 @@ static int __init bfin5xx_spi_probe(struct platform_device *pdev)
 		goto out_error_queue_alloc;
 	}
 
+	status = peripheral_request_list(drv_data->pin_req, DRV_NAME);
+	if (status != 0) {
+		dev_err(&pdev->dev, ": Requesting Peripherals failed\n");
+		goto out_error_queue_alloc;
+	}
+
 	/* Register with the SPI framework */
 	platform_set_drvdata(pdev, drv_data);
 	status = spi_register_master(master);
@@ -1302,12 +1308,6 @@ static int __init bfin5xx_spi_probe(struct platform_device *pdev)
 		goto out_error_queue_alloc;
 	}
 
-	status = peripheral_request_list(drv_data->pin_req, DRV_NAME);
-	if (status != 0) {
-		dev_err(&pdev->dev, ": Requesting Peripherals failed\n");
-		goto out_error;
-	}
-
 	dev_info(dev, "%s, Version %s, regs_base@%p, dma channel@%d\n",
 		DRV_DESC, DRV_VERSION, drv_data->regs_base,
 		drv_data->dma_channel);
-- 
1.5.4.3

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
