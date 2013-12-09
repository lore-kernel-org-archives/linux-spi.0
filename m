From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] spi: omap-100k: Remove casting the return value which is a
 void pointer
Date: Mon, 09 Dec 2013 19:36:41 +0900
Message-ID: <001801cef4ca$8c605e20$a5211a60$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Cory Maccarrone' <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	'Michal Nazarewicz' <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Casting the return value which is a void pointer is redundant.
The conversion from void pointer to any other pointer type is
guaranteed by the C programming language.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-omap-100k.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 0d32054..35832a9 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -441,7 +441,7 @@ static int omap1_spi100k_probe(struct platform_device *pdev)
 	 * You should allocate this with ioremap() before initializing
 	 * the SPI.
 	 */
-	spi100k->base = (void __iomem *)dev_get_platdata(&pdev->dev);
+	spi100k->base = dev_get_platdata(&pdev->dev);
 
 	spi100k->ick = devm_clk_get(&pdev->dev, "ick");
 	if (IS_ERR(spi100k->ick)) {
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
