From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi/topcliff-pch: Delete an error message for a failed memory allocation in pch_spi_set_tx()" to the spi tree
Date: Tue, 17 Jan 2017 18:45:36 +0000
Message-ID: <E1cTYlE-0000G7-IW@debutante>
References: <b72c78dc-32b2-0f8f-8d3d-575ce4bff02f@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-spi@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b72c78dc-32b2-0f8f-8d3d-575ce4bff02f@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi/topcliff-pch: Delete an error message for a failed memory allocation in pch_spi_set_tx()

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

>From 45e861a1c12cfd717b8e47103f1aaf2e34cc6688 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 17:00:08 +0100
Subject: [PATCH] spi/topcliff-pch: Delete an error message for a failed memory
 allocation in pch_spi_set_tx()

Omit an extra message for a memory allocation failure in this function.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 2b9405819075..97d137591b18 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -591,7 +591,6 @@ static void pch_spi_set_tx(struct pch_spi_data *data, int *bpw)
 
 	if (!data->pkt_rx_buff) {
 		/* flush queue and set status of all transfers to -ENOMEM */
-		dev_err(&data->master->dev, "%s :kzalloc failed\n", __func__);
 		list_for_each_entry_safe(pmsg, tmp, data->queue.next, queue) {
 			pmsg->status = -ENOMEM;
 
-- 
2.11.0
