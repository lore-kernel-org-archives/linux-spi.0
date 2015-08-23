From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Subject: [PATCH 1/2 RESEND] spi: check bits_per_word in spi_setup
Date: Sun, 23 Aug 2015 16:06:30 +0200
Message-ID: <c643f615-98ed-453d-b4cc-1b8777925cf6@HUB2.rwth-ad.de>
References: <1440338791-30841-1-git-send-email-stefan.bruens@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440338791-30841-1-git-send-email-stefan.bruens-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This allows drivers for devices connected via SPI to check if the
controller supports a given bits_per_word value during setup.
Currently any BPW value is accepted durings setup, and transfers
are rejected later.

Signed-off-by: Stefan Br=C3=BCns <stefan.bruens-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
---
 drivers/spi/spi.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cf8b91b..98aaa31 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1740,6 +1740,20 @@ EXPORT_SYMBOL_GPL(spi_busnum_to_master);
  * other core methods are currently defined as inline functions.
  */
=20
+static int __spi_validate_bits_per_word(struct spi_master *master, u8 =
bits_per_word)
+{
+	if (master->bits_per_word_mask) {
+		/* Only 32 bits fit in the mask */
+		if (bits_per_word > 32)
+			return -EINVAL;
+		if (!(master->bits_per_word_mask &
+				SPI_BPW_MASK(bits_per_word)))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * spi_setup - setup SPI mode and clock rate
  * @spi: the device whose settings are being modified
@@ -1798,6 +1812,9 @@ int spi_setup(struct spi_device *spi)
 	if (!spi->bits_per_word)
 		spi->bits_per_word =3D 8;
=20
+	if (__spi_validate_bits_per_word(spi->master, spi->bits_per_word))
+		return -EINVAL;
+
 	if (!spi->max_speed_hz)
 		spi->max_speed_hz =3D spi->master->max_speed_hz;
=20
@@ -1865,14 +1882,8 @@ static int __spi_validate(struct spi_device *spi=
, struct spi_message *message)
 		    xfer->speed_hz > master->max_speed_hz)
 			xfer->speed_hz =3D master->max_speed_hz;
=20
-		if (master->bits_per_word_mask) {
-			/* Only 32 bits fit in the mask */
-			if (xfer->bits_per_word > 32)
-				return -EINVAL;
-			if (!(master->bits_per_word_mask &
-					BIT(xfer->bits_per_word - 1)))
-				return -EINVAL;
-		}
+		if (__spi_validate_bits_per_word(master, xfer->bits_per_word))
+			return -EINVAL;
=20
 		/*
 		 * SPI transfer length should be multiple of SPI word size
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
