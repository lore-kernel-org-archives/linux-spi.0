From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 3/4] spi: samsung: Update binding documentation
Date: Wed, 16 Jul 2014 17:19:09 +0200
Message-ID: <1405523950-2231-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk>
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>,
	Doug Anderson <dianders@chromium.org>,
	Olof Johansson <olof@lixom.net>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Javier Martinez Canillas <javier.martinez@collabora.co.uk>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>

Samsung SPI driver now uses the generic SPI "cs-gpios"
binding so update the documentation accordingly.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
[javier.martinez@collabora.co.uk: split changes and improve commit message]
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 Documentation/devicetree/bindings/spi/spi-samsung.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 7f2d88d..1e8a857 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -38,15 +38,13 @@ Optional Board Specific Properties:
 - num-cs: Specifies the number of chip select lines supported. If
   not specified, the default number of chip select lines is set to 1.
 
+- cs-gpios: should specify GPIOs used for chipselects (see spi-bus.txt)
+
 SPI Controller specific data in SPI slave nodes:
 
 - The spi slave nodes should provide the following information which is required
   by the spi controller.
 
-  - cs-gpio: A gpio specifier that specifies the gpio line used as
-    the slave select line by the spi controller. The format of the gpio
-    specifier depends on the gpio controller.
-
   - samsung,spi-feedback-delay: The sampling phase shift to be applied on the
     miso line (to account for any lag in the miso line). The following are the
     valid values.
@@ -84,6 +82,7 @@ Example:
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi0_bus>;
+		cs-gpios = <&gpa2 5 0>;
 
 		w25q80bw@0 {
 			#address-cells = <1>;
@@ -93,7 +92,6 @@ Example:
 			spi-max-frequency = <10000>;
 
 			controller-data {
-				cs-gpio = <&gpa2 5 1 0 3>;
 				samsung,spi-feedback-delay = <0>;
 			};
 
-- 
2.0.0.rc2
