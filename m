From: Radu Pirea <radu_nicolae.pirea@upb.ro>
Subject: [PATCH 0/3] Add PM and DMA support for AT91 USART as SPI
Date: Wed, 21 Nov 2018 13:27:29 +0200
Message-ID: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, Radu Pirea <radu_nicolae.pirea@upb.ro>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: richard.genoud@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
 mark.rutland@arm.com, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, ludovic.desroches@microchip.co,
 broonie@kernel.org
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

This patch series improves the SPI driver for AT91 USART IP and
adds support for DMA transfers, updates the bindings of driver
and PM callback functions.

I decided to use DMA only for transfers long than 16 bytes. DMA
setup introduces a little overhead and is better to use PIO for
short transfers.

Radu Pirea (3):
  spi: at91-usart: add power management support
  dt-bindings: mfd: atmel-usart: add DMA bindings for SPI mode
  spi: at91-usart: add DMA support

 .../devicetree/bindings/mfd/atmel-usart.txt   |  15 +-
 drivers/spi/spi-at91-usart.c                  | 284 +++++++++++++++++-
 2 files changed, 292 insertions(+), 7 deletions(-)

-- 
2.19.1
