From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: mfd: atmel-usart: add DMA bindings for USART in SPI mode" to the spi tree
Date: Wed,  8 May 2019 10:08:57 +0100 (BST)
Message-ID: <20190508090857.B7CB344003F@finisterre.sirena.org.uk>
References: <20190505180646.1442-2-radu_nicolae.pirea@upb.ro>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
To: Radu Pirea <radu_nicolae.pirea@upb.ro>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190505180646.1442-2-radu_nicolae.pirea@upb.ro>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   dt-bindings: mfd: atmel-usart: add DMA bindings for USART in SPI mode

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f7b99e5948e6be8b850eecbb2de1986d26a76b36 Mon Sep 17 00:00:00 2001
From: Radu Pirea <radu_nicolae.pirea@upb.ro>
Date: Sun, 5 May 2019 21:06:45 +0300
Subject: [PATCH] dt-bindings: mfd: atmel-usart: add DMA bindings for USART in
 SPI mode

The bindings for DMA are now common for both drivers of the USART
IP.

The node given as an example for USART in SPI mode has been updated in
order to include DMA bindings.

Signed-off-by: Radu Pirea <radu_nicolae.pirea@upb.ro>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/mfd/atmel-usart.txt   | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
index 7f0cd72f47d2..699fd3c9ace8 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
@@ -17,17 +17,24 @@ Required properties for USART in SPI mode:
 - cs-gpios: chipselects (internal cs not supported)
 - atmel,usart-mode : Must be <AT91_USART_MODE_SPI> (found in dt-bindings/mfd/at91-usart.h)
 
+Optional properties in serial and SPI mode:
+- dma bindings for dma transfer:
+	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
+		memory peripheral interface and USART DMA channel ID, FIFO configuration.
+		The order of DMA channels is fixed. The first DMA channel must be TX
+		associated channel and the second one must be RX associated channel.
+		Refer to dma.txt and atmel-dma.txt for details.
+	- dma-names: "tx" for TX channel.
+		     "rx" for RX channel.
+		     The order of dma-names is also fixed. The first name must be "tx"
+		     and the second one must be "rx" as in the examples below.
+
 Optional properties in serial mode:
 - atmel,use-dma-rx: use of PDC or DMA for receiving data
 - atmel,use-dma-tx: use of PDC or DMA for transmitting data
 - {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD line respectively.
   It will use specified PIO instead of the peripheral function pin for the USART feature.
   If unsure, don't specify this property.
-- add dma bindings for dma transfer:
-	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
-		memory peripheral interface and USART DMA channel ID, FIFO configuration.
-		Refer to dma.txt and atmel-dma.txt for details.
-	- dma-names: "rx" for RX channel, "tx" for TX channel.
 - atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
   capable USARTs.
 - rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
@@ -81,5 +88,8 @@ Example:
 		interrupts = <12 IRQ_TYPE_LEVEL_HIGH 5>;
 		clocks = <&usart0_clk>;
 		clock-names = "usart";
+		dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
+		       <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+		dma-names = "tx", "rx";
 		cs-gpios = <&pioB 3 0>;
 	};
-- 
2.20.1
