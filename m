From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] spi: xilinx: Remove .owner field for driver
Date: Wed, 13 Aug 2014 13:52:39 +0200
Message-ID: <d35c656e50eb7cc951499f13ef339d6aa1a23deb.1407930755.git.michal.simek@xilinx.com>
Content-Type: multipart/signed;
    boundary="=_mimegpg-monstr-desktop-18625-1407930760-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-18625-1407930760-0001

There is no need to init .owner field.

Based on the patch from Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
"mmc: remove .owner field for drivers using module_platform_driver"

This patch removes the superflous .owner field for drivers which
use the module_platform_driver API, as this is overriden in
platform_driver_register anyway."

Signed-off-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---

 drivers/spi/spi-xilinx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 4d8efb16573d..79bd84f43430 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -471,7 +471,6 @@ static struct platform_driver xilinx_spi_driver = {
 	.remove = xilinx_spi_remove,
 	.driver = {
 		.name = XILINX_SPI_NAME,
-		.owner = THIS_MODULE,
 		.of_match_table = xilinx_spi_of_match,
 	},
 };
--
1.8.2.3


--=_mimegpg-monstr-desktop-18625-1407930760-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlPrUYgACgkQykllyylKDCFRzQCgne9m6yxs4LG4cEC2DS3ZWcfi
IhUAnjuBy2xO0ua8Sulx5DGr4on4fQqx
=U/cZ
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-18625-1407930760-0001--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
