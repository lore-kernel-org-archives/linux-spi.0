From: apronin@chromium.org
Subject: [PATCH 2/4] spi: Document option to wake a device by toggling CS
Date: Wed, 29 Jun 2016 20:54:25 -0700
Message-ID: <1467258867-117727-2-git-send-email-apronin@chromium.org>
References: <1467258867-117727-1-git-send-email-apronin@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Andrey Pronin <apronin@chromium.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467258867-117727-1-git-send-email-apronin@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Andrey Pronin <apronin@chromium.org>

Some SPI devices may go to sleep after a period of inactivity
on SPI. For such devices, if enough time has passed since the
last SPI transaction, toggle CS and wait for the device to
start before communicating with it.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 42d5954..1b7ffd4 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -63,6 +63,13 @@ contain the following properties.
                       used for MISO. Defaults to 1 if not present.
 - spi-rx-delay-us  - (optional) Microsecond delay after a read transfer.
 - spi-tx-delay-us  - (optional) Microsecond delay after a write transfer.
+- cs-wake-after-sleep - (optional) Device may go to sleep after a period
+		of SPI inactivity. If this flag is set, toggle CS and
+		wait for it to wake before communicating to it.
+- cs-sleep-delay  - (optional) Delay after which the device may go to
+		sleep if there was no SPI activity (msec).
+- cs-wake-duration - (optional) Time it takes the device to wake up after
+		toggling CS if it went to sleep (msec).
 
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
 It allows data in the SPI system to be transferred in 2 wires(DUAL) or 4 wires(QUAD).
-- 
2.6.6
