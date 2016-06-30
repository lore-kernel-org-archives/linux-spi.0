From: apronin@chromium.org
Subject: [PATCH 4/4] spi: Document option to insert delay between transactions
Date: Wed, 29 Jun 2016 20:54:27 -0700
Message-ID: <1467258867-117727-4-git-send-email-apronin@chromium.org>
References: <1467258867-117727-1-git-send-email-apronin@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Andrey Pronin <apronin@chromium.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467258867-117727-1-git-send-email-apronin@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Andrey Pronin <apronin@chromium.org>

Some devices may need CS to be deasserted for some time
between transactions. Added a new capability to guarantee
a delay between SPI transactions for the device.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 1b7ffd4..87c117a 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -70,6 +70,8 @@ contain the following properties.
 		sleep if there was no SPI activity (msec).
 - cs-wake-duration - (optional) Time it takes the device to wake up after
 		toggling CS if it went to sleep (msec).
+- xfer-delay      - (optional) Delay to insert between SPI transactions
+		to guarantee that CS is deasserted at least for some time.
 
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
 It allows data in the SPI system to be transferred in 2 wires(DUAL) or 4 wires(QUAD).
-- 
2.6.6
