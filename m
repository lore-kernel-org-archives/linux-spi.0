From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 11/36] spi: coldfire-qspi: use devm_platform_ioremap_resource() to simplify code
Date: Wed, 4 Sep 2019 21:58:53 +0800
Message-ID: <20190904135918.25352-12-yuehaibing@huawei.com>
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
 drivers/spi/spi-coldfire-qspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index 5ff48ab..f80e06c 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -339,7 +339,6 @@ static int mcfqspi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct mcfqspi *mcfqspi;
-	struct resource *res;
 	struct mcfqspi_platform_data *pdata;
 	int status;
 
@@ -362,8 +361,7 @@ static int mcfqspi_probe(struct platform_device *pdev)
 
 	mcfqspi = spi_master_get_devdata(master);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mcfqspi->iobase = devm_ioremap_resource(&pdev->dev, res);
+	mcfqspi->iobase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mcfqspi->iobase)) {
 		status = PTR_ERR(mcfqspi->iobase);
 		goto fail0;
-- 
2.7.4
