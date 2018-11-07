From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: omap-spi: Add compatible for AM654 SoC" to the spi tree
Date: Wed,  7 Nov 2018 15:01:23 +0000 (GMT)
Message-ID: <20181107150123.5C5601124E14@debutante.sirena.org.uk>
References: <20181107103926.32550-2-vigneshr@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107103926.32550-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: omap-spi: Add compatible for AM654 SoC

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From abc61f47a70f7c8331f00eff1ccb6557a9d4c224 Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr@ti.com>
Date: Wed, 7 Nov 2018 16:09:25 +0530
Subject: [PATCH] spi: omap-spi: Add compatible for AM654 SoC

AM654 SoC has same McSPI IP as OMAP2+ platforms. Add new compatible to
support McSPI on AM654 SoC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/omap-spi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
index 2ba5f9c023ac..487208c256c0 100644
--- a/Documentation/devicetree/bindings/spi/omap-spi.txt
+++ b/Documentation/devicetree/bindings/spi/omap-spi.txt
@@ -2,6 +2,7 @@ OMAP2+ McSPI device
 
 Required properties:
 - compatible :
+  - "ti,am654-mcspi" for AM654.
   - "ti,omap2-mcspi" for OMAP2 & OMAP3.
   - "ti,omap4-mcspi" for OMAP4+.
 - ti,spi-num-cs : Number of chipselect supported  by the instance.
-- 
2.19.0.rc2
