From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "dt-bindings: spi: imx: Add i.MX8MM/i.MX8MN/i.MX8MP compatible" to the spi tree
Date: Tue, 11 Feb 2020 15:51:39 +0000
Message-ID: <applied-1581425307-18567-1-git-send-email-Anson.Huang@nxp.com>
References: <1581425307-18567-1-git-send-email-Anson.Huang@nxp.com>
Cc: aisheng.dong-3arQi8VN3Tc@public.gmane.org, andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, angus-HsWYs6tNinE@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, cosmin.stoica-3arQi8VN3Tc@public.gmane.org, daniel.baluta-3arQi8VN3Tc@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, jun.li-3arQi8VN3Tc@public.gmane.org,
        kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, leonard.crestez-3arQi8VN3Tc@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux-imx-3arQi8VN3Tc@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, manivannan.sadhasivam-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, pramod.kumar_1-3arQi8VN3Tc@public.gmane.org, rabeeh-UBr1pzP51AyaMJb+Lgu22Q@public.gmane.org,
        rjones-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1581425307-18567-1-git-send-email-Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   dt-bindings: spi: imx: Add i.MX8MM/i.MX8MN/i.MX8MP compatible

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

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

>From 1565e8e8ef0bbccabf62152b93c6505b8041b1e5 Mon Sep 17 00:00:00 2001
From: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Date: Tue, 11 Feb 2020 20:48:24 +0800
Subject: [PATCH] dt-bindings: spi: imx: Add i.MX8MM/i.MX8MN/i.MX8MP compatible

Add compatible for imx8mm/imx8mn/imx8mp.

Signed-off-by: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Link: https://lore.kernel.org/r/1581425307-18567-1-git-send-email-Anson.Huang-3arQi8VN3Tc@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 2d3264140cc5..33bc58f4cf4b 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -10,7 +10,10 @@ Required properties:
   - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
   - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
   - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
-  - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8M
+  - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8MQ
+  - "fsl,imx8mm-ecspi" for SPI compatible with the one integrated on i.MX8MM
+  - "fsl,imx8mn-ecspi" for SPI compatible with the one integrated on i.MX8MN
+  - "fsl,imx8mp-ecspi" for SPI compatible with the one integrated on i.MX8MP
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain CSPI/eCSPI interrupt
 - clocks : Clock specifiers for both ipg and per clocks.
-- 
2.20.1
