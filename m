From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Update NPCM PSPI controller documentation" to the spi tree
Date: Thu,  6 Dec 2018 20:26:21 +0000 (GMT)
Message-ID: <20181206202621.6D6ED11252F7@debutante.sirena.org.uk>
References: <20181204135442.125269-1-tmaimon77@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, yuenn@google.com,
        venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au, linux-spi@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
To: Tomer Maimon <tmaimon77@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204135442.125269-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Update NPCM PSPI controller documentation

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

>From 6ab4a3502923c20c5a6921868e787e5fd033409b Mon Sep 17 00:00:00 2001
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Tue, 4 Dec 2018 15:54:42 +0200
Subject: [PATCH] spi: Update NPCM PSPI controller documentation

Update the PSPI NPCM binding document of the spi aliases use
to define the spi ID number.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/nuvoton,npcm-pspi.txt         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
index 99606b22e5c2..1fd9a4406a1d 100644
--- a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
@@ -19,8 +19,16 @@ Optional properties:
 - clock-frequency : Input clock frequency to the PSPI block in Hz.
 		    Default is 25000000 Hz.
 
+Aliases:
+- All the SPI controller nodes should be represented in the aliases node using
+  the following format 'spi{n}' withe the correct numbered in "aliases" node.
+
 Example:
 
+aliases {
+	spi0 = &spi0;
+};
+
 spi0: spi@f0200000 {
 	compatible = "nuvoton,npcm750-pspi";
 	reg = <0xf0200000 0x1000>;
-- 
2.19.0.rc2
