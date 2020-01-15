From: Tomer Maimon <tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 2/4] spi: npcm-pspi: improve spi transfer performance
Date: Wed, 15 Jan 2020 18:22:59 +0200
Message-ID: <20200115162301.235926-3-tmaimon77@gmail.com>
References: <20200115162301.235926-1-tmaimon77@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
        Tomer Maimon <tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        avifishman70-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tali.perry1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, venture-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org,
        yuenn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, benjaminfair-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200115162301.235926-1-tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Improving spi 8 bit per word mode transfer performance
by using 16 bit per word transfer and receive when the data
length is even and larger than one.

Signed-off-by: Tomer Maimon <tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-npcm-pspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index c74611abe2a9..eac7ba18b4b9 100644
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
2.22.0
