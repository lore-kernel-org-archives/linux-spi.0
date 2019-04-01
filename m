From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-spi: relax message sanity checking a little" to the spi tree
Date: Mon,  1 Apr 2019 09:54:23 +0100 (BST)
Message-ID: <20190401085424.08C89440082@finisterre.ee.mobilebroadband>
References: <20190327143040.16013-3-rasmus.villemoes@prevas.dk>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        linux-spi@vger.kernel.org
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327143040.16013-3-rasmus.villemoes@prevas.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-fsl-spi: relax message sanity checking a little

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

>From 17ecffa289489e8442306bbc62ebb964e235cdad Mon Sep 17 00:00:00 2001
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date: Wed, 27 Mar 2019 14:30:51 +0000
Subject: [PATCH] spi: spi-fsl-spi: relax message sanity checking a little

The comment says that we should not allow changes (to
bits_per_word/speed_hz) while CS is active, and indeed the code below
does fsl_spi_setup_transfer() when the ->cs_change of the previous
spi_transfer was set (and for the very first transfer).

So the sanity checking is a bit too strict - we can change it to
follow the same logic as is used by the actual transfer loop.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 6d114daa178a..481b075689b5 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -370,13 +370,15 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	int status;
 
 	/* Don't allow changes if CS is active */
-	first = list_first_entry(&m->transfers, struct spi_transfer,
-			transfer_list);
+	cs_change = 1;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (cs_change)
+			first = t;
+		cs_change = t->cs_change;
 		if ((first->bits_per_word != t->bits_per_word) ||
 			(first->speed_hz != t->speed_hz)) {
 			dev_err(&spi->dev,
-				"bits_per_word/speed_hz should be same for the same SPI transfer\n");
+				"bits_per_word/speed_hz cannot change while CS is active\n");
 			return -EINVAL;
 		}
 	}
-- 
2.20.1
