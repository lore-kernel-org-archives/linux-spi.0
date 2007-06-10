From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 3/4] MMC-over-SPI core updates
Date: Sun, 10 Jun 2007 13:07:10 -0700
Message-ID: <200706101307.11394.david-b@pacbell.net>
References: <200706101257.45278.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706101257.45278.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

Teach the MMC/SD/SDIO core about using SPI mode.

 - Use mmc_host_is_spi() so enumeration works through SPI protocols,
   not just the native (and sometimes parallel) ones

 - Provide the SPI response type flags with each request issued,
   including rquests from the new lock/unlock code.  The model
   is that if no such flags are provided, it will be rejected 
   by the MMC-over-SPI host.

 - Understand that some commands act a bit differently ... notably the
   OP_COND command doesn't return the OCR, and does status differently.

Those changes required some new and updated primitives:

 - Provide utilities to access two SPI-only requests, and one
   request that wasn't previously needed:
     * mmc_spi_read_ocr() ... SPI only
     * mmc_spi_set_crc() ... SPI only
     * mmc_spi_send_cid() ... works without broadcast mode

 - Updated internal routines:
     * previous mmc_send_csd() modified into mmc_send_cxd_native();
       it uses native "R2" responses, which include 16 bytes of data.
     * previous mmc_send_ext_csd() becomes new mmc_send_cxd_data()
       helper for command-and-data access

 - Modified mmc_send_ext_csd() now uses mmc_send_cxd_data() helper

 - Modified mmc_send_csd(), and new mmc_spi_send_cid(), routines use
   those helper routines based on whether they're native or SPI

The current assumption is that nobody will want a controller driver
to handle both SPI *and* the faster "native" MMC/SD protocols, even
on hardware which can do that.

The SPI support hasn't been tested on the new MMC4 cards (they're not
widely available) or with the new card lock/unlock mechanism.  Likewise
SD cards with 4GB and up may have surprises lurking.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/mmc/core/core.c    |   38 ++++++++-
 drivers/mmc/core/mmc.c     |   26 ++++--
 drivers/mmc/core/mmc_ops.c |  173 +++++++++++++++++++++++++++++++++++----------
 drivers/mmc/core/mmc_ops.h |    4 +
 drivers/mmc/core/sd.c      |   36 ++++++---
 drivers/mmc/core/sd_ops.c  |   17 +++-
 6 files changed, 226 insertions(+), 68 deletions(-)

--- pxa.orig/drivers/mmc/core/mmc_ops.h	2007-06-10 13:00:21.000000000 -0700
+++ pxa/drivers/mmc/core/mmc_ops.h	2007-06-10 13:00:34.000000000 -0700
@@ -26,5 +26,9 @@ int mmc_switch(struct mmc_card *card, u8
 int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_lock_unlock(struct mmc_card *card, struct key *key, int mode);
 
+int mmc_spi_send_cid(struct mmc_host *host, u32 *cid);
+int mmc_spi_read_ocr(struct mmc_host *host, u32 *ocrp);
+int mmc_spi_set_crc(struct mmc_host *host);
+
 #endif
 
--- pxa.orig/drivers/mmc/core/core.c	2007-06-10 13:00:21.000000000 -0700
+++ pxa/drivers/mmc/core/core.c	2007-06-10 13:00:34.000000000 -0700
@@ -386,8 +386,13 @@ static void mmc_power_up(struct mmc_host
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
@@ -406,8 +411,10 @@ static void mmc_power_off(struct mmc_hos
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
@@ -498,6 +505,19 @@ void mmc_detect_change(struct mmc_host *
 EXPORT_SYMBOL(mmc_detect_change);
 
 
+static int mmc_spi_fixup(struct mmc_host *host, u32 *ocrp)
+{
+	int err;
+
+	if (!mmc_host_is_spi(host))
+		return MMC_ERR_NONE;
+
+	err = mmc_spi_read_ocr(host, ocrp);
+	if (err == MMC_ERR_NONE);
+		err = mmc_spi_set_crc(host);
+	return err;
+}
+
 void mmc_rescan(struct work_struct *work)
 {
 	struct mmc_host *host =
@@ -519,11 +539,13 @@ void mmc_rescan(struct work_struct *work
 		mmc_power_up(host);
 		mmc_go_idle(host);
 
-		mmc_send_if_cond(host, host->ocr_avail);
+		if (!mmc_host_is_spi(host))
+			mmc_send_if_cond(host, host->ocr_avail);
 
 		err = mmc_send_app_op_cond(host, 0, &ocr);
 		if (err == MMC_ERR_NONE) {
-			if (mmc_attach_sd(host, ocr))
+			err = mmc_spi_fixup(host, &ocr);
+			if (err != MMC_ERR_NONE || mmc_attach_sd(host, ocr))
 				mmc_power_off(host);
 		} else {
 			/*
@@ -532,7 +554,9 @@ void mmc_rescan(struct work_struct *work
 			 */
 			err = mmc_send_op_cond(host, 0, &ocr);
 			if (err == MMC_ERR_NONE) {
-				if (mmc_attach_mmc(host, ocr))
+				err = mmc_spi_fixup(host, &ocr);
+				if (err != MMC_ERR_NONE
+						|| mmc_attach_mmc(host, ocr))
 					mmc_power_off(host);
 			} else {
 				mmc_power_off(host);
--- pxa.orig/drivers/mmc/core/mmc_ops.c	2007-06-10 13:00:21.000000000 -0700
+++ pxa/drivers/mmc/core/mmc_ops.c	2007-06-10 13:00:34.000000000 -0700
@@ -31,6 +31,10 @@ static int _mmc_select_card(struct mmc_h
 
 	BUG_ON(!host);
 
+	/* SPI doesn't multiplex; "select" is meaningless */
+	if (mmc_host_is_spi(host))
+		return MMC_ERR_NONE;
+
 	memset(&cmd, 0, sizeof(struct mmc_command));
 
 	cmd.opcode = MMC_SELECT_CARD;
@@ -67,23 +71,30 @@ int mmc_go_idle(struct mmc_host *host)
 	int err;
 	struct mmc_command cmd;
 
-	mmc_set_chip_select(host, MMC_CS_HIGH);
-
-	mmc_delay(1);
+	/*
+	 * Non-SPI hosts need to prevent chipselect going active
+	 * during GO_IDLE; that would put chips into SPI mode.
+	 * SPI hosts necessarily ignore host->chip_select.
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
@@ -99,14 +110,18 @@ int mmc_send_op_cond(struct mmc_host *ho
 
 	cmd.opcode = MMC_SEND_OP_COND;
 	cmd.arg = ocr;
-	cmd.flags = MMC_RSP_R3 | MMC_CMD_BCR;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
 	for (i = 100; i; i--) {
 		err = mmc_wait_for_cmd(host, &cmd, 0);
 		if (err != MMC_ERR_NONE)
 			break;
 
-		if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
+		if (mmc_host_is_spi(host)) {
+			/* wait until reset completes */
+			if (!(cmd.resp[2] & R1_SPI_IDLE))
+				break;
+		} else if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
 			break;
 
 		err = MMC_ERR_TIMEOUT;
@@ -114,7 +129,7 @@ int mmc_send_op_cond(struct mmc_host *ho
 		mmc_delay(10);
 	}
 
-	if (rocr)
+	if (rocr && !mmc_host_is_spi(host))
 		*rocr = cmd.resp[0];
 
 	return err;
@@ -164,41 +179,46 @@ int mmc_set_relative_addr(struct mmc_car
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
+struct mmc_cxd {
+	struct mmc_card	*card;		/* optional */
+	void		*buf;
+	unsigned	len;
+	u32		opcode;
+	u32		arg;
+	unsigned	flags;
+};
+
+static int mmc_send_cxd_data(struct mmc_host *host, struct mmc_cxd *cxd)
 {
 	struct mmc_request mrq;
 	struct mmc_command cmd;
 	struct mmc_data data;
 	struct scatterlist sg;
 
-	BUG_ON(!card);
-	BUG_ON(!card->host);
-	BUG_ON(!ext_csd);
-
 	memset(&mrq, 0, sizeof(struct mmc_request));
 	memset(&cmd, 0, sizeof(struct mmc_command));
 	memset(&data, 0, sizeof(struct mmc_data));
@@ -206,21 +226,22 @@ int mmc_send_ext_csd(struct mmc_card *ca
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 
-	cmd.opcode = MMC_SEND_EXT_CSD;
-	cmd.arg = 0;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.opcode = cxd->opcode;
+	cmd.arg = cxd->arg;
+	cmd.flags = cxd->flags;
 
-	data.blksz = 512;
+	data.blksz = cxd->len;
 	data.blocks = 1;
 	data.flags = MMC_DATA_READ;
 	data.sg = &sg;
 	data.sg_len = 1;
 
-	sg_init_one(&sg, ext_csd, 512);
+	sg_init_one(&sg, cxd->buf, cxd->len);
 
-	mmc_set_data_timeout(&data, card, 0);
+	if (cxd->card)
+		mmc_set_data_timeout(&data, cxd->card, 0);
 
-	mmc_wait_for_req(card->host, &mrq);
+	mmc_wait_for_req(host, &mrq);
 
 	if (cmd.error != MMC_ERR_NONE)
 		return cmd.error;
@@ -230,6 +251,85 @@ int mmc_send_ext_csd(struct mmc_card *ca
 	return MMC_ERR_NONE;
 }
 
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
+int mmc_spi_set_crc(struct mmc_host *host)
+{
+	struct mmc_command cmd;
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_SPI_CRC_ON_OFF;
+	cmd.flags = MMC_RSP_SPI_R1;
+	if (host->caps & MMC_CAP_SPI_CRC)
+		cmd.arg = 1;
+
+	return mmc_wait_for_cmd(host, &cmd, 0);
+}
+
+int mmc_send_csd(struct mmc_card *card, u32 *csd)
+{
+	struct mmc_cxd	cxd;
+
+	if (!mmc_host_is_spi(card->host))
+		return mmc_send_cxd_native(card->host, card->rca << 16,
+				csd, MMC_SEND_CSD);
+
+	cxd.card = card;
+	cxd.buf = csd;
+	cxd.len = 16;
+	cxd.opcode = MMC_SEND_CSD;
+	cxd.arg = 0;
+	cxd.flags = MMC_RSP_SPI_R1;
+
+	return mmc_send_cxd_data(card->host, &cxd);
+}
+
+int mmc_spi_send_cid(struct mmc_host *host, u32 *cid)
+{
+	struct mmc_cxd	cxd;
+
+	if (!mmc_host_is_spi(host))
+		return mmc_send_cxd_native(host, 0, cid, MMC_SEND_CID);
+
+	cxd.card = NULL;
+	cxd.buf = cid;
+	cxd.len = 16;
+	cxd.opcode = MMC_SEND_CID;
+	cxd.arg = 0;
+	cxd.flags = MMC_RSP_SPI_R1;
+
+	return mmc_send_cxd_data(host, &cxd);
+}
+
+int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd)
+{
+	struct mmc_cxd	cxd;
+
+	cxd.card = card;
+	cxd.buf = ext_csd;
+	cxd.len = 512;
+	cxd.opcode = MMC_SEND_EXT_CSD;
+	cxd.arg = 0;
+	cxd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	return mmc_send_cxd_data(card->host, &cxd);
+}
+
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value)
 {
 	int err;
@@ -245,7 +345,7 @@ int mmc_switch(struct mmc_card *card, u8
 		  (index << 16) |
 		  (value << 8) |
 		  set;
-	cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
+	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
 	if (err != MMC_ERR_NONE)
@@ -265,8 +365,9 @@ int mmc_send_status(struct mmc_card *car
 	memset(&cmd, 0, sizeof(struct mmc_command));
 
 	cmd.opcode = MMC_SEND_STATUS;
-	cmd.arg = card->rca << 16;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	if (!mmc_host_is_spi(card->host))
+		cmd.arg = card->rca << 16;
+	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
 	if (err != MMC_ERR_NONE)
@@ -316,7 +417,7 @@ int mmc_lock_unlock(struct mmc_card *car
 
 	cmd.opcode = MMC_SET_BLOCKLEN;
 	cmd.arg = data_size;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
 	if (err != MMC_ERR_NONE)
 		goto out;
@@ -325,7 +426,7 @@ int mmc_lock_unlock(struct mmc_card *car
 
 	cmd.opcode = MMC_LOCK_UNLOCK;
 	cmd.arg = 0;
-	cmd.flags = MMC_RSP_R1B | MMC_CMD_ADTC;
+	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_ADTC;
 
 	memset(&data, 0, sizeof(struct mmc_data));
 
@@ -351,7 +452,7 @@ int mmc_lock_unlock(struct mmc_card *car
 
 	cmd.opcode = MMC_SEND_STATUS;
 	cmd.arg = card->rca << 16;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
 
 	/* set timeout for forced erase operation to 3 min. (see MMC spec) */
 	erase_timeout = jiffies + 180 * HZ;
--- pxa.orig/drivers/mmc/core/mmc.c	2007-06-10 13:00:21.000000000 -0700
+++ pxa/drivers/mmc/core/mmc.c	2007-06-10 13:00:34.000000000 -0700
@@ -320,9 +320,15 @@ static int mmc_init_card(struct mmc_host
 	/*
 	 * Fetch CID from card.
 	 */
-	err = mmc_all_send_cid(host, cid);
-	if (err != MMC_ERR_NONE)
-		goto err;
+	if (mmc_host_is_spi(host)) {
+		err = mmc_spi_send_cid(host, cid);
+		if (err != MMC_ERR_NONE)
+			goto err;
+	} else {
+		err = mmc_all_send_cid(host, cid);
+		if (err != MMC_ERR_NONE)
+			goto err;
+	}
 
 	if (oldcard) {
 		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0)
@@ -343,13 +349,15 @@ static int mmc_init_card(struct mmc_host
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
 
 	/*
 	 * Check if card is locked.
@@ -385,7 +393,7 @@ static int mmc_init_card(struct mmc_host
 
 	if (!oldcard) {
 		/*
-		 * Fetch and process extened CSD.
+		 * Fetch and process extended CSD.
 		 */
 		err = mmc_read_ext_csd(card);
 		if (err != MMC_ERR_NONE)
--- pxa.orig/drivers/mmc/core/sd.c	2007-06-10 13:00:21.000000000 -0700
+++ pxa/drivers/mmc/core/sd.c	2007-06-10 13:00:34.000000000 -0700
@@ -379,9 +379,19 @@ static int mmc_sd_init_card(struct mmc_h
 	/*
 	 * Fetch CID from card.
 	 */
-	err = mmc_all_send_cid(host, cid);
-	if (err != MMC_ERR_NONE)
-		goto err;
+	if (mmc_host_is_spi(host)) {
+		err = mmc_spi_set_crc(host);
+		if (err != MMC_ERR_NONE)
+			goto err;
+		err = mmc_spi_send_cid(host, cid);
+		if (err != MMC_ERR_NONE)
+			goto err;
+	} else {
+		err = mmc_all_send_cid(host, cid);
+		if (err != MMC_ERR_NONE)
+			goto err;
+	}
+
 
 	if (oldcard) {
 		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0)
@@ -401,13 +411,15 @@ static int mmc_sd_init_card(struct mmc_h
 	}
 
 	/*
-	 * Set card RCA.
+	 * For native busses:  set card RCA and leave open drain mode.
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
 
 	/*
 	 * Check if card is locked.
@@ -455,9 +467,11 @@ static int mmc_sd_init_card(struct mmc_h
 		/*
 		 * Fetch switch information from card.
 		 */
-		err = mmc_read_switch(card);
-		if (err != MMC_ERR_NONE)
-			goto free_card;
+		if (!mmc_host_is_spi(host)) {
+			err = mmc_read_switch(card);
+			if (err != MMC_ERR_NONE)
+				goto free_card;
+		}
 	}
 
 	/*
--- pxa.orig/drivers/mmc/core/sd_ops.c	2007-06-06 16:47:58.000000000 -0700
+++ pxa/drivers/mmc/core/sd_ops.c	2007-06-10 13:00:34.000000000 -0700
@@ -89,10 +89,10 @@ int mmc_app_cmd(struct mmc_host *host, s
 
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
@@ -148,14 +148,18 @@ int mmc_send_app_op_cond(struct mmc_host
 
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
+			if (!(cmd.resp[2] & R1_SPI_IDLE))
+				break;
+		} else if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
 			break;
 
 		err = MMC_ERR_TIMEOUT;
@@ -175,6 +179,9 @@ int mmc_send_if_cond(struct mmc_host *ho
 	int err;
 	static const u8 test_pattern = 0xAA;
 
+	if (mmc_host_is_spi(host))
+		return MMC_ERR_FAILED;
+
 	/*
 	 * To support SD 2.0 cards, we must always invoke SD_SEND_IF_COND
 	 * before SD_APP_OP_COND. This command will harmlessly fail for
@@ -242,7 +249,7 @@ int mmc_app_send_scr(struct mmc_card *ca
 
 	cmd.opcode = SD_APP_SEND_SCR;
 	cmd.arg = 0;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
 	data.blksz = 8;
 	data.blocks = 1;

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
