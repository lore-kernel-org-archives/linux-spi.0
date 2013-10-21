From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH -next] spi: atmel: fix return value check in atmel_spi_probe()
Date: Mon, 21 Oct 2013 11:12:02 +0800
Message-ID: <CAPgLHd86H42hU1On2J3hCV1resNQ-PVCGB3Q=icaLoDQLSOg_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should be
replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 118a938..273db0b 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1547,8 +1547,10 @@ static int atmel_spi_probe(struct platform_device *pdev)
 
 	as->pdev = pdev;
 	as->regs = devm_ioremap_resource(&pdev->dev, regs);
-	if (!as->regs)
+	if (IS_ERR(as->regs)) {
+		ret = PTR_ERR(as->regs);
 		goto out_free_buffer;
+	}
 	as->phybase = regs->start;
 	as->irq = irq;
 	as->clk = clk;

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
