From: Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Doc: spi: make xmldocs warning caused by spi.c
Date: Mon, 22 Feb 2016 20:33:44 +0900
Message-ID: <1456140824-15744-1-git-send-email-standby24x7@gmail.com>
Cc: Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch fix following warnings while make xmldocs.

.//drivers/spi/spi.c:2354: warning: Excess function parameter
'message' description in 'spi_split_transfers_maxsize'
.//drivers/spi/spi.c:2354: warning: Excess function parameter
 'max_size' description in 'spi_split_transfers_maxsize'

Signed-off-by: Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3e45fca..fe01963 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2342,8 +2342,8 @@ static int __spi_split_transfer_maxsize(struct spi_master *master,
  *                              when an individual transfer exceeds a
  *                              certain size
  * @master:    the @spi_master for this transfer
- * @message:   the @spi_message to transform
- * @max_size:  the maximum when to apply this
+ * @msg:   the @spi_message to transform
+ * @maxsize:  the maximum when to apply this
  *
  * Return: status of transformation
  */
-- 
2.7.1.339.g0233b80

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
