From: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: [PATCH 15/17] spi/topcliff-pch: Combine substrings for four messages
Date: Fri, 13 Jan 2017 18:25:42 +0100
Message-ID: <e349e57e-ba9c-6f01-74c8-75f84cf8f4c8@users.sourceforge.net>
References: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413e173-dbac-7a6e-09cb-2287300a335e-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Date: Fri, 13 Jan 2017 16:36:09 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: quoted string split across lines

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi-topcliff-pch.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index e4f1f66b751b..d36d42653087 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -621,8 +621,9 @@ static void pch_spi_set_tx(struct pch_spi_data *data, int *bpw)
 	if (n_writes > PCH_MAX_FIFO_DEPTH)
 		n_writes = PCH_MAX_FIFO_DEPTH;
 
-	dev_dbg(&data->master->dev, "\n%s:Pulling down SSN low - writing "
-		"0x2 to SSNXCR\n", __func__);
+	dev_dbg(&data->master->dev,
+		"\n%s:Pulling down SSN low - writing 0x2 to SSNXCR\n",
+		__func__);
 	pch_spi_writereg(data->master, PCH_SSNXCR, SSN_LOW);
 
 	for (j = 0; j < n_writes; j++)
@@ -1179,14 +1180,16 @@ static void pch_spi_process_messages(struct work_struct *pwork)
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
 
@@ -1231,9 +1234,8 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 
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

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
