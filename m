From: kernel@martin.sperl.org
Subject: [PATCH v4 3/5] dt/bindings: bcm2835: add binding documentation for bcm2835-aux
Date: Mon, 24 Aug 2015 08:40:06 +0000
Message-ID: <1440405608-3995-4-git-send-email-kernel@martin.sperl.org>
References: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel@martin.sperl.org>
To: Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Kumar Gala <galak@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 .../bindings/soc/bcm/brcm,bcm2835-aux.txt          |   27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-aux.txt

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-aux.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-aux.txt
new file mode 100644
index 0000000..8b79cf3
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-aux.txt
@@ -0,0 +1,27 @@
+Broadcom BCM2835 auxiliar device enable register
+
+the BCM2835 contains 3 auxiliar devices (spi1/spi2/uart1)
+which need to get enabled via a shared register.
+
+Required properties:
+- compatible: Should be "brcm,bcm2835-aux".
+- reg: Should contain register location and length for the
+       enable register
+
+Example:
+
+aux_enable: aux_enable@0x7e215004 {
+	compatible = "bcrm,bcm2835-aux";
+	reg = <0x7e215004 0x04>;
+};
+
+Typically used in the respective auxiliar device descriptions
+like this:
+
+uart1: uart@7e215040 {
+	...
+	brcm,aux-enable = <&aux_enable 1>;
+	...
+};
+
+The name of the property can be device/driver specific.
--
1.7.10.4
