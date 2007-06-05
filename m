From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.22-rc4 8/7] mmc_spi cid/csd/ext_csd
	updates, CRCs on
Date: Tue, 5 Jun 2007 10:13:44 -0700
Message-ID: <200706051013.44971.david-b@pacbell.net>
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

Fix some of the "register"/descriptor access glitches in the
preceding patches:

  - Updated internal routines:
      * previous mmc_send_cxd() renamed to mmc_send_cxd_native(); it
        uses native "R2" responses, which include 16 bytes of data.
      * previous mmc_send_ext_csd() becomes new mmc_send_cxd_data()
        helper for command-and-data access

  - Modified mmc_send_ext_csd() now uses mmc_send_cxd_data() helper

  - New mmc_send_csd() and mmc_spi_send_cid() routines now use one
    of those helper routines based on whether they're native or SPI;

  - Remove ugly "R1D" response pseudo-type for SPI

  - Make it OK for MMC cards to try SEND_EXT_CSD; v4+ needs that

  - Turn CRCs back on by default with the SPI protocol

So this resolves most of the technical issues I know about, leaving
nontechnical ones like "is this code clean enough" or "is this how
we want to solve that problem".

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/mmc/core/mmc.c     |    2 
 drivers/mmc/core/mmc_ops.c |   93 +++++++++++++++++++++++++++++++++------------
 drivers/mmc/host/mmc_spi.c |   59 ----------------------------
 include/linux/mmc/core.h   |    8 ---
 4 files changed, 72 insertions(+), 90 deletions(-)

--- g26.orig/drivers/mmc/core/mmc_ops.c	2007-06-04 19:58:58.000000000 -0700
+++ g26/drivers/mmc/core/mmc_ops.c	2007-06-05 10:05:20.000000000 -0700
@@ -175,7 +175,7 @@ int mmc_set_relative_addr(struct mmc_car
 }
 
 static int
-mmc_send_cxd(struct mmc_host *host, unsigned rca, u32 *cxd, int opcode)
+mmc_send_cxd_native(struct mmc_host *host, unsigned rca, u32 *cxd, int opcode)
 {
 	int err;
 	struct mmc_command cmd;
@@ -187,7 +187,7 @@ mmc_send_cxd(struct mmc_host *host, unsi
 
 	cmd.opcode = opcode;
 	cmd.arg = rca << 16;
-	cmd.flags = MMC_RSP_SPI_R1D | MMC_RSP_R2 | MMC_CMD_AC;
+	cmd.flags = MMC_RSP_R2 | MMC_CMD_AC;
 
 	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 	if (err != MMC_ERR_NONE)
@@ -198,16 +198,6 @@ mmc_send_cxd(struct mmc_host *host, unsi
 	return MMC_ERR_NONE;
 }
 
-int mmc_send_csd(struct mmc_card *card, u32 *csd)
-{
-	return mmc_send_cxd(card->host, card->rca, csd, MMC_SEND_CSD);
-}
-
-int mmc_spi_send_cid(struct mmc_host *host, u32 *cid)
-{
-	return mmc_send_cxd(host, 0, cid, MMC_SEND_CID);
-}
-
 int mmc_spi_read_ocr(struct mmc_host *host, u32 *ocrp)
 {
 	struct mmc_command cmd;
@@ -238,17 +228,22 @@ int mmc_spi_set_crc(struct mmc_host *hos
 	return mmc_wait_for_cmd(host, &cmd, 0);
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
@@ -256,21 +251,22 @@ int mmc_send_ext_csd(struct mmc_card *ca
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
@@ -280,6 +276,55 @@ int mmc_send_ext_csd(struct mmc_card *ca
 	return MMC_ERR_NONE;
 }
 
+int mmc_send_csd(struct mmc_card *card, u32 *csd)
+{
+	struct mmc_cxd	cxd;
+
+	if (!mmc_host_is_spi(card->host))
+		return mmc_send_cxd_native(card->host, card->rca,
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
--- g26.orig/drivers/mmc/host/mmc_spi.c	2007-06-04 19:59:01.000000000 -0700
+++ g26/drivers/mmc/host/mmc_spi.c	2007-06-05 10:05:20.000000000 -0700
@@ -181,13 +181,7 @@ module_param(debug, uint, 0644);
 #define	debug	0
 #endif
 
-/* FIXME turn this back on by default ... needs retesting */
-#if 0
 static unsigned use_crc = 1;
-#else
-static unsigned use_crc = 0;
-#endif
-
 module_param(use_crc, uint, 0);
 
 
@@ -384,51 +378,10 @@ static char *maptype(struct mmc_command 
 	case MMC_RSP_SPI_R1B:	return "R1B";
 	case MMC_RSP_SPI_R2:	return "R2";
 	case MMC_RSP_SPI_R3:	return "R3";
-	case MMC_RSP_SPI_R1D:	return "R1D";
 	default:		return "?";
 	}
 }
 
-static void mmc_spi_read_cXd(struct mmc_spi_host *host, struct mmc_command *cmd)
-{
-	int status;
-
-	/* skip till first byte of data block */
-	status = mmc_spi_scanbyte(host, mmc_spi_delayed, READ_TIMEOUT);
-
-	/* if we found the data block, read it; else report timeout */
-	if (status == SPI_TOKEN_SINGLE) {
-
-		spi_message_init(&host->m);
-		memset(&host->t, 0, sizeof(host->t));
-		spi_message_add_tail(&host->t, &host->m);
-
-		memset(cmd->resp, 0xff, 16);
-		host->t.tx_buf = cmd->resp;
-		host->t.rx_buf = cmd->resp;
-		host->t.len = 16;
-
-		/* REVISIT 16 bit CRC ... ? */
-
-		status = spi_sync(host->spi, &host->m);
-		if (status < 0)
-			cmd->error = MMC_ERR_FAILED;
-		else {
-			be32_to_cpus(&cmd->resp[0]);
-			be32_to_cpus(&cmd->resp[1]);
-			be32_to_cpus(&cmd->resp[2]);
-			be32_to_cpus(&cmd->resp[3]);
-		}
-	} else {
-		if (status > 0)
-			mmc_spi_map_data_err(cmd, status);
-		dev_dbg(&host->spi->dev,
-			"mmc_spi: read cXd, %02x %d \n",
-			status & 0xff, status);
-		cmd->error = MMC_ERR_TIMEOUT;
-	}
-}
-
 static int
 mmc_spi_response_get(struct mmc_spi_host *host, struct mmc_command *cmd)
 {
@@ -486,18 +439,6 @@ mmc_spi_response_get(struct mmc_spi_host
 		(void) mmc_spi_scanbyte(host, mmc_spi_busy, WRITE_TIMEOUT);
 		break;
 
-	/* SPI R1D == R1 + 16 bytes data; SEND_CSD, SEND_CID
-	 * for non-SPI this would be R2 type status
-	 *
-	 * FIXME remove the R1D "message type"; mmc core should
-	 * explicitly issue a data stage, handling CRCs right.
-	 */
-	case MMC_RSP_SPI_R1D:
-		mmc_spi_read_cXd(host, cmd);
-		dev_dbg(&host->spi->dev, "%s: status %d\n",
-			tag, cmd->error);
-		return 0;
-
 	/* SPI R2 == R1 + second status byte; SEND_STATUS */
 	case MMC_RSP_SPI_R2:
 		host->response[1] = mmc_spi_readbyte(host);
--- g26.orig/include/linux/mmc/core.h	2007-06-04 19:58:56.000000000 -0700
+++ g26/include/linux/mmc/core.h	2007-06-05 10:05:20.000000000 -0700
@@ -53,19 +53,15 @@ struct mmc_command {
 
 /*
  * These are the SPI response types.  Commands return R1, with maybe
- * more info.  Commands like SEND_CSD return a data block too, which
- * we call 'R1D'.  Zero is an invalid type, meaning that the caller
+ * more info.  Zero is an invalid type, meaning that the caller
  * forgot to say which response type applies to this command.
- *
- * FIXME remove R1D; update SEND_CxD in the core.
  */
 #define MMC_RSP_SPI_R1	(MMC_RSP_SPI_S1)
 #define MMC_RSP_SPI_R1B	(MMC_RSP_SPI_S1|MMC_RSP_BUSY)
 #define MMC_RSP_SPI_R2	(MMC_RSP_SPI_S1|MMC_RSP_SPI_S2)
 #define MMC_RSP_SPI_R3	(MMC_RSP_SPI_S1|MMC_RSP_SPI_OCR)
-#define MMC_RSP_SPI_R1D	(MMC_RSP_SPI_S1|MMC_RSP_136)
 
-#define mmc_spi_resp_type(cmd)	((cmd)->flags & (MMC_RSP_SPI_S1|MMC_RSP_BUSY|MMC_RSP_SPI_S2|MMC_RSP_SPI_OCR|MMC_RSP_136))
+#define mmc_spi_resp_type(cmd)	((cmd)->flags & (MMC_RSP_SPI_S1|MMC_RSP_BUSY|MMC_RSP_SPI_S2|MMC_RSP_SPI_OCR))
 
 /*
  * These are the command types.
--- g26.orig/drivers/mmc/core/mmc.c	2007-06-04 19:58:58.000000000 -0700
+++ g26/drivers/mmc/core/mmc.c	2007-06-05 10:05:20.000000000 -0700
@@ -325,7 +325,7 @@ static int mmc_sd_init_card(struct mmc_h
 	if (err != MMC_ERR_NONE)
 		goto free_card;
 
-	if (!oldcard && !mmc_host_is_spi(host)) {
+	if (!oldcard) {
 		/*
 		 * Fetch and process extended CSD.
 		 */

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
