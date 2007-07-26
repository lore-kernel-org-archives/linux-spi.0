From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 2/4] MMC block learns
	about SPI
Date: Thu, 26 Jul 2007 13:15:03 -0700
Message-ID: <200707261315.04474.david-b@pacbell.net>
References: <200707141504.51950.david-b@pacbell.net>
	<200707261000.17339.david-b@pacbell.net>
	<20070726200639.06242858@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070726200639.06242858-mgABNEgzgxm+PRNnhPf8W5YgPPQkE1Si@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 26 July 2007, Pierre Ossman wrote:
> On Thu, 26 Jul 2007 10:00:16 -0700
> David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> 
> > 
> > But then it can't hurt either, and will be safer to cut'n'paste.  :)
> > 
> > Andrew Morton regularly gives feedback which amounts to "that's correct
> > in this context, but please adopt this always-safe idiom" on the grounds
> > that a *LOT* of Linux code is developed by cloning.  It's hard for me to
> > disagree with that... especially when I see my code showing up in some
> > rather strange contexts!
> > 
> 
> Fair enough. But then you'd probably also need to have a look at the
> clause terminating that while loop. I believe it is specific to the 
> native protocol.  

Sigh; yes it is.  In this case, the code won't be cut/pastable.  ;)

Updated patch appended.  (BTW these refreshes are against current GIT.)

========	CUT HERE
Teaching the MMC/SD block card driver about SPI.

 - Provide the SPI response type flags with each request issued.  The
   model is that if no such flags are provided, it will be rejected 
   by the MMC-over-SPI host.

 - Understand that multiblock SPI writes don't use STOP_TRANSMISSION.

 - Correct check for APP_CMD failure.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/mmc/card/block.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- g26.orig/drivers/mmc/card/block.c	2007-07-26 13:06:46.000000000 -0700
+++ g26/drivers/mmc/card/block.c	2007-07-26 13:13:38.000000000 -0700
@@ -151,17 +151,19 @@ static u32 mmc_sd_num_wr_blocks(struct m
 
 	cmd.opcode = MMC_APP_CMD;
 	cmd.arg = card->rca << 16;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
-	if ((err != MMC_ERR_NONE) || !(cmd.resp[0] & R1_APP_CMD))
+	if (err != MMC_ERR_NONE)
+		return (u32)-1;
+	if (!mmc_host_is_spi(card->host) && !(cmd.resp[0] & R1_APP_CMD))
 		return (u32)-1;
 
 	memset(&cmd, 0, sizeof(struct mmc_command));
 
 	cmd.opcode = SD_APP_SEND_NUM_WR_BLKS;
 	cmd.arg = 0;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
 	memset(&data, 0, sizeof(struct mmc_data));
 
@@ -220,11 +222,11 @@ static int mmc_blk_issue_rq(struct mmc_q
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
@@ -244,7 +246,12 @@ static int mmc_blk_issue_rq(struct mmc_q
 
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
@@ -302,7 +309,7 @@ static int mmc_blk_issue_rq(struct mmc_q
 			goto cmd_err;
 		}
 
-		if (rq_data_dir(req) != READ) {
+		if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
 			do {
 				int err;
 
@@ -510,7 +517,7 @@ mmc_blk_set_blksize(struct mmc_blk_data 
 	mmc_claim_host(card->host);
 	cmd.opcode = MMC_SET_BLOCKLEN;
 	cmd.arg = 1 << md->block_bits;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 	err = mmc_wait_for_cmd(card->host, &cmd, 5);
 	mmc_release_host(card->host);
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
