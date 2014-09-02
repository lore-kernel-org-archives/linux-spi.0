From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/9] spi: spi-mxs: Fix checkpatch issue
Date: Tue, 02 Sep 2014 11:50:48 +0900
Message-ID: <002401cfc658$b32398f0$196acad0$%han@samsung.com>
References: <002101cfc658$4f627cf0$ee2776d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	=?iso-8859-2?Q?'Marek_Va=B9ut'?= <marex-ynQEQJNshbs@public.gmane.org>,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002101cfc658$4f627cf0$ee2776d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix the following checkpatch warnings.

  WARNING: Missing a blank line after declarations
  WARNING: Prefer kcalloc over kzalloc with multiply

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-mxs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 2884f0c2f5f0..c3f8d3a22472 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -154,12 +154,14 @@ static int mxs_ssp_wait(struct mxs_spi *spi, int offset, int mask, bool set)
 static void mxs_ssp_dma_irq_callback(void *param)
 {
 	struct mxs_spi *spi = param;
+
 	complete(&spi->c);
 }
 
 static irqreturn_t mxs_ssp_irq_handler(int irq, void *dev_id)
 {
 	struct mxs_ssp *ssp = dev_id;
+
 	dev_err(ssp->dev, "%s[%i] CTRL1=%08x STATUS=%08x\n",
 		__func__, __LINE__,
 		readl(ssp->base + HW_SSP_CTRL1(ssp)),
@@ -189,7 +191,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
 	if (!len)
 		return -EINVAL;
 
-	dma_xfer = kzalloc(sizeof(*dma_xfer) * sgs, GFP_KERNEL);
+	dma_xfer = kcalloc(sgs, sizeof(*dma_xfer), GFP_KERNEL);
 	if (!dma_xfer)
 		return -ENOMEM;
 
-- 
2.0.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
