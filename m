From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Add Spreadtrum ADI controller documentation" to the spi tree
Date: Tue, 19 Sep 2017 14:47:47 +0100
Message-ID: <E1duIsN-000054-Le@debutante>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Add Spreadtrum ADI controller documentation

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2f329595b8db42ceb3de93595a740ac7b24eddba Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Date: Fri, 15 Sep 2017 15:29:15 +0800
Subject: [PATCH] spi: Add Spreadtrum ADI controller documentation

This patch adds the binding documentation for Spreadtrum ADI
controller device.

Signed-off-by: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-sprd-adi.txt       | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd-adi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt b/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
new file mode 100644
index 000000000000..8de589b376ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
@@ -0,0 +1,58 @@
+Spreadtrum ADI controller
+
+ADI is the abbreviation of Anolog-Digital interface, which is used to access
+analog chip (such as PMIC) from digital chip. ADI controller follows the SPI
+framework for its hardware implementation is alike to SPI bus and its timing
+is compatile to SPI timing.
+
+ADI controller has 50 channels including 2 software read/write channels and
+48 hardware channels to access analog chip. For 2 software read/write channels,
+users should set ADI registers to access analog chip. For hardware channels,
+we can configure them to allow other hardware components to use it independently,
+which means we can just link one analog chip address to one hardware channel,
+then users can access the mapped analog chip address by this hardware channel
+triggered by hardware components instead of ADI software channels.
+
+Thus we introduce one property named "sprd,hw-channels" to configure hardware
+channels, the first value specifies the hardware channel id which is used to
+transfer data triggered by hardware automatically, and the second value specifies
+the analog chip address where user want to access by hardware components.
+
+Since we have multi-subsystems will use unique ADI to access analog chip, when
+one system is reading/writing data by ADI software channels, that should be under
+one hardware spinlock protection to prevent other systems from reading/writing
+data by ADI software channels at the same time, or two parallel routine of setting
+ADI registers will make ADI controller registers chaos to lead incorrect results.
+Then we need one hardware spinlock to synchronize between the multiple subsystems.
+
+Required properties:
+- compatible: Should be "sprd,sc9860-adi".
+- reg: Offset and length of ADI-SPI controller register space.
+- hwlocks: Reference to a phandle of a hwlock provider node.
+- hwlock-names: Reference to hwlock name strings defined in the same order
+	as the hwlocks, should be "adi".
+- #address-cells: Number of cells required to define a chip select address
+	on the ADI-SPI bus. Should be set to 1.
+- #size-cells: Size of cells required to define a chip select address size
+	on the ADI-SPI bus. Should be set to 0.
+
+Optional properties:
+- sprd,hw-channels: This is an array of channel values up to 49 channels.
+	The first value specifies the hardware channel id which is used to
+	transfer data triggered by hardware automatically, and the second
+	value specifies the analog chip address where user want to access
+	by hardware components.
+
+SPI slave nodes must be children of the SPI controller node and can contain
+properties described in Documentation/devicetree/bindings/spi/spi-bus.txt.
+
+Example:
+	adi_bus: spi@40030000 {
+		compatible = "sprd,sc9860-adi";
+		reg = <0 0x40030000 0 0x10000>;
+		hwlocks = <&hwlock1 0>;
+		hwlock-names = "adi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		sprd,hw-channels = <30 0x8c20>;
+	};
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
