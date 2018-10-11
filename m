From: Talel Shenhar <talel@amazon.com>
Subject: [PATCH 1/2] dt-bindings: spi: dw: add compatible for Amazon's Alpine spi controller
Date: Thu, 11 Oct 2018 14:20:06 +0300
Message-ID: <1539256807-25676-1-git-send-email-talel@amazon.com>
References: <1539209339.1944.23.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <talel@amazon.com>, <jonnyc@amazon.com>, <ronenk@amazon.com>,
        <barakw@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539209339.1944.23.camel@impinj.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This compatible adds the ability for dw spi controller driver to work with
the dw spi controller found on Alpine chips.

The dw spi controller has an auto-deselect of Chip-Select, in case there is
no data inside the Tx FIFO. While working on platforms with Alpine chips,
auto-deselect mode causes an issue for some spi devices that can't handle
the Chip-Select deselect in the middle of a transaction. It is a normal
behavior for a Tx FIFO to be empty in the middle of a transaction, due to
busy cpu. In the Alpine chip family an option to change the default
behavior was added to the original dw spi controller to prevent this issue
of de-asserting Chip-Select once TX FIFO is empty. The change was to allow
SW manual control of the Chip-Select. With this change, as long as the
Slave Enable Register is asserted, the Chip-Select will be asserted. As a
result, it is necessary to deselect the Slave Select Register once the
transaction is done. This feature is enabled via a new device compatible
string called 'amazon,alpine-dw-apb-ssi'.  Once the driver identifies the
new compatible string, it enables the hw fixup logic, by writing to a
dedicated register found in the IP reserved area and will start manual
deselecting the Slave Select Register when the transfer ends.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 642d3fb..2864bc6 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -2,7 +2,7 @@ Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
 
 Required properties:
 - compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
-  "jaguar2"
+  "jaguar2", or "amazon,alpine-dw-apb-ssi"
 - reg : The register base for the controller. For "mscc,<soc>-spi", a second
   register set is required (named ICPU_CFG:SPI_MST)
 - interrupts : One interrupt, used by the controller.
-- 
2.7.4
