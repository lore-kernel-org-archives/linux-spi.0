From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 12/36] spi: dw-mmio: use devm_platform_ioremap_resource() to simplify code
Date: Wed, 4 Sep 2019 21:58:54 +0800
Message-ID: <20190904135918.25352-13-yuehaibing@huawei.com>
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
 drivers/spi/spi-dw-mmio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index edb3cf6..bd46fca 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -79,14 +79,12 @@ static int dw_spi_mscc_init(struct platform_device *pdev,
 			    const char *cpu_syscon, u32 if_si_owner_offset)
 {
 	struct dw_spi_mscc *dwsmscc;
-	struct resource *res;
 
 	dwsmscc = devm_kzalloc(&pdev->dev, sizeof(*dwsmscc), GFP_KERNEL);
 	if (!dwsmscc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	dwsmscc->spi_mst = devm_ioremap_resource(&pdev->dev, res);
+	dwsmscc->spi_mst = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(dwsmscc->spi_mst)) {
 		dev_err(&pdev->dev, "SPI_MST region map failed\n");
 		return PTR_ERR(dwsmscc->spi_mst);
-- 
2.7.4
