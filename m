From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v9 2/6] dt-bindings: Add bindings for SPI NAND devices
Date: Fri, 22 Jun 2018 14:28:24 +0200
Message-ID: <20180622122828.12939-3-boris.brezillon@bootlin.com>
References: <20180622122828.12939-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Piotr Bugalski <Piotr.Bugalski@cryptera.com>,
 Peter Pan <peterpansjtu@gmail.com>, Julien Su <juliensu@mxic.com.tw>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Mason Yang <masonccyang@mxic.com.tw>, zhengxunli@mxic.com.tw
To: Boris Brezillon <boris.brezillon@bootlin.com>,
 Richard Weinberger <richard@nod.at>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180622122828.12939-1-boris.brezillon@bootlin.com>
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
Changes in v9:
- Do not describe generic SPI device properties, and more importantly
  do not change their meaning

Changes in v8:
- Fixed a typo in the commit message
---
 Documentation/devicetree/bindings/mtd/spi-nand.txt | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.txt b/Documentation/devicetree/bindings/mtd/spi-nand.txt
new file mode 100644
index 000000000000..8b51f3b6d55c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/spi-nand.txt
@@ -0,0 +1,5 @@
+SPI NAND flash
+
+Required properties:
+- compatible: should be "spi-nand"
+- reg: should encode the chip-select line used to access the NAND chip
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
