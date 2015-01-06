From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2] spi: sh-msiof: fix MDR1_FLD_MASK value
Date: Tue, 6 Jan 2015 20:04:00 +0900
Message-ID: <1420542240-6548-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Since the FLD bit field is bit[3:2], the MDR1_FLD_MASK value should
be 0x0000000c.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 Changes from v1:
  - rebase top of spi/for-next branch.
    (commit id = b47ed8d2ab075a700fd517c72b9d1729f94479ba)

 drivers/spi/spi-sh-msiof.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 3f7ea2d..c58c249 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -84,7 +84,7 @@ struct sh_msiof_spi_priv {
 #define MDR1_BITLSB_SHIFT	 24 /* MSB/LSB First (1 = LSB first) */
 #define MDR1_DTDL_SHIFT		 20 /* Data Pin Bit Delay for MSIOF_SYNC */
 #define MDR1_SYNCDL_SHIFT	 16 /* Frame Sync Signal Timing Delay */
-#define MDR1_FLD_MASK	 0x000000c0 /* Frame Sync Signal Interval (0-3) */
+#define MDR1_FLD_MASK	 0x0000000c /* Frame Sync Signal Interval (0-3) */
 #define MDR1_FLD_SHIFT		  2
 #define MDR1_XXSTP	 0x00000001 /* Transmission/Reception Stop on FIFO */
 /* TMDR1 */
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
