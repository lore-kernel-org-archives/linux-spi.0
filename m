From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-spi: remove always-true conditional in fsl_spi_do_one_msg" to the spi tree
Date: Mon,  1 Apr 2019 09:54:27 +0100 (BST)
Message-ID: <20190401085427.177EA440083@finisterre.ee.mobilebroadband>
References: <20190327143040.16013-2-rasmus.villemoes@prevas.dk>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        linux-spi@vger.kernel.org
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327143040.16013-2-rasmus.villemoes@prevas.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-fsl-spi: remove always-true conditional in fsl_spi_do_one_msg

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

>From 24c363623361b430fb79459ca922e816e6f48603 Mon Sep 17 00:00:00 2001
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date: Wed, 27 Mar 2019 14:30:50 +0000
Subject: [PATCH] spi: spi-fsl-spi: remove always-true conditional in
 fsl_spi_do_one_msg

__spi_validate() in the generic SPI code sets ->speed_hz and
->bits_per_word to non-zero values, so this condition is always true.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-spi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 3d7b50c65f36..6d114daa178a 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -384,12 +384,10 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	cs_change = 1;
 	status = -EINVAL;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->bits_per_word || t->speed_hz) {
-			if (cs_change)
-				status = fsl_spi_setup_transfer(spi, t);
-			if (status < 0)
-				break;
-		}
+		if (cs_change)
+			status = fsl_spi_setup_transfer(spi, t);
+		if (status < 0)
+			break;
 
 		if (cs_change) {
 			fsl_spi_chipselect(spi, BITBANG_CS_ACTIVE);
-- 
2.20.1
