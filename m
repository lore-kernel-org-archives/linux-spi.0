From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 27/36] spi: sirf: use devm_platform_ioremap_resource() to simplify code
Date: Wed, 4 Sep 2019 21:59:09 +0800
Message-ID: <20190904135918.25352-28-yuehaibing@huawei.com>
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
 drivers/spi/spi-sirf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 71b882a..e1e6391 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -1070,7 +1070,6 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 {
 	struct sirfsoc_spi *sspi;
 	struct spi_master *master;
-	struct resource *mem_res;
 	const struct sirf_spi_comp_data *spi_comp_data;
 	int irq;
 	int ret;
@@ -1097,8 +1096,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	sspi->fifo_level_chk_mask = (sspi->fifo_size / 4) - 1;
 	sspi->dat_max_frm_len = spi_comp_data->dat_max_frm_len;
 	sspi->fifo_size = spi_comp_data->fifo_size;
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sspi->base = devm_ioremap_resource(&pdev->dev, mem_res);
+	sspi->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sspi->base)) {
 		ret = PTR_ERR(sspi->base);
 		goto free_master;
-- 
2.7.4
