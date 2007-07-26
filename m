From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 3/4] MMC core learns
	about SPI
Date: Thu, 26 Jul 2007 15:22:21 -0700
Message-ID: <200707261522.22065.david-b@pacbell.net>
References: <200707141504.51950.david-b@pacbell.net>
	<20070726191824.569542fd@poseidon.drzeus.cx>
	<200707261458.55558.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200707261458.55558.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

Grr ... sent wrong version.  This passes "host" not "host->card" in
one place (GCC would warn, and is otherwise the same.

======	CUT HERE
Teach the MMC/SD/SDIO core about using SPI mode.

 - Use mmc_host_is_spi() so enumeration works through SPI signaling
   and protocols, not just the native versions.

 - Provide the SPI response type flags with each request issued,
   including requests from the new lock/unlock code.

 - Understand that some commands act a bit differently ... notably:
     * OP_COND command reports busy status differently
     * OP_COND command doesn't return the OCR
     * APP_CMD status doesn't have an R1_APP_CMD analogue

 - Understand that cmd->resp[0] and mmc_get_status() results for SPI
   return different values than for "native" MMC/SD protocol; this
   affects checking card lock status, and some others.

Those changes required some new and updated primitives:

 - Provide utilities to access two SPI-only requests, and one
   request that wasn't previously needed:
     * mmc_spi_read_ocr() ... SPI only
     * mmc_spi_set_crc() ... SPI only (override by module parm)
     * mmc_spi_send_cid() ... works without broadcast mode

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

The SPI support hasn't been tested on the new MMC4 cards (they're not
widely available); likewise SD cards with 4GB and up may have surprises
lurking.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/mmc/core/core.c    |   24 ++++--
 drivers/mmc/core/mmc.c     |   39 +++++++---
 drivers/mmc/core/mmc_ops.c |  165 ++++++++++++++++++++++++++++++++++++---------
 drivers/mmc/core/mmc_ops.h |    3 
 drivers/mmc/core/sd.c      |   37 +++++++---
 drivers/mmc/core/sd_ops.c  |   32 ++++++--
 6 files changed, 232 insertions(+), 68 deletions(-)

--- g26.orig/drivers/mmc/core/mmc_ops.h	2007-07-26 13:13:23.000000000 -0700
+++ g26/drivers/mmc/core/mmc_ops.h	2007-07-26 14:54:35.000000000 -0700
@@ -22,6 +22,9 @@ int mmc_send_csd(struct mmc_card *card, 
 int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value);
 int mmc_send_status(struct mmc_card *card, u32 *status);
+int mmc_send_cid(struct mmc_host *host, u32 *cid);
+int mmc_spi_read_ocr(struct mmc_host *host, u32 *ocrp);
+int mmc_spi_set_crc(struct mmc_host *host);
 
 #endif
 
--- g26.orig/drivers/mmc/core/core.c	2007-07-26 13:13:24.000000000 -0700
+++ g26/drivers/mmc/core/core.c	2007-07-26 14:54:35.000000000 -0700
@@ -404,8 +404,13 @@ static void mmc_power_up(struct mmc_host
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
@@ -424,8 +429,10 @@ static void mmc_power_off(struct mmc_hos
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
@@ -541,7 +548,9 @@ void mmc_rescan(struct work_struct *work
 
 		err = mmc_send_app_op_cond(host, 0, &ocr);
 		if (err == MMC_ERR_NONE) {
-			if (mmc_attach_sd(host, ocr))
+			if (mmc_host_is_spi(host))
+				err = mmc_spi_read_ocr(host, &ocr);
+			if (err != MMC_ERR_NONE || mmc_attach_sd(host, ocr))
 				mmc_power_off(host);
 		} else {
 			/*
@@ -550,7 +559,10 @@ void mmc_rescan(struct work_struct *work
 			 */
 			err = mmc_send_op_cond(host, 0, &ocr);
 			if (err == MMC_ERR_NONE) {
-				if (mmc_attach_mmc(host, ocr))
+				if (mmc_host_is_spi(host))
+					err = mmc_spi_read_ocr(host, &ocr);
+				if (err != MMC_ERR_NONE
+						|| mmc_attach_mmc(host, ocr))
 					mmc_power_off(host);
 			} else {
 				mmc_power_off(host);
--- g26.orig/drivers/mmc/core/mmc_ops.c	2007-07-26 13:13:23.000000000 -0700
+++ g26/drivers/mmc/core/mmc_ops.c	2007-07-26 15:21:57.000000000 -0700
@@ -63,23 +63,34 @@ int mmc_go_idle(struct mmc_host *host)
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
-
-	mmc_delay(1);
+	if (!mmc_host_is_spi(host)) {
+		mmc_set_chip_select(host, MMC_CS_DONTCARE);
+		mmc_delay(1);
+	}
 
 	return err;
 }
@@ -94,15 +105,19 @@ int mmc_send_op_cond(struct mmc_host *ho
 	memset(&cmd, 0, sizeof(struct mmc_command));
 
 	cmd.opcode = MMC_SEND_OP_COND;
-	cmd.arg = ocr;
-	cmd.flags = MMC_RSP_R3 | MMC_CMD_BCR;
+	cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
 	for (i = 100; i; i--) {
 		err = mmc_wait_for_cmd(host, &cmd, 0);
 		if (err != MMC_ERR_NONE)
 			break;
 
-		if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
+		if (mmc_host_is_spi(host)) {
+			/* wait until reset completes */
+			if (!(cmd.resp[0] & R1_SPI_IDLE))
+				break;
+		} else if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
 			break;
 
 		err = MMC_ERR_TIMEOUT;
@@ -110,7 +125,7 @@ int mmc_send_op_cond(struct mmc_host *ho
 		mmc_delay(10);
 	}
 
-	if (rocr)
+	if (rocr && !mmc_host_is_spi(host))
 		*rocr = cmd.resp[0];
 
 	return err;
@@ -160,40 +175,46 @@ int mmc_set_relative_addr(struct mmc_car
 	return MMC_ERR_NONE;
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
 	if (err != MMC_ERR_NONE)
 		return err;
 
-	memcpy(csd, cmd.resp, sizeof(u32) * 4);
+	memcpy(cxd, cmd.resp, sizeof(u32) * 4);
 
 	return MMC_ERR_NONE;
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
+	/* dma onto stack is unsafe/nonportable, but callers here
+	 * normally provide temporary on-stack buffers.
+	 */
+	data_buf = kmalloc(len, GFP_KERNEL);
+	if (data_buf == NULL)
+		return -ENOMEM;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
 	memset(&cmd, 0, sizeof(struct mmc_command));
@@ -202,21 +223,31 @@ int mmc_send_ext_csd(struct mmc_card *ca
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
 
-	mmc_set_data_timeout(&data, card, 0);
+	if (card)
+		mmc_set_data_timeout(&data, card, 0);
 
-	mmc_wait_for_req(card->host, &mrq);
+	mmc_wait_for_req(host, &mrq);
+
+	memcpy(buf, data_buf, len);
+	kfree(data_buf);
 
 	if (cmd.error != MMC_ERR_NONE)
 		return cmd.error;
@@ -226,6 +257,72 @@ int mmc_send_ext_csd(struct mmc_card *ca
 	return MMC_ERR_NONE;
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
+			return MMC_ERR_INVALID;
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
+/* Enabling software CRCs can be a significant (30%) performance cost,
+ * and for other reasons isn't always desired; so it can be disabled.
+ */
+static int use_spi_crc = 1;
+module_param(use_spi_crc, bool, 0);
+
+int mmc_spi_set_crc(struct mmc_host *host)
+{
+	struct mmc_command cmd;
+	int err;
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_SPI_CRC_ON_OFF;
+	cmd.flags = MMC_RSP_SPI_R1;
+	cmd.arg = use_spi_crc;
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err == MMC_ERR_NONE)
+		host->use_spi_crc = use_spi_crc;
+	return err;
+}
+
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value)
 {
 	int err;
@@ -241,7 +338,7 @@ int mmc_switch(struct mmc_card *card, u8
 		  (index << 16) |
 		  (value << 8) |
 		  set;
-	cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
+	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
 	if (err != MMC_ERR_NONE)
@@ -261,13 +358,17 @@ int mmc_send_status(struct mmc_card *car
 	memset(&cmd, 0, sizeof(struct mmc_command));
 
 	cmd.opcode = MMC_SEND_STATUS;
-	cmd.arg = card->rca << 16;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	if (!mmc_host_is_spi(card->host))
+		cmd.arg = card->rca << 16;
+	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
 	if (err != MMC_ERR_NONE)
 		return err;
 
+	/* NOTE: callers are required to understand the difference
+	 * between "native" and SPI format status words!
+	 */
 	if (status)
 		*status = cmd.resp[0];
 
--- g26.orig/drivers/mmc/core/mmc.c	2007-07-26 13:13:24.000000000 -0700
+++ g26/drivers/mmc/core/mmc.c	2007-07-26 14:54:35.000000000 -0700
@@ -262,9 +262,21 @@ static int mmc_init_card(struct mmc_host
 		goto err;
 
 	/*
+	 * For SPI, enable CRC as appropriate.
+	 */
+	if (mmc_host_is_spi(host)) {
+		err = mmc_spi_set_crc(host);
+		if (err != MMC_ERR_NONE)
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
 	if (err != MMC_ERR_NONE)
 		goto err;
 
@@ -287,13 +299,15 @@ static int mmc_init_card(struct mmc_host
 	}
 
 	/*
-	 * Set card RCA.
+	 * For native busses:  set card RCA and leave open drain mode.
 	 */
-	err = mmc_set_relative_addr(card);
-	if (err != MMC_ERR_NONE)
-		goto free_card;
+	if (!mmc_host_is_spi(host)) {
+		err = mmc_set_relative_addr(card);
+		if (err != MMC_ERR_NONE)
+			goto free_card;
 
-	mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
+		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
+	}
 
 	if (!oldcard) {
 		/*
@@ -314,13 +328,15 @@ static int mmc_init_card(struct mmc_host
 	/*
 	 * Select card, as all following commands rely on that.
 	 */
-	err = mmc_select_card(card);
-	if (err != MMC_ERR_NONE)
-		goto free_card;
+	if (!mmc_host_is_spi(host)) {
+		err = mmc_select_card(card);
+		if (err != MMC_ERR_NONE)
+			goto free_card;
+	}
 
 	if (!oldcard) {
 		/*
-		 * Fetch and process extened CSD.
+		 * Fetch and process extended CSD.
 		 */
 		err = mmc_read_ext_csd(card);
 		if (err != MMC_ERR_NONE)
@@ -480,7 +496,8 @@ static void mmc_suspend(struct mmc_host 
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
-	mmc_deselect_cards(host);
+	if (!mmc_host_is_spi(host))
+		mmc_deselect_cards(host);
 	host->card->state &= ~MMC_STATE_HIGHSPEED;
 	mmc_release_host(host);
 }
--- g26.orig/drivers/mmc/core/sd.c	2007-07-26 13:13:23.000000000 -0700
+++ g26/drivers/mmc/core/sd.c	2007-07-26 14:54:35.000000000 -0700
@@ -319,9 +319,21 @@ static int mmc_sd_init_card(struct mmc_h
 		goto err;
 
 	/*
+	 * For SPI, enable CRC as appropriate.
+	 */
+	if (mmc_host_is_spi(host)) {
+		err = mmc_spi_set_crc(host);
+		if (err != MMC_ERR_NONE)
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
 	if (err != MMC_ERR_NONE)
 		goto err;
 
@@ -343,13 +355,15 @@ static int mmc_sd_init_card(struct mmc_h
 	}
 
 	/*
-	 * Set card RCA.
+	 * For native busses:  get card RCA and leave open drain mode.
 	 */
-	err = mmc_send_relative_addr(host, &card->rca);
-	if (err != MMC_ERR_NONE)
-		goto free_card;
+	if (!mmc_host_is_spi(host)) {
+		err = mmc_send_relative_addr(host, &card->rca);
+		if (err != MMC_ERR_NONE)
+			goto free_card;
 
-	mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
+		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
+	}
 
 	if (!oldcard) {
 		/*
@@ -369,9 +383,11 @@ static int mmc_sd_init_card(struct mmc_h
 	/*
 	 * Select card, as all following commands rely on that.
 	 */
-	err = mmc_select_card(card);
-	if (err != MMC_ERR_NONE)
-		goto free_card;
+	if (!mmc_host_is_spi(host)) {
+		err = mmc_select_card(card);
+		if (err != MMC_ERR_NONE)
+			goto free_card;
+	}
 
 	if (!oldcard) {
 		/*
@@ -554,7 +570,8 @@ static void mmc_sd_suspend(struct mmc_ho
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
-	mmc_deselect_cards(host);
+	if (!mmc_host_is_spi(host))
+		mmc_deselect_cards(host);
 	host->card->state &= ~MMC_STATE_HIGHSPEED;
 	mmc_release_host(host);
 }
--- g26.orig/drivers/mmc/core/sd_ops.c	2007-07-26 13:13:24.000000000 -0700
+++ g26/drivers/mmc/core/sd_ops.c	2007-07-26 14:54:35.000000000 -0700
@@ -70,6 +70,12 @@ int mmc_wait_for_app_cmd(struct mmc_host
 		err = cmd->error;
 		if (cmd->error == MMC_ERR_NONE)
 			break;
+
+		/* no point in retrying illegal commands! */
+		if (mmc_host_is_spi(host)) {
+			if (cmd->resp[0] & R1_SPI_ILLEGAL_COMMAND)
+				break;
+		}
 	}
 
 	return err;
@@ -89,10 +95,10 @@ int mmc_app_cmd(struct mmc_host *host, s
 
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
@@ -100,8 +106,8 @@ int mmc_app_cmd(struct mmc_host *host, s
 		return err;
 
 	/* Check that card supported application commands */
-	if (!(cmd.resp[0] & R1_APP_CMD))
-		return MMC_ERR_FAILED;
+	if (!mmc_host_is_spi(host) && !(cmd.resp[0] & R1_APP_CMD))
+		return (u32)-1;
 
 	return MMC_ERR_NONE;
 }
@@ -148,14 +154,18 @@ int mmc_send_app_op_cond(struct mmc_host
 
 	cmd.opcode = SD_APP_OP_COND;
 	cmd.arg = ocr;
-	cmd.flags = MMC_RSP_R3 | MMC_CMD_BCR;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
 	for (i = 100; i; i--) {
 		err = mmc_wait_for_app_cmd(host, NULL, &cmd, MMC_CMD_RETRIES);
 		if (err != MMC_ERR_NONE)
 			break;
 
-		if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
+		if (mmc_host_is_spi(host)) {
+			/* wait until reset completes */
+			if (!(cmd.resp[0] & R1_SPI_IDLE))
+				break;
+		} else if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
 			break;
 
 		err = MMC_ERR_TIMEOUT;
@@ -182,7 +192,7 @@ int mmc_send_if_cond(struct mmc_host *ho
 	 */
 	cmd.opcode = SD_SEND_IF_COND;
 	cmd.arg = ((ocr & 0xFF8000) != 0) << 8 | test_pattern;
-	cmd.flags = MMC_RSP_R7 | MMC_CMD_BCR;
+	cmd.flags = MMC_RSP_SPI_R7 | MMC_RSP_R7 | MMC_CMD_BCR;
 
 	err = mmc_wait_for_cmd(host, &cmd, 0);
 	if (err != MMC_ERR_NONE)
@@ -229,6 +239,8 @@ int mmc_app_send_scr(struct mmc_card *ca
 	BUG_ON(!card->host);
 	BUG_ON(!scr);
 
+	/* NOTE: caller guarantees scr is heap-allocated */
+
 	err = mmc_app_cmd(card->host, card);
 	if (err != MMC_ERR_NONE)
 		return err;
@@ -242,7 +254,7 @@ int mmc_app_send_scr(struct mmc_card *ca
 
 	cmd.opcode = SD_APP_SEND_SCR;
 	cmd.arg = 0;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
 	data.blksz = 8;
 	data.blocks = 1;
@@ -278,6 +290,8 @@ int mmc_sd_switch(struct mmc_card *card,
 	BUG_ON(!card);
 	BUG_ON(!card->host);
 
+	/* NOTE: caller guarantees resp is heap-allocated */
+
 	mode = !!mode;
 	value &= 0xF;
 
@@ -292,7 +306,7 @@ int mmc_sd_switch(struct mmc_card *card,
 	cmd.arg = mode << 31 | 0x00FFFFFF;
 	cmd.arg &= ~(0xF << (group * 4));
 	cmd.arg |= value << (group * 4);
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
 	data.blksz = 64;
 	data.blocks = 1;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
