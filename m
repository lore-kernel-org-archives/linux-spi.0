From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.22-rc4 4/7] MMC headers understand
	SPI
Date: Mon, 4 Jun 2007 20:34:35 -0700
Message-ID: <200706042034.35542.david-b@pacbell.net>
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

Teach the MMC/SD/SDIO system headers that some hosts use SPI mode

 - New host capabilities bits
    * MMC_CAP_SPI, with mmc_host_is_spi() test
    * MMC_CAP_SPI_CRC, if it's ready to use CRCs
 
 - SPI-specific declarations:
    * Response types, MMC_RSP_SPI_R*
    * Two SPI-only commands 
    * Status bits used native to SPI:  R1_SPI_*, R2_SPI_*

 - Fix a few (unrelated) whitespace bugs in the headers.

None of these changes affects current code.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 include/linux/mmc/core.h |   25 ++++++++++++++++++++++--
 include/linux/mmc/host.h |    4 +++
 include/linux/mmc/mmc.h  |   48 ++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 68 insertions(+), 9 deletions(-)

--- g26.orig/include/linux/mmc/host.h	2007-05-06 08:28:03.000000000 -0700
+++ g26/include/linux/mmc/host.h	2007-06-04 19:58:56.000000000 -0700
@@ -90,6 +90,8 @@ struct mmc_host {
 #define MMC_CAP_BYTEBLOCK	(1 << 2)	/* Can do non-log2 block sizes */
 #define MMC_CAP_MMC_HIGHSPEED	(1 << 3)	/* Can do MMC high-speed timing */
 #define MMC_CAP_SD_HIGHSPEED	(1 << 4)	/* Can do SD high-speed timing */
+#define MMC_CAP_SPI		(1 << 5)	/* Talks only SPI protocols */
+#define MMC_CAP_SPI_CRC		(1 << 6)	/* Handles CRC option in SPI */
 
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
@@ -137,6 +139,8 @@ static inline void *mmc_priv(struct mmc_
 	return (void *)host->private;
 }
 
+#define mmc_host_is_spi(host)	((host)->caps & MMC_CAP_SPI)
+
 #define mmc_dev(x)	((x)->parent)
 #define mmc_classdev(x)	(&(x)->class_dev)
 #define mmc_hostname(x)	((x)->class_dev.bus_id)
--- g26.orig/include/linux/mmc/core.h	2007-05-06 08:28:03.000000000 -0700
+++ g26/include/linux/mmc/core.h	2007-06-04 19:58:56.000000000 -0700
@@ -25,14 +25,19 @@ struct mmc_command {
 #define MMC_RSP_CRC	(1 << 2)		/* expect valid crc */
 #define MMC_RSP_BUSY	(1 << 3)		/* card may send busy */
 #define MMC_RSP_OPCODE	(1 << 4)		/* response contains opcode */
-#define MMC_CMD_MASK	(3 << 5)		/* command type */
+
+#define MMC_CMD_MASK	(3 << 5)		/* non-SPI command type */
 #define MMC_CMD_AC	(0 << 5)
 #define MMC_CMD_ADTC	(1 << 5)
 #define MMC_CMD_BC	(2 << 5)
 #define MMC_CMD_BCR	(3 << 5)
 
+#define MMC_RSP_SPI_S1	(1 << 7)		/* one status byte */
+#define MMC_RSP_SPI_S2	(1 << 8)		/* second status byte */
+#define MMC_RSP_SPI_OCR	(1 << 9)		/* OCR */
+
 /*
- * These are the response types, and correspond to valid bit
+ * These are the native response types, and correspond to valid bit
  * patterns of the above flags.  One additional valid pattern
  * is all zeros, which means we don't expect a response.
  */
@@ -47,6 +52,22 @@ struct mmc_command {
 #define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
 
 /*
+ * These are the SPI response types.  Commands return R1, with maybe
+ * more info.  Commands like SEND_CSD return a data block too, which
+ * we call 'R1D'.  Zero is an invalid type, meaning that the caller
+ * forgot to say which response type applies to this command.
+ *
+ * FIXME remove R1D; update SEND_CxD in the core.
+ */
+#define MMC_RSP_SPI_R1	(MMC_RSP_SPI_S1)
+#define MMC_RSP_SPI_R1B	(MMC_RSP_SPI_S1|MMC_RSP_BUSY)
+#define MMC_RSP_SPI_R2	(MMC_RSP_SPI_S1|MMC_RSP_SPI_S2)
+#define MMC_RSP_SPI_R3	(MMC_RSP_SPI_S1|MMC_RSP_SPI_OCR)
+#define MMC_RSP_SPI_R1D	(MMC_RSP_SPI_S1|MMC_RSP_136)
+
+#define mmc_spi_resp_type(cmd)	((cmd)->flags & (MMC_RSP_SPI_S1|MMC_RSP_BUSY|MMC_RSP_SPI_S2|MMC_RSP_SPI_OCR|MMC_RSP_136))
+
+/*
  * These are the command types.
  */
 #define mmc_cmd_type(cmd)	((cmd)->flags & MMC_CMD_MASK)
--- g26.orig/include/linux/mmc/mmc.h	2007-05-06 08:28:03.000000000 -0700
+++ g26/include/linux/mmc/mmc.h	2007-06-04 19:58:56.000000000 -0700
@@ -27,7 +27,7 @@
 
 /* Standard MMC commands (4.1)           type  argument     response */
    /* class 1 */
-#define	MMC_GO_IDLE_STATE         0   /* bc                          */
+#define MMC_GO_IDLE_STATE         0   /* bc                          */
 #define MMC_SEND_OP_COND          1   /* bcr  [31:0] OCR         R3  */
 #define MMC_ALL_SEND_CID          2   /* bcr                     R2  */
 #define MMC_SET_RELATIVE_ADDR     3   /* ac   [31:16] RCA        R1  */
@@ -39,8 +39,10 @@
 #define MMC_SEND_CID             10   /* ac   [31:16] RCA        R2  */
 #define MMC_READ_DAT_UNTIL_STOP  11   /* adtc [31:0] dadr        R1  */
 #define MMC_STOP_TRANSMISSION    12   /* ac                      R1b */
-#define MMC_SEND_STATUS	         13   /* ac   [31:16] RCA        R1  */
+#define MMC_SEND_STATUS          13   /* ac   [31:16] RCA        R1  */
 #define MMC_GO_INACTIVE_STATE    15   /* ac   [31:16] RCA            */
+#define MMC_SPI_READ_OCR         58   /* spi                  spi_R3 */
+#define MMC_SPI_CRC_ON_OFF       59   /* spi  [0:0] flag      spi_R1 */
 
   /* class 2 */
 #define MMC_SET_BLOCKLEN         16   /* ac   [31:0] block len   R1  */
@@ -90,15 +92,15 @@
  */
 
 /*
-  MMC status in R1
+  MMC status in R1, for native mode (SPI bits are different)
   Type
-  	e : error bit
+	e : error bit
 	s : status bit
 	r : detected and set for the actual command response
 	x : detected and set during command execution. the host must poll
             the card by sending status command in order to read these bits.
   Clear condition
-  	a : according to the card state
+	a : according to the card state
 	b : always related to the previous command. Reception of
             a valid command will clear it (with a delay of one command)
 	c : clear by read
@@ -124,10 +126,42 @@
 #define R1_CARD_ECC_DISABLED	(1 << 14)	/* sx, a */
 #define R1_ERASE_RESET		(1 << 13)	/* sr, c */
 #define R1_STATUS(x)            (x & 0xFFFFE000)
-#define R1_CURRENT_STATE(x)    	((x & 0x00001E00) >> 9)	/* sx, b (4 bits) */
+#define R1_CURRENT_STATE(x)	((x & 0x00001E00) >> 9)	/* sx, b (4 bits) */
 #define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
 #define R1_APP_CMD		(1 << 5)	/* sr, c */
 
+#define R1_STATE_IDLE		0		/* resetting; maybe opendrain */
+#define R1_STATE_READY		1		/* opendrain; ident soon */
+#define R1_STATE_IDENT		2		/* opendrain; setaddr soon */
+#define R1_STATE_STBY		3		/* addressed, ready to use */
+#define R1_STATE_TRAN		4
+#define R1_STATE_DATA		5
+#define R1_STATE_RCV		6
+#define R1_STATE_PRG		7
+#define R1_STATE_DIS		8
+#define R1_STATE(x)		(((x) & 0xf) << 9)
+
+/*
+ * MMC/SD in SPI mode reports R1 status always, and R2 for SEND_STATUS
+ */
+#define R1_SPI_IDLE		(1 << 0)
+#define R1_SPI_ERASE_RESET	(1 << 1)
+#define R1_SPI_ILLEGAL_COMMAND	(1 << 2)
+#define R1_SPI_COM_CRC		(1 << 3)
+#define R1_SPI_ERASE_SEQ	(1 << 4)
+#define R1_SPI_ADDRESS		(1 << 5)
+#define R1_SPI_PARAMETER	(1 << 6)
+
+#define R2_SPI_CARD_LOCKED	(1 << 0)
+#define R2_SPI_WP_ERASE_SKIP	(1 << 1)	/* or lock/unlock fail */
+#define R2_SPI_ERROR		(1 << 2)
+#define R2_SPI_CC_ERROR		(1 << 3)
+#define R2_SPI_CARD_ECC_ERROR	(1 << 4)
+#define R2_SPI_WP_VIOLATION	(1 << 5)
+#define R2_SPI_ERASE_PARAM	(1 << 6)
+#define R2_SPI_OUT_OF_RANGE	(1 << 7)	/* or CSD overwrite */
+
+
 /* These are unpacked versions of the actual responses */
 
 struct _mmc_csd {
@@ -181,7 +215,7 @@ struct _mmc_csd {
  * Card Command Classes (CCC)
  */
 #define CCC_BASIC		(1<<0)	/* (0) Basic protocol functions */
-					/* (CMD0,1,2,3,4,7,9,10,12,13,15) */
+					/* (CMD0,1,2,3,4,7,9,10,12,13,15,58,59) */
 #define CCC_STREAM_READ		(1<<1)	/* (1) Stream read commands */
 					/* (CMD11) */
 #define CCC_BLOCK_READ		(1<<2)	/* (2) Block read commands */

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
