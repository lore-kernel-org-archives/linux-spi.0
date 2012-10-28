From: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH RESEND] spi-pxa2xx: fix memory corruption
Date: Sun, 28 Oct 2012 18:51:17 +0300
Message-ID: <1351439477-9969-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
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

pxa2xx_spi_probe allocates struct driver_data and null_dma_buf
at same time via spi_alloc_master(), but then calculates
null_dma_buf pointer incorrectly, and it causes memory corruption
later if DMA usage is enabled.

Signed-off-by: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Rebased against v3.7-rc2

 drivers/spi/spi-pxa2xx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index dc25bee..b25fe27 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -106,6 +106,7 @@ struct driver_data {
 	int rx_channel;
 	int tx_channel;
 	u32 *null_dma_buf;
+	u8 null_dma_buf_unaligned[16];
 
 	/* SSP register addresses */
 	void __iomem *ioaddr;
@@ -1543,8 +1544,8 @@ static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	/* Allocate master with space for drv_data and null dma buffer */
-	master = spi_alloc_master(dev, sizeof(struct driver_data) + 16);
+	/* Allocate master with space for drv_data */
+	master = spi_alloc_master(dev, sizeof(struct driver_data));
 	if (!master) {
 		dev_err(&pdev->dev, "cannot alloc spi_master\n");
 		pxa_ssp_free(ssp);
@@ -1569,8 +1570,8 @@ static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
 	master->transfer = transfer;
 
 	drv_data->ssp_type = ssp->type;
-	drv_data->null_dma_buf = (u32 *)ALIGN((u32)(drv_data +
-						sizeof(struct driver_data)), 8);
+	drv_data->null_dma_buf =
+		(u32 *)PTR_ALIGN(&drv_data->null_dma_buf_unaligned, 8);
 
 	drv_data->ioaddr = ssp->mmio_base;
 	drv_data->ssdr_physical = ssp->phys_base + SSDR;
-- 
1.7.12.4


------------------------------------------------------------------------------
WINDOWS 8 is here. 
Millions of people.  Your app in 30 days.
Visit The Windows 8 Center at Sourceforge for all your go to resources.
http://windows8center.sourceforge.net/
join-generation-app-and-make-money-coding-fast/
