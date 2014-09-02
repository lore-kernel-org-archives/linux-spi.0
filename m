From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 8/9] spi: txx9: Fix checkpatch issue
Date: Tue, 02 Sep 2014 11:53:54 +0900
Message-ID: <002801cfc659$222039c0$6660ad40$%han@samsung.com>
References: <002101cfc658$4f627cf0$ee2776d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Atsushi Nemoto' <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002101cfc658$4f627cf0$ee2776d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix the following checkpatch warnings.

  Missing a blank line after declarations.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-txx9.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 5f183baa91a9..2501a8373e89 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -97,6 +97,7 @@ static void txx9spi_cs_func(struct spi_device *spi, struct txx9spi *c,
 		int on, unsigned int cs_delay)
 {
 	int val = (spi->mode & SPI_CS_HIGH) ? on : !on;
+
 	if (on) {
 		/* deselect the chip with cs_change hint in last transfer */
 		if (c->last_chipselect >= 0)
@@ -188,6 +189,7 @@ static void txx9spi_work_one(struct txx9spi *c, struct spi_message *m)
 		if (prev_speed_hz != speed_hz
 				|| prev_bits_per_word != bits_per_word) {
 			int n = DIV_ROUND_UP(c->baseclk, speed_hz) - 1;
+
 			n = clamp(n, SPI_MIN_DIVIDER, SPI_MAX_DIVIDER);
 			/* enter config mode */
 			txx9spi_wr(c, mcr | TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR,
-- 
2.0.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
