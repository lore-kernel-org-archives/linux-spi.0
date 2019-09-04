From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 33/36] spi: xlp: use devm_platform_ioremap_resource() to simplify code
Date: Wed, 4 Sep 2019 21:59:15 +0800
Message-ID: <20190904135918.25352-34-yuehaibing@huawei.com>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <bcm-kernel-feedback-list@broadcom.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
To: <broonie@kernel.org>, <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <eric@anholt.net>, <wahrenst@gmx.net>,
        <shc_work@mail.ru>, <agross@kernel.org>, <khilman@baylibre.com>,
        <matthias.bgg@gmail.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <avifishman70@gmail.com>, <tmaimon77@gmail.com>,
        <tali.perry1@gmail.com>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <kgene@kernel.org>, <krzk@kernel.org>,
        <andi@etezian.org>, <palmer@sifive.com>,
        <paul.walmsley@sifive.com>, <baohua@kernel.org>,
        <mripard@kernel.org>, <wens@csie.org>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <yamada.masahiro@socionext.com>, <michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904135918.25352-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/spi/spi-xlp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-xlp.c b/drivers/spi/spi-xlp.c
index 4eb5bc9..797ac0e 100644
--- a/drivers/spi/spi-xlp.c
+++ b/drivers/spi/spi-xlp.c
@@ -370,7 +370,6 @@ static int xlp_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct xlp_spi_priv *xspi;
-	struct resource *res;
 	struct clk *clk;
 	int irq, err;
 
@@ -378,8 +377,7 @@ static int xlp_spi_probe(struct platform_device *pdev)
 	if (!xspi)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	xspi->base = devm_ioremap_resource(&pdev->dev, res);
+	xspi->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xspi->base))
 		return PTR_ERR(xspi->base);
 
-- 
2.7.4
