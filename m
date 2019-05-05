From: Radu Pirea <radu_nicolae.pirea@upb.ro>
Subject: [PATCH v2 0/2] DMA support for AT91 USART in SPI mode
Date: Sun,  5 May 2019 21:06:44 +0300
Message-ID: <20190505180646.1442-1-radu_nicolae.pirea@upb.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: Radu Pirea <radu_nicolae.pirea@upb.ro>,
 Richard Genoud <richard.genoud@gmail.com>,
 Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Mark Brown <broonie@kernel.org>
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

This is the version two of the patches with DMA support for
spi-at91-usart driver. 

Changes in v2:
- specified in bindings order of dmas and dma-names
- changed DMA_FROM_DEVICE to DMA_DEV_TO_MEM and DMA_TO_DEVICE to
DMA_MEM_TO_DEV when dmaengine_prep_slave_sg is called

Changes in v1:
- added DMA support


Radu Pirea (2):
  dt-bindings: mfd: atmel-usart: add DMA bindings for USART in SPI mode
  spi: at91-usart: add DMA support

 .../devicetree/bindings/mfd/atmel-usart.txt   |  20 +-
 drivers/spi/spi-at91-usart.c                  | 221 +++++++++++++++++-
 2 files changed, 234 insertions(+), 7 deletions(-)

-- 
2.21.0
