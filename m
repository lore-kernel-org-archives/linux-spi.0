From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 10/28] ARM: dts: mmp3: fix USB & USB PHY node names
Date: Tue, 17 Mar 2020 10:39:04 +0100
Message-ID: <20200317093922.20785-11-lkundrak@v3.sk>
References: <20200317093922.20785-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        devicetree@vger.kerne
To: Rob Herring <robh+dt@kernel.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20200317093922.20785-1-lkundrak@v3.sk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

There are better generic ones and the validation is going to complain:

  mmp3-dell-ariel.dt.yaml: hsic@f0001000: $nodename:0: 'hsic@f0001000'
      does not match '^usb(@.*)?'
  mmp3-dell-ariel.dt.yaml: hsic@f0002000: $nodename:0: 'hsic@f0002000'
      does not match '^usb(@.*)?'
  ...

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp3.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
index eaff9b1bc1d9f..fc75f96106351 100644
--- a/arch/arm/boot/dts/mmp3.dtsi
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -183,14 +183,14 @@ hsi0_mux: interrupt-controller@d42821d0 {
 				mrvl,intc-nr-irqs = <5>;
 			};
 
-			usb_otg_phy0: usb-otg-phy@d4207000 {
+			usb_otg_phy0: usb-phy@d4207000 {
 				compatible = "marvell,mmp3-usb-phy";
 				reg = <0xd4207000 0x40>;
 				#phy-cells = <0>;
 				status = "disabled";
 			};
 
-			usb_otg0: usb-otg@d4208000 {
+			usb_otg0: usb@d4208000 {
 				compatible = "marvell,pxau2o-ehci";
 				reg = <0xd4208000 0x200>;
 				interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
@@ -201,7 +201,7 @@ usb_otg0: usb-otg@d4208000 {
 				status = "disabled";
 			};
 
-			hsic_phy0: hsic-phy@f0001800 {
+			hsic_phy0: usb-phy@f0001800 {
 				compatible = "marvell,mmp3-hsic-phy",
 					     "usb-nop-xceiv";
 				reg = <0xf0001800 0x40>;
@@ -209,7 +209,7 @@ hsic_phy0: hsic-phy@f0001800 {
 				status = "disabled";
 			};
 
-			hsic0: hsic@f0001000 {
+			hsic0: usb@f0001000 {
 				compatible = "marvell,pxau2o-ehci";
 				reg = <0xf0001000 0x200>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
@@ -223,7 +223,7 @@ hsic0: hsic@f0001000 {
 				status = "disabled";
 			};
 
-			hsic_phy1: hsic-phy@f0002800 {
+			hsic_phy1: usb-phy@f0002800 {
 				compatible = "marvell,mmp3-hsic-phy",
 					     "usb-nop-xceiv";
 				reg = <0xf0002800 0x40>;
@@ -231,7 +231,7 @@ hsic_phy1: hsic-phy@f0002800 {
 				status = "disabled";
 			};
 
-			hsic1: hsic@f0002000 {
+			hsic1: usb@f0002000 {
 				compatible = "marvell,pxau2o-ehci";
 				reg = <0xf0002000 0x200>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1
