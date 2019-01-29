From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-mem: spi-nxp-fspi: add module license info" to the spi tree
Date: Tue, 29 Jan 2019 12:14:24 +0000 (GMT)
Message-ID: <20190129121424.23FA01127D50@debutante.sirena.org.uk>
References: <1548755240-27319-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        linux-spi@vger.kernel.org
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548755240-27319-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-mem: spi-nxp-fspi: add module license info

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

>From ce6f0697ebadb90cc37a6ef081384c115bdda196 Mon Sep 17 00:00:00 2001
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Date: Tue, 29 Jan 2019 09:49:22 +0000
Subject: [PATCH] spi: spi-mem: spi-nxp-fspi: add module license info

Add MODULE_LICENSE info to fix below warning:
WARNING: modpost: missing MODULE_LICENSE() in drivers/spi/spi-nxp-fspi.o

Typo fix in Boris Brezillon last name.

Fixes: a5356aef6a90 ("spi: spi-mem: Add driver for NXP FlexSPI controller")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-nxp-fspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 0327216ef7aa..8894f98cc99c 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -26,7 +26,7 @@
  *
  * Author:
  *     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
- *     Boris Brezillion <bbrezillon@kernel.org>
+ *     Boris Brezillon <bbrezillon@kernel.org>
  *     Frieder Schrempf <frieder.schrempf@kontron.de>
  */
 
@@ -1101,5 +1101,6 @@ module_platform_driver(nxp_fspi_driver);
 MODULE_DESCRIPTION("NXP FSPI Controller Driver");
 MODULE_AUTHOR("NXP Semiconductor");
 MODULE_AUTHOR("Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>");
-MODULE_AUTHOR("Boris Brezillion <bbrezillon@kernel.org>");
+MODULE_AUTHOR("Boris Brezillon <bbrezillon@kernel.org>");
 MODULE_AUTHOR("Frieder Schrempf <frieder.schrempf@kontron.de>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1
