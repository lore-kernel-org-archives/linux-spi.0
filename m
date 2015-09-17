From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mpc512x: Call mpc512x_psc_spi_transfer_setup() unconditionally" to the spi tree
Date: Thu, 17 Sep 2015 18:37:12 +0100
Message-ID: <E1Zcd7Q-0006XR-FI@finisterre>
References: <1442323588-29642-7-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-7-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mpc512x: Call mpc512x_psc_spi_transfer_setup() unconditionally

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

>From 85c1912d44081173b9cd796955959a8201aa7a4e Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Tue, 15 Sep 2015 16:26:19 +0300
Subject: [PATCH] spi: mpc512x: Call mpc512x_psc_spi_transfer_setup()
 unconditionally

SPI core validates both bits_per_word and speed_hz transfer parameters and
thus the if statement here is needless as it will always call the
mpc512x_psc_spi_transfer_setup().

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mpc512x-psc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 1e75341..c3ec46c 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -302,11 +302,9 @@ static int mpc512x_psc_spi_msg_xfer(struct spi_master *master,
 	cs_change = 1;
 	status = 0;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->bits_per_word || t->speed_hz) {
-			status = mpc512x_psc_spi_transfer_setup(spi, t);
-			if (status < 0)
-				break;
-		}
+		status = mpc512x_psc_spi_transfer_setup(spi, t);
+		if (status < 0)
+			break;
 
 		if (cs_change)
 			mpc512x_psc_spi_activate_cs(spi);
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
