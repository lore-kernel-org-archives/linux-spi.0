From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] mxs/spi: fix error return code in mxs_spi_probe()
Date: Wed, 3 Apr 2013 21:06:40 +0800
Message-ID: <CAPgLHd9u8Nhfa-7dp_atXfLb-vRBzdqVbrCbPSd5xMmh2Q5THg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei@trendmicro.com.cn,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
To: grant.likely@secretlab.ca, broonie@opensource.wolfsonmicro.com,
	rob.herring@calxeda.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as returned elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/spi/spi-mxs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 7b1c014..8498276 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -570,6 +570,7 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	ssp->dmach = dma_request_slave_channel(&pdev->dev, "rx-tx");
 	if (!ssp->dmach) {
 		dev_err(ssp->dev, "Failed to request DMA\n");
+		ret = -ENODEV;
 		goto out_master_free;
 	}
 
