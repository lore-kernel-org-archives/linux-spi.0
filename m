From: weiyj_lk-9Onoh4P/yGk@public.gmane.org
Subject: [PATCH -next] spi: orion: Fix return value check in orion_spi_probe()
Date: Mon, 13 Jun 2016 14:32:23 +0000
Message-ID: <1465828343-17298-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

In case of error, the function devm_ioremap() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should
be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
---
 drivers/spi/spi-orion.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index d0d9c86..ded3702 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -655,8 +655,8 @@ static int orion_spi_probe(struct platform_device *pdev)
 		spi->direct_access[cs].vaddr = devm_ioremap(&pdev->dev,
 							    r->start,
 							    PAGE_SIZE);
-		if (IS_ERR(spi->direct_access[cs].vaddr)) {
-			status = PTR_ERR(spi->direct_access[cs].vaddr);
+		if (!spi->direct_access[cs].vaddr) {
+			status = -ENOMEM;
 			goto out_rel_clk;
 		}
 		spi->direct_access[cs].size = PAGE_SIZE;


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
