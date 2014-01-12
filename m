From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH] spi: Kill superfluous cast in spi_w8r16()
Date: Sun, 12 Jan 2014 13:59:06 +0100
Message-ID: <1389531546-5867-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

spi_write_then_read() takes a "void *" for rxbuf, so there's no need to
cast the buffer pointer to "u8 *".

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 include/linux/spi/spi.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8c62ba74dd91..02a759ef9bc3 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -847,7 +847,7 @@ static inline ssize_t spi_w8r16(struct spi_device *spi, u8 cmd)
 	ssize_t			status;
 	u16			result;
 
-	status = spi_write_then_read(spi, &cmd, 1, (u8 *) &result, 2);
+	status = spi_write_then_read(spi, &cmd, 1, &result, 2);
 
 	/* return negative errno or unsigned value */
 	return (status < 0) ? status : result;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
