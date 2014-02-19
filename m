From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: [PATCH 3/3] spi-topcliff-pch: Fix debug message
Date: Wed, 19 Feb 2014 10:36:09 +0100
Message-ID: <1392802569-11148-3-git-send-email-alexander.stein@systec-electronic.com>
References: <1392802569-11148-1-git-send-email-alexander.stein@systec-electronic.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392802569-11148-1-git-send-email-alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
---
 drivers/spi/spi-topcliff-pch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 7cb71b0..c2a3435 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1157,8 +1157,7 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 	dma->nent = num;
 	dma->desc_tx = desc_tx;
 
-	dev_dbg(&data->master->dev, "\n%s:Pulling down SSN low - writing "
-		"0x2 to SSNXCR\n", __func__);
+	dev_dbg(&data->master->dev, "%s:Pulling down SSN low - writing 0x2 to SSNXCR\n", __func__);
 
 	spin_lock_irqsave(&data->lock, flags);
 	pch_spi_writereg(data->master, PCH_SSNXCR, SSN_LOW);
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
