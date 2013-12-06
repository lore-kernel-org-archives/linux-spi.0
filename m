From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [patch v2] spi: bcm63xx-hsspi: checking for ERR_PTR instead of NULL
Date: Fri, 6 Dec 2013 17:12:13 +0300
Message-ID: <20131206141212.GA956@elgon.mountain>
References: <CAOiHx=k87c_bFqFtJ7zJc9HxnjOEr2oMofNUsLkQbfQPrC04hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOiHx=k87c_bFqFtJ7zJc9HxnjOEr2oMofNUsLkQbfQPrC04hQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

devm_request_and_ioremap() returns NULL on error, it doesn't return an
ERR_PTR().  This patch fixes it by switching to devm_ioremap_resource()
which is the prefered function anyway.

Fixes: 142168eba9dc ('spi: bcm63xx-hsspi: add bcm63xx HSSPI driver')
Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
v2: switch to devm_ioremap_resource()

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index bc8d848d33b7..2cfe8eb619fd 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -338,7 +338,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	}
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_request_and_ioremap(dev, res_mem);
+	regs = devm_ioremap_resource(dev, res_mem);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
