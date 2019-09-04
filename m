From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 14/36] spi: lp-8841: use devm_platform_ioremap_resource() to simplify code
Date: Wed, 4 Sep 2019 21:58:56 +0800
Message-ID: <20190904135918.25352-15-yuehaibing@huawei.com>
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
 drivers/spi/spi-lp8841-rtc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-lp8841-rtc.c b/drivers/spi/spi-lp8841-rtc.c
index f50779f..2d43654 100644
--- a/drivers/spi/spi-lp8841-rtc.c
+++ b/drivers/spi/spi-lp8841-rtc.c
@@ -185,7 +185,6 @@ spi_lp8841_rtc_probe(struct platform_device *pdev)
 	int				ret;
 	struct spi_master		*master;
 	struct spi_lp8841_rtc		*data;
-	void				*iomem;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*data));
 	if (!master)
@@ -207,8 +206,7 @@ spi_lp8841_rtc_probe(struct platform_device *pdev)
 
 	data = spi_master_get_devdata(master);
 
-	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->iomem = devm_ioremap_resource(&pdev->dev, iomem);
+	data->iomem = devm_platform_ioremap_resource(pdev, 0);
 	ret = PTR_ERR_OR_ZERO(data->iomem);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get IO address\n");
-- 
2.7.4
