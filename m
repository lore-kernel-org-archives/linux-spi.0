From: Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1] dt-binding: spi: Update NPCM PSPI controller documentation
Date: Tue,  4 Dec 2018 15:54:42 +0200
Message-ID: <20181204135442.125269-1-tmaimon77@gmail.com>
Cc: linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Update the PSPI NPCM binding document of the spi aliases use
to define the spi ID number.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
index 99606b22e5c2..1fd9a4406a1d 100644
--- a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
@@ -19,8 +19,16 @@ Optional properties:
 - clock-frequency : Input clock frequency to the PSPI block in Hz.
 		    Default is 25000000 Hz.
 
+Aliases:
+- All the SPI controller nodes should be represented in the aliases node using
+  the following format 'spi{n}' withe the correct numbered in "aliases" node.
+
 Example:
 
+aliases {
+	spi0 = &spi0;
+};
+
 spi0: spi@f0200000 {
 	compatible = "nuvoton,npcm750-pspi";
 	reg = <0xf0200000 0x1000>;
-- 
2.14.1
