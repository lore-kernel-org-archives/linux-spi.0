From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/9] spi: Use dma_request_chan() directly for channel request
Date: Wed, 13 Nov 2019 11:42:47 +0200
Message-ID: <20191113094256.1108-1-peter.ujfalusi@ti.com>
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

Hi,

I'm going through the tree to remove dma_request_slave_channel_reason() as it
is just:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Regards,
Peter
---
Peter Ujfalusi (9):
  spi: at91-usart: Use dma_request_chan() directly for channel request
  spi: atmel: Use dma_request_chan() directly for channel request
  spi: fsl-lpspi: Use dma_request_chan() directly for channel request
  spi: imx: Use dma_request_chan() directly for channel request
  spi: pl022: Use dma_request_chan() directly for channel request
  spi: qup: Use dma_request_chan() directly for channel request
  spi: s3c64xx: Use dma_request_chan() directly for channel request
  spi: tegra114: Use dma_request_chan() directly for channel request
  spi: tegra20-slink: Use dma_request_chan() directly for channel
    request

 drivers/spi/spi-at91-usart.c    | 4 ++--
 drivers/spi/spi-atmel.c         | 2 +-
 drivers/spi/spi-fsl-lpspi.c     | 4 ++--
 drivers/spi/spi-imx.c           | 4 ++--
 drivers/spi/spi-pl022.c         | 4 ++--
 drivers/spi/spi-qup.c           | 4 ++--
 drivers/spi/spi-s3c64xx.c       | 6 ++----
 drivers/spi/spi-tegra114.c      | 3 +--
 drivers/spi/spi-tegra20-slink.c | 3 +--
 9 files changed, 15 insertions(+), 19 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
