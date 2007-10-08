From: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 3/4 2.6.23-rc2 + mm2-git-mmc] MMC
 core learns about SPI
Date: Mon, 08 Oct 2007 19:09:30 +0200
Message-ID: <470A644A.8030405@gmail.com>
References: <200708080906.18993.david-b@pacbell.net>	<20070829092247.GA15021@pengutronix.de>	<20070829165243.0236cc89@poseidon.drzeus.cx>
	<200708290943.59450.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020604040906030307060804"
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200708290943.59450.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

This is a multi-part message in MIME format.
--------------020604040906030307060804
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

David Brownell wrote:
> On Wednesday 29 August 2007, Pierre Ossman wrote:
>>> I need the following patch on my (little endian) System to
>>> successfully read the csd/cid structure.
>> The resp field should already be in host order, so there must be a bug
>> in the mmc/spi host controller driver.
> 
> I wouldn't think it could be in host order ... what would have
> changed it from wire-order, if not for a patch like Sascha sent?
> 
> This sounds like exactly the failure I'd expect from bugs caused
> by omitted byteswapping, since I did all my recent work on a
> big-endian machine.
> 

I can confirm, that the byte-swapping patch from Sascha is needed on my
little endian mips testbed too.

I can also see, that in earlier versions of mmc-spi, the byte swapping
was present in there together with routine to read csd/cid. Now it is
handled in mmc core, without byte swapping, so it does not work on
little endian systems...

I've tested mmc-spi from linux-2.6.23-rc8-mm2, plus:
  - added byte-swapping patch from Sascha
  - added buffer length patch from Sascha as improved by David

This resulted in nearly working mmc-spi, except the problem with the
last sector(s).
Tried to apply the fix to force single block read for last sector as
suggested by Sascha, but it fails not with the last sector, but several
of them at the end, with following error:
mmcblk0: error -22 sending stop command

Changing the patch to use single block reads for any of 8 sectors at the
end of sd card, it works perfectly.

In addition to that, it seems, that retries are not enabled for sector
access in mmc core, so I needed to add set of brq.cmd.retries into
mmc_blk_issue_rq() and also checking of mrq->data->error and
mrq->stop->error with call to host->ops->request() into mmc_request_done().

Otherwise, block transfers are never retried. And there are cases, that
errors are caused by too long wires and high frequencies in my
environment, so retries are sometimes very useful.

Finally I have tested also the suspend/resume callbacks of mmc core.
As I am using sd card in embedded environment (assuming that sd card
will never be removed), so MMC_UNSAFE_RESUME is good to me.

However, it seems to me, that the
-               if (!blk_queue_plugged(q))
                        req = elv_next_request(q);
in mmc_queue_thread() is too kind to accept new requests, even when the
queue is stopped.

This seems to be much better for faster suspending:
+               if (!blk_queue_plugged(q) && !blk_queue_stopped(q))
                        req = elv_next_request(q);
so that new requests are not accepted if queue is stopped or plugged.

See the complete patches bellow, please.

Thanks and best regards,
Jan


--------------020604040906030307060804
Content-Type: text/plain;
 name="mmc-last-block-single-block-read.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="mmc-last-block-single-block-read.patch"

diff -urNp linux-2.6-orig/drivers/mmc/card/block.c linux-2.6/drivers/mmc/card/block.c
--- linux-2.6-orig/drivers/mmc/card/block.c	2007-10-08 15:39:28.000000000 +0200
+++ linux-2.6/drivers/mmc/card/block.c	2007-10-08 15:00:55.000000000 +0200
@@ -244,6 +244,16 @@ static int mmc_blk_issue_rq(struct mmc_q
 		    !mmc_card_sd(card))
 			brq.data.blocks = 1;
 
+		/* Some SD cards in SPI mode return a crc error when trying
+		 * to read the last block using a multiread command.
+		 */
+		if (mmc_host_is_spi(card->host)
+				&& brq.data.blocks > 1
+				&& rq_data_dir(req) == READ
+				&& req->sector + req->nr_sectors >=
+					get_capacity(md->disk)-8)
+			brq.data.blocks = 1;
+
 		if (brq.data.blocks > 1) {
 			/* SPI multiblock writes terminate using a special
 			 * token, not a STOP_TRANSMISSION request.

--------------020604040906030307060804
Content-Type: text/plain;
 name="mmc-sector-retry-enable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-sector-retry-enable.patch"

diff -urNp linux-2.6-orig/drivers/mmc/card/block.c linux-2.6/drivers/mmc/card/block.c
--- linux-2.6-orig/drivers/mmc/card/block.c	2007-10-08 10:26:01.000000000 +0200
+++ linux-2.6/drivers/mmc/card/block.c	2007-10-08 10:29:17.000000000 +0200
@@ -224,6 +224,7 @@ static int mmc_blk_issue_rq(struct mmc_q
 		if (!mmc_card_blockaddr(card))
 			brq.cmd.arg <<= 9;
 		brq.cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+		brq.cmd.retries = 8;
 		brq.data.blksz = 1 << md->block_bits;
 		brq.stop.opcode = MMC_STOP_TRANSMISSION;
 		brq.stop.arg = 0;
diff -urNp linux-2.6-orig/drivers/mmc/core/core.c linux-2.6/drivers/mmc/core/core.c
--- linux-2.6-orig/drivers/mmc/core/core.c	2007-10-08 10:26:01.000000000 +0200
+++ linux-2.6/drivers/mmc/core/core.c	2007-10-08 17:01:12.000000000 +0200
@@ -102,6 +102,13 @@ void mmc_request_done(struct mmc_host *h
 			pr_debug("%s:     %d bytes transferred: %d\n",
 				mmc_hostname(host),
 				mrq->data->bytes_xfered, mrq->data->error);
+			if (mrq->data->error && cmd->retries) {
+				pr_debug("  ...DATA error: retrying...\n");
+				cmd->retries--;
+				cmd->error = 0;
+				mrq->data->error = 0;
+				host->ops->request(host, mrq);
+			}
 		}
 
 		if (mrq->stop) {
@@ -110,6 +117,13 @@ void mmc_request_done(struct mmc_host *h
 				mrq->stop->error,
 				mrq->stop->resp[0], mrq->stop->resp[1],
 				mrq->stop->resp[2], mrq->stop->resp[3]);
+			if (mrq->stop->error && cmd->retries) {
+				pr_debug("  ...STOP error: retrying...\n");
+				cmd->retries--;
+				cmd->error = 0;
+				mrq->stop->error = 0;
+				host->ops->request(host, mrq);
+			}
 		}
 
 		if (mrq->done)

--------------020604040906030307060804
Content-Type: text/plain;
 name="mmc-suspend-queue-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-suspend-queue-fix.patch"

diff -urNp linux-2.6-orig/drivers/mmc/card/queue.c linux-2.6/drivers/mmc/card/queue.c
--- linux-2.6-orig/drivers/mmc/card/queue.c	2007-10-08 10:26:01.000000000 +0200
+++ linux-2.6/drivers/mmc/card/queue.c	2007-10-08 10:31:00.000000000 +0200
@@ -53,7 +53,7 @@ static int mmc_queue_thread(void *d)
 
 		spin_lock_irq(q->queue_lock);
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (!blk_queue_plugged(q))
+		if (!blk_queue_plugged(q) && !blk_queue_stopped(q))
 			req = elv_next_request(q);
 		mq->req = req;
 		spin_unlock_irq(q->queue_lock);

--------------020604040906030307060804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--------------020604040906030307060804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--------------020604040906030307060804--
