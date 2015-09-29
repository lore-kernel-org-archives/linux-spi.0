From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] spi: bitbang: remove unneeded check
Date: Tue, 29 Sep 2015 23:09:33 +0200
Message-ID: <560AFE0D.7000307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Remove an unneeded check. The SPI core (__spi_validate) takes care
that these fields are always populated.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-bitbang.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index ef43ef5..ad3168d 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -272,7 +272,6 @@ static int spi_bitbang_transfer_one(struct spi_master *master,
 	struct spi_transfer	*t = NULL;
 	unsigned		cs_change;
 	int			status;
-	int			do_setup = -1;
 	struct spi_device	*spi = m->spi;
 
 	bitbang = spi_master_get_devdata(master);
@@ -288,19 +287,10 @@ static int spi_bitbang_transfer_one(struct spi_master *master,
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 
-		/* override speed or wordsize? */
-		if (t->speed_hz || t->bits_per_word)
-			do_setup = 1;
-
-		/* init (-1) or override (1) transfer params */
-		if (do_setup != 0) {
-			if (bitbang->setup_transfer) {
-				status = bitbang->setup_transfer(spi, t);
-				if (status < 0)
-					break;
-			}
-			if (do_setup == -1)
-				do_setup = 0;
+		if (bitbang->setup_transfer) {
+			status = bitbang->setup_transfer(spi, t);
+			if (status < 0)
+				break;
 		}
 
 		/* set up default clock polarity, and activate chip;
-- 
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
