From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/8] spi: lm70llp: add blank line after declaration
Date: Mon,  7 Dec 2015 16:17:29 +0530
Message-ID: <1449485255-1103-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1449485255-1103-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449485255-1103-1-git-send-email-sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

checkpatch complains about missing blank line after declaration.

Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
---
 drivers/spi/spi-lm70llp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index eb4b421..7037028 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -119,12 +119,14 @@ static inline void assertCS(struct spi_lm70llp *pp)
 static inline void clkHigh(struct spi_lm70llp *pp)
 {
 	u8 data = parport_read_data(pp->port);
+
 	parport_write_data(pp->port, data | SCLK);
 }
 
 static inline void clkLow(struct spi_lm70llp *pp)
 {
 	u8 data = parport_read_data(pp->port);
+
 	parport_write_data(pp->port, data & ~SCLK);
 }
 
@@ -163,8 +165,10 @@ static inline void setmosi(struct spi_device *s, int is_on)
 static inline int getmiso(struct spi_device *s)
 {
 	struct spi_lm70llp *pp = spidev_to_pp(s);
+
 	return ((SIO == (parport_read_status(pp->port) & SIO)) ? 0 : 1 );
 }
+
 /*--------------------------------------------------------------------*/
 
 #include "spi-bitbang-txrx.h"
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
