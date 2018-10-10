From: Talel Shenhar <talel@amazon.com>
Subject: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Date: Wed, 10 Oct 2018 10:08:12 +0300
Message-ID: <1539155293-21750-1-git-send-email-talel@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <talel@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Update the dw-apb-ssi binding document, to add an optional 'cs-override'
devicetree property.

This property adds the ability for dw spi controller driver to work with
the dw spi controller found on Alpine chips.

The dw spi controller has an auto-deselect of Chip-Select, in case there is
no data inside the Tx FIFO. While working on platforms with Alpine chips,
auto-deselect mode causes an issue for some spi devices that can't handle
the Chip-Select deselect in the middle of a transaction. It is a normal
behavior for a Tx FIFO to be empty in the middle of a transaction, due to
busy cpu. In the Alpine chip family an option to change the default
behavior was added to the original dw spi controller to prevent this issue
of de-asserting Chip-Select once TX FIFO is empty. The change was to allow
SW to force the Chip-Select. With this change, as long as the Slave Enable
Register is asserted, the Chip-Select will be asserted. As a result, it is
necessary to deselect the Slave Select Register once the transaction is
done. This feature is enabled via a device property called 'cs-override'.
Once the driver identifies the 'cs-override' property, it enables the hw
fixup logic, by writing to a dedicated register found in the IP reserved
area and will starts deselecting the Slave Select Register when the
transfer ends.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 642d3fb..dd366f5 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -14,6 +14,8 @@ Optional properties:
 - num-cs : The number of chipselects. If omitted, this will default to 4.
 - reg-io-width : The I/O register width (in bytes) implemented by this
   device.  Supported values are 2 or 4 (the default).
+- cs-override: Enable explicit Chip-Select deselect during transfer instead of
+  default auto-deselect upon tx FIFO becoming empty.
 
 Child nodes as per the generic SPI binding.
 
-- 
2.7.4
