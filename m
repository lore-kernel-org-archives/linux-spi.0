From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: fsl-qspi: Enhance binding to extend example for flash entry" to the spi tree
Date: Thu, 22 Aug 2019 20:22:57 +0100 (BST)
Message-ID: <20190822192257.CF419D02CB0@fitzroy.sirena.org.uk>
References: <1565691791-26167-3-git-send-email-Ashish.Kumar@nxp.com>
Cc: broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, robh+dt@kernel.org
To: Ashish Kumar <Ashish.Kumar@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565691791-26167-3-git-send-email-Ashish.Kumar@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: fsl-qspi: Enhance binding to extend example for flash entry

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

>From 303290e130bfd504a8230f49e545f6b91e120553 Mon Sep 17 00:00:00 2001
From: Ashish Kumar <Ashish.Kumar@nxp.com>
Date: Tue, 13 Aug 2019 15:53:11 +0530
Subject: [PATCH] spi: fsl-qspi: Enhance binding to extend example for flash
 entry

Add example for adding flash entry on various boards' dts
using flash manufacture spansion/cypress.

Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
Link: https://lore.kernel.org/r/1565691791-26167-3-git-send-email-Ashish.Kumar@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
index e8f1d627d288..1b23cfd7b39b 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
@@ -34,7 +34,11 @@ qspi0: quadspi@40044000 {
 	clock-names = "qspi_en", "qspi";
 
 	flash0: s25fl128s@0 {
-		....
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s", "jedec,spi-nor";
+		spi-max-frequency = <50000000>;
+		reg = <0>;
 	};
 };
 
-- 
2.20.1
