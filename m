From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bitbang: remove unneeded check" to the spi tree
Date: Mon, 05 Oct 2015 16:11:43 +0100
Message-ID: <E1Zj7QV-00013R-TX@finisterre>
References: <560AFE0D.7000307@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <560AFE0D.7000307-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bitbang: remove unneeded check

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e30d8f23926b70a003d9fb16b49bfe23f01269da Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 29 Sep 2015 23:09:33 +0200
Subject: [PATCH] spi: bitbang: remove unneeded check

Remove an unneeded check. The SPI core (__spi_validate) takes care
that these fields are always populated.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
