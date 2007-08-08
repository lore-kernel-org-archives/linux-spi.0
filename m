From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 3/4 2.6.23-rc2 + mm2-git-mmc] MMC core
	learns about SPI
Date: Wed, 8 Aug 2007 09:11:32 -0700
Message-ID: <200708080911.33099.david-b@pacbell.net>
References: <200708080906.18993.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200708080906.18993.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

Teach the MMC/SD/SDIO core about using SPI mode.

 - Use mmc_host_is_spi() so enumeration works through SPI signaling
   and protocols, not just the native versions.

 - Provide the SPI response type flags with each request issued,
   including requests from the new lock/unlock code.

 - Understand that cmd->resp[0] and mmc_get_status() results for SPI
   return different values than for "native" MMC/SD protocol; this
   affects resetting, checking card lock status, and some others.

 - Understand that some commands act a bit differently ... notably:
     * OP_COND command doesn't return the OCR
     * APP_CMD status doesn't have an R1_APP_CMD analogue

Those changes required some new and updated primitives:

 - Provide utilities to access two SPI-only requests, and one
   request that wasn't previously needed:
     * mmc_spi_read_ocr() ... SPI only
     * mmc_spi_set_crc() ... SPI only (override by module parm)
     * mmc_send_cid() ... for use without broadcast mode

 - Updated internal routines:
     * Previous mmc_send_csd() modified into mmc_send_cxd_native();
       it uses native "R2" responses, which include 16 bytes of data.
     * Previous mmc_send_ext_csd() becomes new mmc_send_cxd_data()
       helper for command-and-data access
     * Bugfix to that mmc_send_cxd_data() code:  dma-to-stack is
       unsafe/nonportable, so kmalloc a bounce buffer instead.

 - Modified mmc_send_ext_csd() now uses mmc_send_cxd_data() helper

 - Modified mmc_send_csd(), and new mmc_spi_send_cid(), routines use
   those helper routines based on whether they're native or SPI

The newest categories of cards supported by the MMC stack aren't expected
to work yet with SPI:  MMC or SD cards with over 4GB data, and SDIO.
All those cards support SPI mode, so eventually they should work too.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
Against: git-mmc.patch from 2.6.21-rc1-mm2.   Changes since last version:
restore the lock/unlock hooks; SDIO is coded-to-spec.  So it's bigger.

 drivers/mmc/core/core.c     |   39 +++++++--
 drivers/mmc/core/core.h     |    2 
 drivers/mmc/core/mmc.c      |   43 ++++++----
 drivers/mmc/core/mmc_ops.c  |  185 ++++++++++++++++++++++++++++++++++----------
 drivers/mmc/core/mmc_ops.h  |    3 
 drivers/mmc/core/sd.c       |   39 ++++++---
 drivers/mmc/core/sd_ops.c   |   38 ++++++---
 drivers/mmc/core/sdio_ops.c |   49 +++++++----
 8 files changed, 301 insertions(+), 97 deletions(-)

--- g26.orig/drivers/mmc/core/mmc_ops.h	2007-08-08 09:07:48.000000000 -0700
+++ g26/drivers/mmc/core/mmc_ops.h	2007-08-08 09:07:57.000000000 -0700
@@ -25,6 +25,9 @@ int mmc_send_ext_csd(struct mmc_card *ca
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value);
 int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_lock_unlock(struct mmc_card *card, struct key *key, int mode);
+int mmc_send_cid(struct mmc_host *host, u32 *cid);
+int mmc_spi_read_ocr(struct mmc_host *host, u32 *ocrp);
+int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
 
 #endif
 
--- g26.orig/drivers/mmc/core/core.c	2007-08-08 09:07:48.000000000 -0700
+++ g26/drivers/mmc/core/core.c	2007-08-08 09:07:57.000000000 -0700
@@ -43,6 +43,14 @@ extern int mmc_attach_sdio(struct mmc_ho
 static struct workqueue_struct *workqueue;
 
 /*
+ * Enabling software CRCs on the data blocks can be a significant (30%)
+ * performance cost, and for other reasons may not always be desired.
+ * So we allow it it to be disabled.
+ */
+int use_spi_crc = 1;
+module_param(use_spi_crc, bool, 0);
+
+/*
  * Internal function. Schedule delayed work in the MMC work queue.
  */
 static int mmc_schedule_delayed_work(struct delayed_work *work,
@@ -72,6 +80,11 @@ void mmc_request_done(struct mmc_host *h
 	struct mmc_command *cmd = mrq->cmd;
 	int err = cmd->error;
 
+	if (err && cmd->retries && mmc_host_is_spi(host)) {
+		if (cmd->resp[0] & R1_SPI_ILLEGAL_COMMAND)
+			cmd->retries = 0;
+	}
+
 	if (err && cmd->retries) {
 		pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
 			mmc_hostname(host), cmd->opcode, err);
@@ -445,8 +458,13 @@ static void mmc_power_up(struct mmc_host
 	int bit = fls(host->ocr_avail) - 1;
 
 	host->ios.vdd = bit;
-	host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
-	host->ios.chip_select = MMC_CS_DONTCARE;
+	if (mmc_host_is_spi(host)) {
+		host->ios.chip_select = MMC_CS_HIGH;
+		host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
+	} else {
+		host->ios.chip_select = MMC_CS_DONTCARE;
+		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
+	}
 	host->ios.power_mode = MMC_POWER_UP;
 	host->ios.bus_width = MMC_BUS_WIDTH_1;
 	host->ios.timing = MMC_TIMING_LEGACY;
@@ -465,8 +483,10 @@ static void mmc_power_off(struct mmc_hos
 {
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
-	host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
-	host->ios.chip_select = MMC_CS_DONTCARE;
+	if (!mmc_host_is_spi(host)) {
+		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
+		host->ios.chip_select = MMC_CS_DONTCARE;
+	}
 	host->ios.power_mode = MMC_POWER_OFF;
 	host->ios.bus_width = MMC_BUS_WIDTH_1;
 	host->ios.timing = MMC_TIMING_LEGACY;
@@ -624,17 +644,24 @@ void mmc_rescan(struct work_struct *work
 		 */
 		err = mmc_send_app_op_cond(host, 0, &ocr);
 		if (!err) {
-			if (mmc_attach_sd(host, ocr))
+			if (mmc_host_is_spi(host))
+				err = mmc_spi_read_ocr(host, &ocr);
+			if (err || mmc_attach_sd(host, ocr))
 				mmc_power_off(host);
 			return;
 		}
 
 		/*
 		 * ...and finally MMC.
+		 *
+		 * REVISIT we currently expect that MMC4 cards (4+ GB)
+		 * will fail on SPI hosts.
 		 */
 		err = mmc_send_op_cond(host, 0, &ocr);
 		if (!err) {
-			if (mmc_attach_mmc(host, ocr))
+			if (mmc_host_is_spi(host))
+				err = mmc_spi_read_ocr(host, &ocr);
+			if (err || mmc_attach_mmc(host, ocr))
 				mmc_power_off(host);
 			return;
 		}
--- g26.orig/drivers/mmc/core/mmc_ops.c	2007-08-08 09:07:48.000000000 -0700
+++ g26/drivers/mmc/core/mmc_ops.c	2007-08-08 09:07:57.000000000 -0700
@@ -67,23 +67,36 @@ int mmc_go_idle(struct mmc_host *host)
 	int err;
 	struct mmc_command cmd;
 
-	mmc_set_chip_select(host, MMC_CS_HIGH);
-
-	mmc_delay(1);
+	/*
+	 * Non-SPI hosts need to prevent chipselect going active during
+	 * GO_IDLE; that would put chips into SPI mode.  Remind them of
+	 * that in case of hardware that won't pull up DAT3/nCS otherwise.
+	 *
+	 * SPI hosts ignore ios.chip_select; it's managed according to
+	 * rules that must accomodate non-MMC slaves which this layer
+	 * won't even know about.
+	 */
+	if (!mmc_host_is_spi(host)) {
+		mmc_set_chip_select(host, MMC_CS_HIGH);
+		mmc_delay(1);
+	}
 
 	memset(&cmd, 0, sizeof(struct mmc_command));
 
 	cmd.opcode = MMC_GO_IDLE_STATE;
 	cmd.arg = 0;
-	cmd.flags = MMC_RSP_NONE | MMC_CMD_BC;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
 
 	err = mmc_wait_for_cmd(host, &cmd, 0);
 
 	mmc_delay(1);
 
-	mmc_set_chip_select(host, MMC_CS_DONTCARE);
+	if (!mmc_host_is_spi(host)) {
+		mmc_set_chip_select(host, MMC_CS_DONTCARE);
+		mmc_delay(1);
+	}
 
-	mmc_delay(1);
+	host->use_spi_crc = 0;
 
 	return err;
 }
@@ -98,15 +111,19 @@ int mmc_send_op_cond(struct mmc_host *ho
 	memset(&cmd, 0, sizeof(struct mmc_command));
 
 	cmd.opcode = MMC_SEND_OP_COND;
-	cmd.arg = ocr;
-	cmd.flags = MMC_RSP_R3 | MMC_CMD_BCR;
+	cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
 	for (i = 100; i; i--) {
 		err = mmc_wait_for_cmd(host, &cmd, 0);
 		if (err)
 			break;
 
-		if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
+		if (mmc_host_is_spi(host)) {
+			/* wait until reset completes */
+			if (!(cmd.resp[0] & R1_SPI_IDLE))
+				break;
+		} else if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
 			break;
 
 		err = -ETIMEDOUT;
@@ -114,7 +131,7 @@ int mmc_send_op_cond(struct mmc_host *ho
 		mmc_delay(10);
 	}
 
-	if (rocr)
+	if (rocr && !mmc_host_is_spi(host))
 		*rocr = cmd.resp[0];
 
 	return err;
@@ -164,40 +181,46 @@ int mmc_set_relative_addr(struct mmc_car
 	return 0;
 }
 
-int mmc_send_csd(struct mmc_card *card, u32 *csd)
+static int
+mmc_send_cxd_native(struct mmc_host *host, u32 arg, u32 *cxd, int opcode)
 {
 	int err;
 	struct mmc_command cmd;
 
-	BUG_ON(!card);
-	BUG_ON(!card->host);
-	BUG_ON(!csd);
+	BUG_ON(!host);
+	BUG_ON(!cxd);
 
 	memset(&cmd, 0, sizeof(struct mmc_command));
 
-	cmd.opcode = MMC_SEND_CSD;
-	cmd.arg = card->rca << 16;
+	cmd.opcode = opcode;
+	cmd.arg = arg;
 	cmd.flags = MMC_RSP_R2 | MMC_CMD_AC;
 
-	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
+	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 	if (err)
 		return err;
 
-	memcpy(csd, cmd.resp, sizeof(u32) * 4);
+	memcpy(cxd, cmd.resp, sizeof(u32) * 4);
 
 	return 0;
 }
 
-int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd)
+static int
+mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
+		u32 opcode, void *buf, unsigned len)
 {
 	struct mmc_request mrq;
 	struct mmc_command cmd;
 	struct mmc_data data;
 	struct scatterlist sg;
+	void *data_buf;
 
-	BUG_ON(!card);
-	BUG_ON(!card->host);
-	BUG_ON(!ext_csd);
+	/* dma onto stack is unsafe/nonportable, but callers to this
+	 * routine normally provide temporary on-stack buffers ...
+	 */
+	data_buf = kmalloc(len, GFP_KERNEL);
+	if (data_buf == NULL)
+		return -ENOMEM;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
 	memset(&cmd, 0, sizeof(struct mmc_command));
@@ -206,21 +229,31 @@ int mmc_send_ext_csd(struct mmc_card *ca
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 
-	cmd.opcode = MMC_SEND_EXT_CSD;
+	cmd.opcode = opcode;
 	cmd.arg = 0;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
 
-	data.blksz = 512;
+	/* NOTE HACK:  the MMC_RSP_SPI_R1 is always correct here, but we
+	 * rely on callers to never use this with "native" calls for reading
+	 * CSD or CID.  Native versions of those commands use the R2 type,
+	 * not R1 plus a data block.
+	 */
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	data.blksz = len;
 	data.blocks = 1;
 	data.flags = MMC_DATA_READ;
 	data.sg = &sg;
 	data.sg_len = 1;
 
-	sg_init_one(&sg, ext_csd, 512);
+	sg_init_one(&sg, data_buf, len);
 
-	mmc_set_data_timeout(&data, card);
+	if (card)
+		mmc_set_data_timeout(&data, card);
 
-	mmc_wait_for_req(card->host, &mrq);
+	mmc_wait_for_req(host, &mrq);
+
+	memcpy(buf, data_buf, len);
+	kfree(data_buf);
 
 	if (cmd.error)
 		return cmd.error;
@@ -230,6 +263,66 @@ int mmc_send_ext_csd(struct mmc_card *ca
 	return 0;
 }
 
+int mmc_send_csd(struct mmc_card *card, u32 *csd)
+{
+	if (!mmc_host_is_spi(card->host))
+		return mmc_send_cxd_native(card->host, card->rca << 16,
+				csd, MMC_SEND_CSD);
+
+	return mmc_send_cxd_data(card, card->host, MMC_SEND_CSD, csd, 16);
+}
+
+int mmc_send_cid(struct mmc_host *host, u32 *cid)
+{
+	if (!mmc_host_is_spi(host)) {
+		if (!host->card)
+			return -EINVAL;
+		return mmc_send_cxd_native(host, host->card->rca << 16,
+				cid, MMC_SEND_CID);
+	}
+
+	return mmc_send_cxd_data(NULL, host, MMC_SEND_CID, cid, 16);
+}
+
+int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd)
+{
+	return mmc_send_cxd_data(card, card->host, MMC_SEND_EXT_CSD,
+			ext_csd, 512);
+}
+
+int mmc_spi_read_ocr(struct mmc_host *host, u32 *ocrp)
+{
+	struct mmc_command cmd;
+	int err;
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_SPI_READ_OCR;
+	cmd.flags = MMC_RSP_SPI_R3;
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+
+	*ocrp = cmd.resp[1];
+	return err;
+}
+
+int mmc_spi_set_crc(struct mmc_host *host, int use_crc)
+{
+	struct mmc_command cmd;
+	int err;
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_SPI_CRC_ON_OFF;
+	cmd.flags = MMC_RSP_SPI_R1;
+	cmd.arg = use_crc;
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (!err)
+		host->use_spi_crc = use_crc;
+	return err;
+}
+
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value)
 {
 	int err;
@@ -245,7 +338,7 @@ int mmc_switch(struct mmc_card *card, u8
 		  (index << 16) |
 		  (value << 8) |
 		  set;
-	cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
+	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
 	if (err)
@@ -265,13 +358,17 @@ int mmc_send_status(struct mmc_card *car
 	memset(&cmd, 0, sizeof(struct mmc_command));
 
 	cmd.opcode = MMC_SEND_STATUS;
-	cmd.arg = card->rca << 16;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	if (!mmc_host_is_spi(card->host))
+		cmd.arg = card->rca << 16;
+	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
 	if (err)
 		return err;
 
+	/* NOTE: callers are required to understand the difference
+	 * between "native" and SPI format status words!
+	 */
 	if (status)
 		*status = cmd.resp[0];
 
@@ -316,7 +413,7 @@ int mmc_lock_unlock(struct mmc_card *car
 
 	cmd.opcode = MMC_SET_BLOCKLEN;
 	cmd.arg = data_size;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
 	if (err)
 		goto out;
@@ -325,7 +422,7 @@ int mmc_lock_unlock(struct mmc_card *car
 
 	cmd.opcode = MMC_LOCK_UNLOCK;
 	cmd.arg = 0;
-	cmd.flags = MMC_RSP_R1B | MMC_CMD_ADTC;
+	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_ADTC;
 
 	memset(&data, 0, sizeof(struct mmc_data));
 
@@ -353,9 +450,16 @@ int mmc_lock_unlock(struct mmc_card *car
 
 	memset(&cmd, 0, sizeof(struct mmc_command));
 
+	/* NOTE:  for SPI, LOCK_UNLOCK definitions seem to vary... MMC
+	 * card docs show it as R1B, and SD cards show it as R1 but with
+	 * no way to tell when operations complete (e.g. forced erase).
+	 * We treat both as R1B, since that makes more sense, and since
+	 * if there are no busy tokens it's the same as R1.  In either
+	 * case, the SPI host won't leave cards busy.
+	 */
 	cmd.opcode = MMC_SEND_STATUS;
 	cmd.arg = card->rca << 16;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
 
 	/* set timeout for forced erase operation to 3 min. (see MMC spec) */
 	erase_timeout = jiffies + 180 * HZ;
@@ -364,7 +468,7 @@ int mmc_lock_unlock(struct mmc_card *car
 		 * R1_LOCK_UNLOCK_FAILED bit is cleared by subsequent reads to
 		 * the status register, hiding the error condition */
 		err = mmc_wait_for_cmd(card->host, &cmd, 0);
-		if (err)
+		if (err || mmc_host_is_spi(card->host))
 			break;
 		/* the other modes don't need timeout checking */
 		if (!(mode & MMC_LOCK_MODE_ERASE))
@@ -374,13 +478,18 @@ int mmc_lock_unlock(struct mmc_card *car
 			err = -ETIMEDOUT;
 			break;
 		}
+		/* NOTE: for SPI, cmd.resp[0] format is different! */
 	} while (!(cmd.resp[0] & R1_READY_FOR_DATA));
-	if (cmd.resp[0] & R1_LOCK_UNLOCK_FAILED) {
+
+	if (cmd.resp[0] & (mmc_host_is_spi(card->host)
+			? R2_SPI_LOCK_UNLOCK_FAIL
+			: R1_LOCK_UNLOCK_FAILED)) {
 		dev_dbg(&card->dev, "LOCK_UNLOCK operation failed\n");
-		err = -EIO;
+		if (!err)
+			err = -EIO;
 	}
 
-	if (cmd.resp[0] & R1_CARD_IS_LOCKED)
+	if (mmc_status_card_is_locked(card->host, cmd.resp[0]))
 		mmc_card_set_locked(card);
 	else
 		card->state &= ~MMC_STATE_LOCKED;
--- g26.orig/drivers/mmc/core/mmc.c	2007-08-08 09:07:48.000000000 -0700
+++ g26/drivers/mmc/core/mmc.c	2007-08-08 09:07:57.000000000 -0700
@@ -166,8 +166,6 @@ static int mmc_read_ext_csd(struct mmc_c
 
 	BUG_ON(!card);
 
-	err = -EIO;
-
 	if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
 		return 0;
 
@@ -282,9 +280,21 @@ static int mmc_init_card(struct mmc_host
 		goto err;
 
 	/*
+	 * For SPI, enable CRC as appropriate.
+	 */
+	if (mmc_host_is_spi(host)) {
+		err = mmc_spi_set_crc(host, use_spi_crc);
+		if (err)
+			goto err;
+	}
+
+	/*
 	 * Fetch CID from card.
 	 */
-	err = mmc_all_send_cid(host, cid);
+	if (mmc_host_is_spi(host))
+		err = mmc_send_cid(host, cid);
+	else
+		err = mmc_all_send_cid(host, cid);
 	if (err)
 		goto err;
 
@@ -311,13 +321,15 @@ static int mmc_init_card(struct mmc_host
 	}
 
 	/*
-	 * Set card RCA.
+	 * For native busses:  set card RCA and quit open drain mode.
 	 */
-	err = mmc_set_relative_addr(card);
-	if (err)
-		goto free_card;
+	if (!mmc_host_is_spi(host)) {
+		err = mmc_set_relative_addr(card);
+		if (err)
+			goto free_card;
 
-	mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
+		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
+	}
 
 	/*
 	 * Check if card is locked.
@@ -325,7 +337,7 @@ static int mmc_init_card(struct mmc_host
 	err = mmc_send_status(card, &status);
 	if (err)
 		goto free_card;
-	if (status & R1_CARD_IS_LOCKED)
+	if (mmc_status_card_is_locked(host, status))
 		mmc_card_set_locked(card);
 
 	if (!oldcard) {
@@ -347,13 +359,15 @@ static int mmc_init_card(struct mmc_host
 	/*
 	 * Select card, as all following commands rely on that.
 	 */
-	err = mmc_select_card(card);
-	if (err)
-		goto free_card;
+	if (!mmc_host_is_spi(host)) {
+		err = mmc_select_card(card);
+		if (err)
+			goto free_card;
+	}
 
 	if (!oldcard) {
 		/*
-		 * Fetch and process extened CSD.
+		 * Fetch and process extended CSD.
 		 */
 		err = mmc_read_ext_csd(card);
 		if (err)
@@ -520,7 +534,8 @@ static void mmc_suspend(struct mmc_host 
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
-	mmc_deselect_cards(host);
+	if (!mmc_host_is_spi(host))
+		mmc_deselect_cards(host);
 	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_LOCKED);
 	mmc_release_host(host);
 }
--- g26.orig/drivers/mmc/core/sd.c	2007-08-08 09:07:48.000000000 -0700
+++ g26/drivers/mmc/core/sd.c	2007-08-08 09:07:57.000000000 -0700
@@ -327,9 +327,21 @@ static int mmc_sd_init_card(struct mmc_h
 		goto err;
 
 	/*
+	 * For SPI, enable CRC as appropriate.
+	 */
+	if (mmc_host_is_spi(host)) {
+		err = mmc_spi_set_crc(host, use_spi_crc);
+		if (err)
+			goto err;
+	}
+
+	/*
 	 * Fetch CID from card.
 	 */
-	err = mmc_all_send_cid(host, cid);
+	if (mmc_host_is_spi(host))
+		err = mmc_send_cid(host, cid);
+	else
+		err = mmc_all_send_cid(host, cid);
 	if (err)
 		goto err;
 
@@ -355,13 +367,15 @@ static int mmc_sd_init_card(struct mmc_h
 	}
 
 	/*
-	 * Set card RCA.
+	 * For native busses:  get card RCA and quit open drain mode.
 	 */
-	err = mmc_send_relative_addr(host, &card->rca);
-	if (err)
-		goto free_card;
+	if (!mmc_host_is_spi(host)) {
+		err = mmc_send_relative_addr(host, &card->rca);
+		if (err)
+			goto free_card;
 
-	mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
+		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
+	}
 
 	/*
 	 * Check if card is locked.
@@ -369,7 +383,7 @@ static int mmc_sd_init_card(struct mmc_h
 	err = mmc_send_status(card, &status);
 	if (err)
 		goto free_card;
-	if (status & R1_CARD_IS_LOCKED)
+	if (mmc_status_card_is_locked(host, status))
 		mmc_card_set_locked(card);
 
 	if (!oldcard) {
@@ -390,9 +404,11 @@ static int mmc_sd_init_card(struct mmc_h
 	/*
 	 * Select card, as all following commands rely on that.
 	 */
-	err = mmc_select_card(card);
-	if (err)
-		goto free_card;
+	if (!mmc_host_is_spi(host)) {
+		err = mmc_select_card(card);
+		if (err)
+			goto free_card;
+	}
 
 	if (!oldcard) {
 		/*
@@ -582,7 +598,8 @@ static void mmc_sd_suspend(struct mmc_ho
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
-	mmc_deselect_cards(host);
+	if (!mmc_host_is_spi(host))
+		mmc_deselect_cards(host);
 	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_LOCKED);
 	mmc_release_host(host);
 }
--- g26.orig/drivers/mmc/core/sd_ops.c	2007-08-08 09:07:48.000000000 -0700
+++ g26/drivers/mmc/core/sd_ops.c	2007-08-08 09:07:57.000000000 -0700
@@ -33,10 +33,10 @@ static int mmc_app_cmd(struct mmc_host *
 
 	if (card) {
 		cmd.arg = card->rca << 16;
-		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+		cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 	} else {
 		cmd.arg = 0;
-		cmd.flags = MMC_RSP_R1 | MMC_CMD_BCR;
+		cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_BCR;
 	}
 
 	err = mmc_wait_for_cmd(host, &cmd, 0);
@@ -44,7 +44,7 @@ static int mmc_app_cmd(struct mmc_host *
 		return err;
 
 	/* Check that card supported application commands */
-	if (!(cmd.resp[0] & R1_APP_CMD))
+	if (!mmc_host_is_spi(host) && !(cmd.resp[0] & R1_APP_CMD))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -83,8 +83,14 @@ int mmc_wait_for_app_cmd(struct mmc_host
 		memset(&mrq, 0, sizeof(struct mmc_request));
 
 		err = mmc_app_cmd(host, card);
-		if (err)
+		if (err) {
+			/* no point in retrying; no APP commands allowed */
+			if (mmc_host_is_spi(host)) {
+				if (cmd->resp[0] & R1_SPI_ILLEGAL_COMMAND)
+					break;
+			}
 			continue;
+		}
 
 		memset(&mrq, 0, sizeof(struct mmc_request));
 
@@ -99,6 +105,12 @@ int mmc_wait_for_app_cmd(struct mmc_host
 		err = cmd->error;
 		if (!cmd->error)
 			break;
+
+		/* no point in retrying illegal APP commands */
+		if (mmc_host_is_spi(host)) {
+			if (cmd->resp[0] & R1_SPI_ILLEGAL_COMMAND)
+				break;
+		}
 	}
 
 	return err;
@@ -148,14 +160,18 @@ int mmc_send_app_op_cond(struct mmc_host
 
 	cmd.opcode = SD_APP_OP_COND;
 	cmd.arg = ocr;
-	cmd.flags = MMC_RSP_R3 | MMC_CMD_BCR;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
 	for (i = 100; i; i--) {
 		err = mmc_wait_for_app_cmd(host, NULL, &cmd, MMC_CMD_RETRIES);
 		if (err)
 			break;
 
-		if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
+		if (mmc_host_is_spi(host)) {
+			/* wait until reset completes */
+			if (!(cmd.resp[0] & R1_SPI_IDLE))
+				break;
+		} else if ((cmd.resp[0] & MMC_CARD_BUSY) || ocr == 0)
 			break;
 
 		err = -ETIMEDOUT;
@@ -182,7 +198,7 @@ int mmc_send_if_cond(struct mmc_host *ho
 	 */
 	cmd.opcode = SD_SEND_IF_COND;
 	cmd.arg = ((ocr & 0xFF8000) != 0) << 8 | test_pattern;
-	cmd.flags = MMC_RSP_R7 | MMC_CMD_BCR;
+	cmd.flags = MMC_RSP_SPI_R7 | MMC_RSP_R7 | MMC_CMD_BCR;
 
 	err = mmc_wait_for_cmd(host, &cmd, 0);
 	if (err)
@@ -229,6 +245,8 @@ int mmc_app_send_scr(struct mmc_card *ca
 	BUG_ON(!card->host);
 	BUG_ON(!scr);
 
+	/* NOTE: caller guarantees scr is heap-allocated */
+
 	err = mmc_app_cmd(card->host, card);
 	if (err)
 		return err;
@@ -242,7 +260,7 @@ int mmc_app_send_scr(struct mmc_card *ca
 
 	cmd.opcode = SD_APP_SEND_SCR;
 	cmd.arg = 0;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
 	data.blksz = 8;
 	data.blocks = 1;
@@ -278,6 +296,8 @@ int mmc_sd_switch(struct mmc_card *card,
 	BUG_ON(!card);
 	BUG_ON(!card->host);
 
+	/* NOTE: caller guarantees resp is heap-allocated */
+
 	mode = !!mode;
 	value &= 0xF;
 
@@ -292,7 +312,7 @@ int mmc_sd_switch(struct mmc_card *card,
 	cmd.arg = mode << 31 | 0x00FFFFFF;
 	cmd.arg &= ~(0xF << (group * 4));
 	cmd.arg |= value << (group * 4);
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
 	data.blksz = 64;
 	data.blocks = 1;
--- g26.orig/drivers/mmc/core/core.h	2007-08-08 09:07:48.000000000 -0700
+++ g26/drivers/mmc/core/core.h	2007-08-08 09:07:57.000000000 -0700
@@ -48,5 +48,7 @@ void mmc_rescan(struct work_struct *work
 void mmc_start_host(struct mmc_host *host);
 void mmc_stop_host(struct mmc_host *host);
 
+extern int use_spi_crc;
+
 #endif
 
--- g26.orig/drivers/mmc/core/sdio_ops.c	2007-08-08 09:07:48.000000000 -0700
+++ g26/drivers/mmc/core/sdio_ops.c	2007-08-08 09:07:57.000000000 -0700
@@ -30,14 +30,18 @@ int mmc_send_io_op_cond(struct mmc_host 
 
 	cmd.opcode = SD_IO_SEND_OP_COND;
 	cmd.arg = ocr;
-	cmd.flags = MMC_RSP_R4 | MMC_CMD_BCR;
+	cmd.flags = MMC_RSP_SPI_R4 | MMC_RSP_R4 | MMC_CMD_BCR;
 
 	for (i = 100; i; i--) {
 		err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 		if (err)
 			break;
 
-		if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
+		if (mmc_host_is_spi(host)) {
+			/* wait until reset completes */
+			if (!(cmd.resp[0] & R1_SPI_IDLE))
+				break;
+		} else if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
 			break;
 
 		err = -ETIMEDOUT;
@@ -46,7 +50,7 @@ int mmc_send_io_op_cond(struct mmc_host 
 	}
 
 	if (rocr)
-		*rocr = cmd.resp[0];
+		*rocr = cmd.resp[mmc_host_is_spi(host) ? 1 : 0];
 
 	return err;
 }
@@ -68,21 +72,26 @@ int mmc_io_rw_direct(struct mmc_card *ca
 	cmd.arg |= (write && out) ? 0x08000000 : 0x00000000;
 	cmd.arg |= addr << 9;
 	cmd.arg |= in;
-	cmd.flags = MMC_RSP_R5 | MMC_CMD_AC;
+	cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_AC;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err)
 		return err;
 
-	if (cmd.resp[0] & R5_ERROR)
-		return -EIO;
-	if (cmd.resp[0] & R5_FUNCTION_NUMBER)
-		return -EINVAL;
-	if (cmd.resp[0] & R5_OUT_OF_RANGE)
-		return -ERANGE;
+	if (mmc_host_is_spi(card->host)) {
+		if (out)
+			*out = (cmd.resp[0] >> 8) & 0xFF;
+	} else {
+		if (cmd.resp[0] & R5_ERROR)
+			return -EIO;
+		if (cmd.resp[0] & R5_FUNCTION_NUMBER)
+			return -EINVAL;
+		if (cmd.resp[0] & R5_OUT_OF_RANGE)
+			return -ERANGE;
 
-	if (out)
-		*out = cmd.resp[0] & 0xFF;
+		if (out)
+			*out = cmd.resp[0] & 0xFF;
+	}
 
 	return 0;
 }
@@ -112,7 +121,7 @@ int mmc_io_rw_extended(struct mmc_card *
 	cmd.arg |= bang ? 0x00000000 : 0x04000000;
 	cmd.arg |= addr << 9;
 	cmd.arg |= (size == 512) ? 0 : size;
-	cmd.flags = MMC_RSP_R5 | MMC_CMD_ADTC;
+	cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_ADTC;
 
 	data.blksz = size;
 	data.blocks = 1;
@@ -131,12 +140,14 @@ int mmc_io_rw_extended(struct mmc_card *
 	if (data.error)
 		return data.error;
 
-	if (cmd.resp[0] & R5_ERROR)
-		return -EIO;
-	if (cmd.resp[0] & R5_FUNCTION_NUMBER)
-		return -EINVAL;
-	if (cmd.resp[0] & R5_OUT_OF_RANGE)
-		return -ERANGE;
+	if (!mmc_host_is_spi(card->host)) {
+		if (cmd.resp[0] & R5_ERROR)
+			return -EIO;
+		if (cmd.resp[0] & R5_FUNCTION_NUMBER)
+			return -EINVAL;
+		if (cmd.resp[0] & R5_OUT_OF_RANGE)
+			return -ERANGE;
+	}
 
 	return 0;
 }



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
