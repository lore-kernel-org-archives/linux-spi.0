From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] spi: bcm63xx-hsspi: checking for ERR_PTR instead of NULL
Date: Fri, 6 Dec 2013 15:58:24 +0300
Message-ID: <20131206125823.GA32369@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jonas Gorski <jogo@openwrt.org>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

devm_request_and_ioremap() returns NULL on error, it doesn't return an
ERR_PTR().

Fixes: 142168eba9dc ('spi: bcm63xx-hsspi: add bcm63xx HSSPI driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index bc8d848d33b7..da9f85d55c81 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -339,8 +339,8 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_request_and_ioremap(dev, res_mem);
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
+	if (!regs)
+		return -EADDRNOTAVAIL;
 
 	clk = clk_get(dev, "hsspi");
 
