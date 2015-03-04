From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 2/2] dt/bindings: control CS via standard GPIO operations
 instead of SPI-HW
Date: Wed,  4 Mar 2015 16:40:04 +0000
Message-ID: <1425487205-5477-2-git-send-email-kernel@martin.sperl.org>
References: <1425487205-5477-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
 devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1425487205-5477-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Change the device tree to use cs-gpios for the spi bus master
and standard gpio operation instead of relying on the HW with
just 2 chip_selects using ALT0.

This reassigns the existing CS pins 7(=CS1) and 8(=CS0)
as output instead of ALT0 (=SPI HW block controlled) 
and adds them in the list of cs-gpios for the spi-bus.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

---
 arch/arm/boot/dts/bcm2835-rpi.dtsi |    4 ++--
 arch/arm/boot/dts/bcm2835.dtsi     |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index c706448..f0e36ab 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -20,12 +20,12 @@
 	pinctrl-names = "default";
 
 	gpioout: gpioout {
-		brcm,pins = <6>;
+		brcm,pins = <6 7 8>;
 		brcm,function = <1>; /* GPIO out */
 	};
 
 	alt0: alt0 {
-		brcm,pins = <0 1 2 3 4 5 7 8 9 10 11 14 15 40 45>;
+		brcm,pins = <0 1 2 3 4 5 9 10 11 14 15 40 45>;
 		brcm,function = <4>; /* alt0 */
 	};
 
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 3342cb1..74d08e1 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -110,6 +110,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
+			cs-gpios = <&gpio 8 0>, <&gpio 7 0>;
 		};
 
 		i2c0: i2c@20205000 {
-- 
1.7.10.4
