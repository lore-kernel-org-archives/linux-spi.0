From: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 1/2] documentation: add rockchip spi documentation
Date: Tue,  1 Jul 2014 09:02:57 +0800
Message-ID: <1404176577-3274-1-git-send-email-addy.ke@rock-chips.com>
References: <1403582324-9485-2-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wei.luo-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1403582324-9485-2-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
changes since v1:
- fix binding document according to comments from Mark Rutland
- fix address according to comments from Mark Brown
- combine all properties into "Required Properties" suggested by Heiko =
St=C3=BCbner
- remove "Board Specific Portion" suggested by Heiko St=C3=BCbner

 .../devicetree/bindings/spi/spi-rockchip.txt       | 37 ++++++++++++++=
++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-rockchip.=
txt

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/D=
ocumentation/devicetree/bindings/spi/spi-rockchip.txt
new file mode 100644
index 0000000..7bab355
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
@@ -0,0 +1,37 @@
+* Rockchip SPI Controller
+
+The Rockchip SPI controller is used to interface with various devices =
such as flash
+and display controllers using the SPI communication interface.
+
+Required Properties:
+
+- compatible: should be one of the following.
+    "rockchip,rk3066-spi" for rk3066.
+    "rockchip,rk3188-spi", "rockchip,rk3066-spi" for rk3188.
+    "rockchip,rk3288-spi", "rockchip,rk3066-spi" for rk3288.
+- reg: physical base address of the controller and length of memory ma=
pped
+       region.
+- interrupts: The interrupt number to the cpu. The interrupt specifier=
 format
+              depends on the interrupt controller.
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Shall be "spiclk" for the transfer-clock, and "apb_pclk=
" for
+			   the peripheral clock.
+- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
+		Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: DMA request names should include "tx" and "rx" if present=
=2E
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+
+Example:
+
+	spi0: spi@ff110000 {
+		compatible =3D "rockchip,rk3066-spi";
+		reg =3D <0xff110000 0x1000>;
+		dmas =3D <&pdma1 11>, <&pdma1 12>;
+		dma-names =3D "tx", "rx";
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		interrupts =3D <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+		clocks =3D <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
+		clock-names =3D "spiclk", "apb_pclk";
+	};
--=20
1.8.3.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
