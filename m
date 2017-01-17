From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi/topcliff-pch: Combine substrings for four messages" to the spi tree
Date: Tue, 17 Jan 2017 18:45:40 +0000
Message-ID: <E1cTYlI-0000HR-Hw@debutante>
References: <e349e57e-ba9c-6f01-74c8-75f84cf8f4c8@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e349e57e-ba9c-6f01-74c8-75f84cf8f4c8@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi/topcliff-pch: Combine substrings for four messages

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

>From b996356d305fd311eaa652890b255a0ff4d13de4 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 16:36:09 +0100
Subject: [PATCH] spi/topcliff-pch: Combine substrings for four messages

The script "checkpatch.pl" pointed information out like the following.

WARNING: quoted string split across lines

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 0a876311b67b..2b9405819075 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -622,8 +622,9 @@ static void pch_spi_set_tx(struct pch_spi_data *data, int *bpw)
 	if (n_writes > PCH_MAX_FIFO_DEPTH)
 		n_writes = PCH_MAX_FIFO_DEPTH;
 
-	dev_dbg(&data->master->dev, "\n%s:Pulling down SSN low - writing "
-		"0x2 to SSNXCR\n", __func__);
+	dev_dbg(&data->master->dev,
+		"\n%s:Pulling down SSN low - writing 0x2 to SSNXCR\n",
+		__func__);
 	pch_spi_writereg(data->master, PCH_SSNXCR, SSN_LOW);
 
 	for (j = 0; j < n_writes; j++)
@@ -1180,14 +1181,16 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 			data->cur_trans =
 				list_entry(data->current_msg->transfers.next,
 					   struct spi_transfer, transfer_list);
-			dev_dbg(&data->master->dev, "%s "
-				":Getting 1st transfer message\n", __func__);
+			dev_dbg(&data->master->dev,
+				"%s :Getting 1st transfer message\n",
+				__func__);
 		} else {
 			data->cur_trans =
 				list_entry(data->cur_trans->transfer_list.next,
 					   struct spi_transfer, transfer_list);
-			dev_dbg(&data->master->dev, "%s "
-				":Getting next transfer message\n", __func__);
+			dev_dbg(&data->master->dev,
+				"%s :Getting next transfer message\n",
+				__func__);
 		}
 		spin_unlock(&data->lock);
 
@@ -1232,9 +1235,8 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 
 		/* check for delay */
 		if (data->cur_trans->delay_usecs) {
-			dev_dbg(&data->master->dev, "%s:"
-				"delay in usec=%d\n", __func__,
-				data->cur_trans->delay_usecs);
+			dev_dbg(&data->master->dev, "%s:delay in usec=%d\n",
+				__func__, data->cur_trans->delay_usecs);
 			udelay(data->cur_trans->delay_usecs);
 		}
 
-- 
2.11.0
