From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] spi: add null check before pointer dereference
Date: Mon, 22 May 2017 19:25:07 -0500
Message-ID: <20170523002507.GA16670@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi.shyti@samsung.com>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add null check before dereferencing pointer desc

Addresses-Coverity-ID: 1397997
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/spi/spi-s3c64xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b392cca..9f1013e 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -306,6 +306,12 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
 
+	if (!desc) {
+		dev_err(&sdd->master->dev,
+			"%s:dmaengine_prep_slave_sg Failed\n", __func__);
+		return;
+	}
+
 	desc->callback = s3c64xx_spi_dmacb;
 	desc->callback_param = dma;
 
-- 
2.5.0
