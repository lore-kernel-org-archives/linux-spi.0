From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] spi: xilinx: remove unnecessary spaces
Date: Wed, 26 Feb 2014 10:24:47 +0900
Message-ID: <003101cf3291$8948f3a0$9bdadae0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Michal Simek' <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Remove unnecessary space in order to fix the following
checkpatch issues.

  WARNING: Unnecessary space after function pointer name

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-xilinx.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 66dbefc..a3b0b99 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -87,10 +87,10 @@ struct xilinx_spi {
 	const u8 *tx_ptr;	/* pointer in the Rx buffer */
 	int remaining_bytes;	/* the number of bytes left to transfer */
 	u8 bits_per_word;
-	unsigned int (*read_fn) (void __iomem *);
-	void (*write_fn) (u32, void __iomem *);
-	void (*tx_fn) (struct xilinx_spi *);
-	void (*rx_fn) (struct xilinx_spi *);
+	unsigned int (*read_fn)(void __iomem *);
+	void (*write_fn)(u32, void __iomem *);
+	void (*tx_fn)(struct xilinx_spi *);
+	void (*rx_fn)(struct xilinx_spi *);
 };
 
 static void xspi_write32(u32 val, void __iomem *addr)
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
