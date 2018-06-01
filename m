From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v8 2/4] dt-bindings: Add bindings for SPI NAND devices
Date: Fri,  1 Jun 2018 15:13:58 +0200
Message-ID: <20180601131400.17634-3-boris.brezillon@bootlin.com>
References: <20180601131400.17634-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180601131400.17634-1-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Add bindings for SPI NAND chips.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v8:
- Fixed a typo in the commit message
---
 Documentation/devicetree/bindings/mtd/spi-nand.txt | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.txt b/Documentation/devicetree/bindings/mtd/spi-nand.txt
new file mode 100644
index 000000000000..d55f80196c63
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/spi-nand.txt
@@ -0,0 +1,27 @@
+SPI NAND flash
+
+Required properties:
+- compatible: should be "spi-nand"
+- reg: should encode the chip-select line used to access the NAND chip
+
+Optional properties
+- spi-max-frequency: maximum frequency of the SPI bus the chip can operate at.
+		     This should encode board limitations (i.e. max freq can't
+		     be achieved due to crosstalk on IO lines).
+		     When unspecified, the driver assumes the chip can run at
+		     the max frequency defined in the spec (information
+		     extracted chip detection time).
+- spi-tx-bus-width: The bus width (number of data wires) that is used for MOSI.
+		    Only encodes the board constraints (i.e. when not all IO
+		    signals are routed on the board). Device constraints are
+		    extracted when detecting the chip, and controller
+		    constraints are exposed by the SPI mem controller. If this
+		    property is missing that means no constraint at the board
+		    level.
+- spi-rx-bus-width: The bus width (number of data wires) that is used for MISO.
+		    Only encodes the board constraints (i.e. when not all IO
+		    signals are routed on the board). Device constraints are
+		    extracted when detecting the chip, and controller
+		    constraints are exposed by the SPI mem controller. If this
+		    property is missing that means no constraint at the board
+		    level.
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
