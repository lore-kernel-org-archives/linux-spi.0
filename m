From: Christian Engelmayer <cengelma-RbZlAiThDcE@public.gmane.org>
Subject: [PATCH] spi: orion: Remove unused pointer in orion_spi_write_read()
Date: Wed, 5 Feb 2014 22:23:01 +0100
Message-ID: <20140205222301.14fbb441@spike>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/NAYrErCbyCjRzvHskvNA_oG"; protocol="application/pgp-signature"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--Sig_/NAYrErCbyCjRzvHskvNA_oG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Remove unused devdata pointer 'orion_spi' in function orion_spi_write_read(=
).

Detected by Coverity: CID 1077860.

Signed-off-by: Christian Engelmayer <cengelma-RbZlAiThDcE@public.gmane.org>
---
 drivers/spi/spi-orion.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 7f2121f..75871d4 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -260,11 +260,9 @@ orion_spi_write_read_16bit(struct spi_device *spi,
 static unsigned int
 orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 {
-	struct orion_spi *orion_spi;
 	unsigned int count;
 	int word_len;
=20
-	orion_spi =3D spi_master_get_devdata(spi->master);
 	word_len =3D spi->bits_per_word;
 	count =3D xfer->len;
=20
--=20
1.8.3.2

--Sig_/NAYrErCbyCjRzvHskvNA_oG
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS8qu1AAoJEKssnEpaPQKE67cP/jrYq6FHo8JZIfT8vvmmKSZJ
/EZFv/oSt9BK2gZcvJG8Q8J118NnFKK0kpix5JKl/hJFWwFEPPZIafFdRRyIgmty
YJskVaEnIbQzS0heTFy9a31OdIaaI/AGsBRRj3ZC+eaOAnRjrsaY2YKYKc7cAR0t
Xnlzowntp4GrWuA8gtReL1GA3rwnT9CGDTC6YTPn0MKWZGVfoy/opXrRZo1tbmdA
l/qcHnfIKZWiGv/Oxx1wyOLpksQUvkIxUDne57ht8CcMqIPhC6hwmI5exPkVny5H
KalE2Ati3HERMNOP81a3QxUo2uq35DD8Sn2uIG4cIADWz6HO6cdrs/T0puUexo1u
+/ETTgl50LRjIP1lp4uMcAKHS7h/KUZTbaDvlKLrwjEuiGUMMmnPOmYnS0M18p4p
jzCWY6y8Qh/LUOkiRNY4Jqao5lOPx6JKmm5FmES5KmCn5wjzu3rYmmrQZXnj8ylX
FxZ1vhFC8Eo9ghoiu+60/enaf+5NqWizTeAqVY80jWmojO/x2ratSAry4GwpNmof
nrZBff22FTTSKxUkV36/4lk7wBPoLisLf6eeLgip9E/aRMcGrhC86M2F8ur4uk6N
J31DcHFwzoTj6UYc/QcgMU6IgDBSJmzu67FQ1c8RJkqQOUm8lJNMRwOVOGt7mO6W
w3W6OeHEV+gU77Ozl735
=ipWq
-----END PGP SIGNATURE-----

--Sig_/NAYrErCbyCjRzvHskvNA_oG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
