From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] spi: spi-sh: fix error return code in spi_sh_probe()
Date: Wed, 9 Aug 2017 10:46:48 -0500
Message-ID: <20170809154648.GA23748@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

platform_get_irq() returns an error code, but the spi-sh driver
ignores it and always returns -ENODEV. This is not correct and,
prevents -EPROBE_DEFER from being propagated properly.

Print and propagate the return value of platform_get_irq on failure.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/spi/spi-sh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index 2bf53f0..50e0ea9 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -446,8 +446,8 @@ static int spi_sh_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq error\n");
-		return -ENODEV;
+		dev_err(&pdev->dev, "platform_get_irq error: %d\n", irq);
+		return irq;
 	}
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct spi_sh_data));
-- 
2.5.0
