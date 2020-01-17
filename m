From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: npcm-pspi: improve spi transfer performance" to the spi tree
Date: Fri, 17 Jan 2020 15:44:24 +0000 (GMT)
Message-ID: <applied-20200115162301.235926-3-tmaimon77@gmail.com>
References: <20200115162301.235926-3-tmaimon77@gmail.com>
Cc: avifishman70-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, benjaminfair-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        tali.perry1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, venture-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, yuenn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
To: Tomer Maimon <tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200115162301.235926-3-tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: npcm-pspi: improve spi transfer performance

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

>From b4adf5b27d59cdefff1e6fcba99151edea65a9f7 Mon Sep 17 00:00:00 2001
From: Tomer Maimon <tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 15 Jan 2020 18:22:59 +0200
Subject: [PATCH] spi: npcm-pspi: improve spi transfer performance

Improving spi 8 bit per word mode transfer performance
by using 16 bit per word transfer and receive when the data
length is even and larger than one.

Signed-off-by: Tomer Maimon <tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Link: https://lore.kernel.org/r/20200115162301.235926-3-tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-npcm-pspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index fe624731c74c..d224aa63dbce 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -178,6 +178,13 @@ static void npcm_pspi_setup_transfer(struct spi_device *spi,
 		priv->mode = spi->mode;
 	}
 
+	/*
+	 * If transfer is even length, and 8 bits per word transfer,
+	 * then implement 16 bits-per-word transfer.
+	 */
+	if (priv->bits_per_word == 8 && !(t->len & 0x1))
+		t->bits_per_word = 16;
+
 	if (!priv->is_save_param || priv->bits_per_word != t->bits_per_word) {
 		npcm_pspi_set_transfer_size(priv, t->bits_per_word);
 		priv->bits_per_word = t->bits_per_word;
-- 
2.20.1
