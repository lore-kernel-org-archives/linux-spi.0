From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: rspi: Make qspi_set_send_trigger() return "unsigned int"" to the spi tree
Date: Fri, 03 Jul 2015 15:10:57 +0100
Message-ID: <E1ZB1g9-00027h-2y@finisterre>
References: <1435064669-11969-2-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435064669-11969-2-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: rspi: Make qspi_set_send_trigger() return "unsigned int"

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

>From cb76b1ca9174aa29d4c7c0f4aef113be203b600c Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Date: Tue, 23 Jun 2015 15:04:29 +0200
Subject: [PATCH] spi: rspi: Make qspi_set_send_trigger() return "unsigned int"

qspi_set_send_trigger() returns an unsigned value, so make it return
"unsigned int".
Update the loop variables qspi_trigger_transfer_out_int() to match the
above.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 9a71fa2..8188433 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -383,7 +383,8 @@ static void qspi_update(const struct rspi_data *rspi, u8 mask, u8 val, u8 reg)
 	rspi_write8(rspi, data, reg);
 }
 
-static int qspi_set_send_trigger(struct rspi_data *rspi, unsigned int len)
+static unsigned int qspi_set_send_trigger(struct rspi_data *rspi,
+					  unsigned int len)
 {
 	unsigned int n;
 
@@ -724,7 +725,8 @@ static int rspi_rz_transfer_one(struct spi_master *master,
 static int qspi_trigger_transfer_out_in(struct rspi_data *rspi, const u8 *tx,
 					u8 *rx, unsigned int len)
 {
-	int i, n, ret;
+	unsigned int i, n;
+	int ret;
 
 	while (len > 0) {
 		n = qspi_set_send_trigger(rspi, len);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
