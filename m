From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi/topcliff-pch: Improve size determinations in pch_spi_probe()" to the spi tree
Date: Tue, 17 Jan 2017 18:45:43 +0000
Message-ID: <E1cTYlL-0000Ik-HB@debutante>
References: <d2471abf-1eca-037f-3d10-ba03d8e987af@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d2471abf-1eca-037f-3d10-ba03d8e987af@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi/topcliff-pch: Improve size determinations in pch_spi_probe()

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

>From baa35f5734aa1c0207e4e6b8e15079475b1fa252 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 15:46:35 +0100
Subject: [PATCH] spi/topcliff-pch: Improve size determinations in
 pch_spi_probe()

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 1beeb16e836a..0a876311b67b 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1539,11 +1539,11 @@ static int pch_spi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	int i;
 	struct pch_pd_dev_save *pd_dev_save;
 
-	pd_dev_save = kzalloc(sizeof(struct pch_pd_dev_save), GFP_KERNEL);
+	pd_dev_save = kzalloc(sizeof(*pd_dev_save), GFP_KERNEL);
 	if (!pd_dev_save)
 		return -ENOMEM;
 
-	board_dat = kzalloc(sizeof(struct pch_spi_board_data), GFP_KERNEL);
+	board_dat = kzalloc(sizeof(*board_dat), GFP_KERNEL);
 	if (!board_dat) {
 		retval = -ENOMEM;
 		goto err_no_mem;
-- 
2.11.0
