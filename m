From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source and interrupts
Date: Mon, 11 Nov 2019 21:54:10 -0800
Message-ID: <20191112055412.192675-2-dmitry.torokhov@gmail.com>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This change adds bindings for wakeup-source and
interrupts/interrupt-names properties that can be used to configure
device as wakeup source on the system.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---

 .../bindings/spi/spi-controller.yaml          | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 732339275848c..4e31a4bf6851c 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -78,6 +78,29 @@ patternProperties:
         description:
           Chip select used by the device.
 
+      interrupts:
+        items:
+          - description: main interrupt (attention) line.
+          - description: dedicated wakeup interrupt.
+        minItems: 1 # The wakeup interrupt is optional.
+        description:
+          Specifies interrupt lines a device is connected to. Typically a
+          device is wired to a single interrupt line that is used as
+          "attention" signal and also to wake up system when device is
+          set up as wakeup source. However on some systems a dedicated
+          wakeup line might be used.
+
+      interrupt-names:
+        items:
+          - const: irq
+          - const: wakeup
+        minItems: 1
+
+      wakeup-source:
+        description:
+          Device is capable of waking up the system.
+        type: boolean
+
       spi-3wire:
         $ref: /schemas/types.yaml#/definitions/flag
         description:
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog
