From: Mark Brown <broonie@kernel.org>
Subject: Applied "MAINTAINERS: add maintainers for the NXP FlexSPI driver" to the spi tree
Date: Mon, 28 Jan 2019 12:36:06 +0000 (GMT)
Message-ID: <20190128123606.2F8641127D29@debutante.sirena.org.uk>
References: <1547553487-9936-6-git-send-email-yogeshnarayan.gaur@nxp.com>
Cc: Mark Brown <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547553487-9936-6-git-send-email-yogeshnarayan.gaur@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   MAINTAINERS: add maintainers for the NXP FlexSPI driver

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

>From c71f9fd4503addcfa306f9bec95c3e7deade7ce1 Mon Sep 17 00:00:00 2001
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Date: Tue, 15 Jan 2019 12:00:37 +0000
Subject: [PATCH] MAINTAINERS: add maintainers for the NXP FlexSPI driver

Add maintainers for the NXP FlexSPI driver

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b6c0d454d7e..5e7ec7cda3bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10927,6 +10927,14 @@ F:	lib/objagg.c
 F:	lib/test_objagg.c
 F:	include/linux/objagg.h
 
+NXP FSPI DRIVER
+R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
+M:	Ashish Kumar <ashish.kumar@nxp.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-nxp-fspi.c
+F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.20.1
