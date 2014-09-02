From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 9/9] spi: xtensa-xtfpga: Fix checkpatch issue
Date: Tue, 02 Sep 2014 11:54:37 +0900
Message-ID: <002901cfc659$3b9a9850$b2cfc8f0$%han@samsung.com>
References: <002101cfc658$4f627cf0$ee2776d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Max Filippov' <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002101cfc658$4f627cf0$ee2776d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix the following checkpatch warnings.

  WARNING: Missing a blank line after declarations

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-xtensa-xtfpga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
index 41e158187f9d..0dc5df5233a9 100644
--- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -46,6 +46,7 @@ static inline unsigned int xtfpga_spi_read32(const struct xtfpga_spi *spi,
 static inline void xtfpga_spi_wait_busy(struct xtfpga_spi *xspi)
 {
 	unsigned i;
+
 	for (i = 0; xtfpga_spi_read32(xspi, XTFPGA_SPI_BUSY) &&
 	     i < BUSY_WAIT_US; ++i)
 		udelay(1);
-- 
2.0.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
