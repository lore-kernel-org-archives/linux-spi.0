From: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: [PATCH] spi: pic32: fix spelling mistakes on macro names
Date: Mon, 24 Jul 2017 22:44:45 +0100
Message-ID: <20170724214445.15383-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>

Trivial fix to spelling mistakes macros; fix EMPTY spellings:
RX_FIFO_EMTPY -> RX_FIFO_EMPTY
TX_FIFO_EMTPY -> TX_FIFO_EMPTY

Note that there are no other occurrances of these macros in the
source.

Signed-off-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
---
 drivers/spi/spi-pic32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index fefb688a3432..f8a45af1fa9f 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -52,14 +52,14 @@ struct pic32_spi_regs {
 
 /* Bit fields of SPI Control Register */
 #define CTRL_RX_INT_SHIFT	0  /* Rx interrupt generation */
-#define  RX_FIFO_EMTPY		0
+#define  RX_FIFO_EMPTY		0
 #define  RX_FIFO_NOT_EMPTY	1 /* not empty */
 #define  RX_FIFO_HALF_FULL	2 /* full by half or more */
 #define  RX_FIFO_FULL		3 /* completely full */
 
 #define CTRL_TX_INT_SHIFT	2  /* TX interrupt generation */
 #define  TX_FIFO_ALL_EMPTY	0 /* completely empty */
-#define  TX_FIFO_EMTPY		1 /* empty */
+#define  TX_FIFO_EMPTY		1 /* empty */
 #define  TX_FIFO_HALF_EMPTY	2 /* empty by half or more */
 #define  TX_FIFO_NOT_FULL	3 /* atleast one empty */
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
