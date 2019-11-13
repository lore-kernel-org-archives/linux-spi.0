From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/9] spi: at91-usart: Use dma_request_chan() directly for
 channel request
Date: Wed, 13 Nov 2019 11:42:48 +0200
Message-ID: <20191113094256.1108-2-peter.ujfalusi@ti.com>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alexandre.belloni@bootlin.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzk@kernel.org, linux-spi@vger.kernel.org,
 vkoul@kernel.org, kgene@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
To: <broonie@kernel.org>, <radu_nicolae.pirea@upb.ro>, <shawnguo@kernel.org>,
 <s.hauer@pengutronix.de>, <linus.walleij@linaro.org>,
 <agross@kernel.org>, <bjorn.andersson@linaro.org>, <andi@etezian.org>,
 <ldewangan@nvidia.com>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191113094256.1108-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

dma_request_slave_channel_reason() is:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/spi/spi-at91-usart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index a40bb2ef89dc..88033422a42a 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -132,7 +132,7 @@ static int at91_usart_spi_configure_dma(struct spi_controller *ctlr,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	ctlr->dma_tx = dma_request_slave_channel_reason(dev, "tx");
+	ctlr->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR_OR_NULL(ctlr->dma_tx)) {
 		if (IS_ERR(ctlr->dma_tx)) {
 			err = PTR_ERR(ctlr->dma_tx);
@@ -145,7 +145,7 @@ static int at91_usart_spi_configure_dma(struct spi_controller *ctlr,
 		goto at91_usart_spi_error_clear;
 	}
 
-	ctlr->dma_rx = dma_request_slave_channel_reason(dev, "rx");
+	ctlr->dma_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR_OR_NULL(ctlr->dma_rx)) {
 		if (IS_ERR(ctlr->dma_rx)) {
 			err = PTR_ERR(ctlr->dma_rx);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
