From: <tthayer@opensource.altera.com>
Subject: [PATCHv2 1/2] Documentation: dt: spi: Add GPIO Slave Select Parameter
Date: Fri, 7 Oct 2016 09:56:33 -0500
Message-ID: <1475852194-27690-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <andriy.shevchenko@linux.intel.com>,
        <jarkko.nikula@linux.intel.com>, <jszhang@marvell.com>,
        <michael@smart-africa.com>, <kernel@mseidel.net>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tthayer@opensource.altera.com>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Thor Thayer <tthayer@opensource.altera.com>

Some SPI masters require the slave to be selected before a
transaction can occur - even in the case of GPIO chip select.

This patch adds a GPIO slave select parameter to indicate
the slave needs to be selected in the GPIO CS case.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2  Add to SPI framework - add bindings.
---
 Documentation/devicetree/bindings/spi/spi-bus.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 4b1d6e7..3a006bc 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -24,6 +24,7 @@ support describing the chip select layout.
 Optional properties:
 - cs-gpios	  - gpios chip select.
 - num-cs	  - total number of chipselects.
+- gpio-ss	  - use internal slave select with gpio chip select.
 
 If cs-gpios is used the number of chip selects will be increased automatically
 with max(cs-gpios > hw cs).
-- 
1.7.9.5
