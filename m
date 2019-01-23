From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] spi: bcm2835aux: remove unneeded NULL check of devm_clk_get
Date: Wed, 23 Jan 2019 15:05:07 +0800
Message-ID: <20190123070507.15404-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
To: <broonie@kernel.org>, <eric@anholt.net>, <stefan.wahren@i2se.com>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Fix a static code checker warning:
drivers/spi/spi-bcm2835aux.c:460
 bcm2835aux_spi_probe() warn: passing zero to 'PTR_ERR'

In case of error, the function devm_clk_get() returns ERR_PTR()
and not returns NULL.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/spi/spi-bcm2835aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 671e374..f7e0548 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -456,7 +456,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	}
 
 	bs->clk = devm_clk_get(&pdev->dev, NULL);
-	if ((!bs->clk) || (IS_ERR(bs->clk))) {
+	if (IS_ERR(bs->clk)) {
 		err = PTR_ERR(bs->clk);
 		dev_err(&pdev->dev, "could not get clk: %d\n", err);
 		goto out_master_put;
-- 
2.7.0
