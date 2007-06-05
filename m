From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.22-rc4 6/7] MMC block understands SPI
Date: Mon, 4 Jun 2007 20:38:28 -0700
Message-ID: <200706042038.29283.david-b@pacbell.net>
References: <200706042025.18252.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706042025.18252.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Teach the MMC/SD block card driver about SPI.

 - Provide the SPI response type flags with each request issued.  The
   model is that if no such flags are provided, it will be rejected 
   by the MMC-over-SPI host.

 - Understand that multiblock SPI writes don't use STOP_TRANSMISSION.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/mmc/card/block.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- g26.orig/drivers/mmc/card/block.c	2007-05-24 12:04:46.000000000 -0700
+++ g26/drivers/mmc/card/block.c	2007-06-04 19:59:00.000000000 -0700
@@ -151,7 +151,7 @@ static u32 mmc_sd_num_wr_blocks(struct m
 
 	cmd.opcode = MMC_APP_CMD;
 	cmd.arg = card->rca << 16;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if ((err != MMC_ERR_NONE) || !(cmd.resp[0] & R1_APP_CMD))
@@ -161,7 +161,7 @@ static u32 mmc_sd_num_wr_blocks(struct m
 
 	cmd.opcode = SD_APP_SEND_NUM_WR_BLKS;
 	cmd.arg = 0;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
 	memset(&data, 0, sizeof(struct mmc_data));
 
@@ -220,11 +220,11 @@ static int mmc_blk_issue_rq(struct mmc_q
 		brq.cmd.arg = req->sector;
 		if (!mmc_card_blockaddr(card))
 			brq.cmd.arg <<= 9;
-		brq.cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+		brq.cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 		brq.data.blksz = 1 << md->block_bits;
 		brq.stop.opcode = MMC_STOP_TRANSMISSION;
 		brq.stop.arg = 0;
-		brq.stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
+		brq.stop.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 		brq.data.blocks = req->nr_sectors >> (md->block_bits - 9);
 		if (brq.data.blocks > card->host->max_blk_count)
 			brq.data.blocks = card->host->max_blk_count;
@@ -244,7 +244,12 @@ static int mmc_blk_issue_rq(struct mmc_q
 
 		if (brq.data.blocks > 1) {
 			brq.data.flags |= MMC_DATA_MULTI;
-			brq.mrq.stop = &brq.stop;
+			/* SPI multiblock writes terminate using a special
+			 * token, not a STOP_TRANSMISSION request.
+			 */
+			if (!mmc_host_is_spi(card->host)
+					|| rq_data_dir(req) == READ)
+				brq.mrq.stop = &brq.stop;
 			readcmd = MMC_READ_MULTIPLE_BLOCK;
 			writecmd = MMC_WRITE_MULTIPLE_BLOCK;
 		} else {
@@ -303,7 +308,8 @@ static int mmc_blk_issue_rq(struct mmc_q
 
 				cmd.opcode = MMC_SEND_STATUS;
 				cmd.arg = card->rca << 16;
-				cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+				cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1
+						| MMC_CMD_AC;
 				err = mmc_wait_for_cmd(card->host, &cmd, 5);
 				if (err) {
 					printk(KERN_ERR "%s: error %d requesting status\n",
@@ -506,7 +512,7 @@ mmc_blk_set_blksize(struct mmc_blk_data 
 	mmc_claim_host(card->host);
 	cmd.opcode = MMC_SET_BLOCKLEN;
 	cmd.arg = 1 << md->block_bits;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 	err = mmc_wait_for_cmd(card->host, &cmd, 5);
 	mmc_release_host(card->host);
 

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
