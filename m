From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: Kconfig: Remove additional newline
Date: Fri, 16 Jan 2015 14:00:11 +0100
Message-ID: <05f726669457897c9d926e4c395ffaf08cd974f6.1421413208.git.michal.simek@xilinx.com>
Content-Type: multipart/signed;
    boundary="=_mimegpg-monstr-desktop-28812-1421413211-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-28812-1421413211-0001

Trivial fix.

Signed-off-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---

 drivers/spi/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 99829985c1a1..2350efe997ec 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -595,7 +595,6 @@ config SPI_XTENSA_XTFPGA
 	  16 bit words in SPI mode 0, automatically asserting CS on transfer
 	  start and deasserting on end.

-
 config SPI_NUC900
 	tristate "Nuvoton NUC900 series SPI"
 	depends on ARCH_W90X900
--
1.8.2.3


--=_mimegpg-monstr-desktop-28812-1421413211-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlS5C1sACgkQykllyylKDCHR4wCfV+MZQQ5ZnC2Lxd3nJnVM9jAv
NKYAnRKeEBnpREUenapyrMDouio0zw/P
=6ulS
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-28812-1421413211-0001--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
