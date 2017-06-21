From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RFC PATCH v3 2/6] dt-bindings: spi/core: add wakeup-source optional property
Date: Wed, 21 Jun 2017 18:01:49 +0800
Message-ID: <1498039313-24220-3-git-send-email-jeffy.chen@rock-chips.com>
References: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com>
Cc: briannorris@chromium.org, dmitry.torokhov@gmail.com,
        dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Update document devicetree bindings to support "wakeup-source" property.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3: None

 Documentation/devicetree/bindings/spi/spi-bus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 1f6e86f..0fa1ccf 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -77,6 +77,7 @@ All slave nodes can contain the following optional properties:
 		    Defaults to 1 if not present.
 - spi-rx-delay-us - Microsecond delay after a read transfer.
 - spi-tx-delay-us - Microsecond delay after a write transfer.
+- wakeup-source   - Device can be used as a wakeup source.
 
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
 It allows data in the SPI system to be transferred using 2 wires (DUAL) or 4
-- 
2.1.4
