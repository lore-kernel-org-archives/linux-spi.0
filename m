From: <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 09/10] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Date: Thu, 31 Jan 2019 16:15:48 +0000
Message-ID: <20190131161515.21605-10-tudor.ambarus@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131161515.21605-1-tudor.ambarus@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
access, the other for the qspi core and phy. Both are mandatory.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2:
- make "pclk" mandatory even for sama5d2. Unnamed clk will be
supported in the driver.
- drop unneeded example

 Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Docu=
mentation/devicetree/bindings/spi/atmel-quadspi.txt
index e9dae6264d89..f949f9197636 100644
--- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
@@ -1,14 +1,22 @@
 * Atmel Quad Serial Peripheral Interface (QSPI)
=20
 Required properties:
-- compatible:     Should be "atmel,sama5d2-qspi".
+- compatible:     Should be one of the following:
+		  - "atmel,sama5d2-qspi"
+		  - "microchip,sam9x60-qspi"
 - reg:            Should contain the locations and lengths of the base reg=
isters
                   and the mapped memory.
 - reg-names:      Should contain the resource reg names:
                   - qspi_base: configuration register address space
                   - qspi_mmap: memory mapped address space
 - interrupts:     Should contain the interrupt for the device.
-- clocks:         The phandle of the clock needed by the QSPI controller.
+- clocks:	  - "atmel,sama5d2-qspi": the phandle of the clock needed by the
+		  QSPI controller.
+		  - "microchip,sam9x60-qspi": should reference the peripheral
+		  and system QSPI clocks.
+- clock-names:    Should contain:
+		  - "pclk" for the peripheral clock
+		  - "qspick" for the system clock, when available (sam9x60)
 - #address-cells: Should be <1>.
 - #size-cells:    Should be <0>.
=20
--=20
2.9.5
