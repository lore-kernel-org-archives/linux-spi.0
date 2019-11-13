From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 5/9] spi: pl022: Use dma_request_chan() directly for channel request
Date: Wed, 13 Nov 2019 11:42:52 +0200
Message-ID: <20191113094256.1108-6-peter.ujfalusi@ti.com>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <vkoul@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <linux-arm-msm@vger.kernel.org>, <kgene@kernel.org>,
        <krzk@kernel.org>, <linux-tegra@vger.kernel.org>
To: <broonie@kernel.org>, <radu_nicolae.pirea@upb.ro>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <linus.walleij@linaro.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <andi@etezian.org>,
        <ldewangan@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191113094256.1108-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

dma_request_slave_channel_reason() is:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/spi/spi-pl022.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 3024c30e7f2e..66028ebbc336 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1158,7 +1158,7 @@ static int pl022_dma_autoprobe(struct pl022 *pl022)
 	int err;
 
 	/* automatically configure DMA channels from platform, normally using DT */
-	chan = dma_request_slave_channel_reason(dev, "rx");
+	chan = dma_request_chan(dev, "rx");
 	if (IS_ERR(chan)) {
 		err = PTR_ERR(chan);
 		goto err_no_rxchan;
@@ -1166,7 +1166,7 @@ static int pl022_dma_autoprobe(struct pl022 *pl022)
 
 	pl022->dma_rx_channel = chan;
 
-	chan = dma_request_slave_channel_reason(dev, "tx");
+	chan = dma_request_chan(dev, "tx");
 	if (IS_ERR(chan)) {
 		err = PTR_ERR(chan);
 		goto err_no_txchan;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
