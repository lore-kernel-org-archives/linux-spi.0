From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Move eeprom drivers to drivers/misc/eeprom
Date: Tue, 27 Jan 2009 10:53:26 +0100
Message-ID: <20090127095326.GA8385@pengutronix.de>
References: <1232446982-7842-1-git-send-email-w.sang@pengutronix.de> <200901262355.27913.david-b@pacbell.net> <20090127090442.35190667@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	rt2400-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090127090442.35190667-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2009 at 09:04:42AM +0100, Jean Delvare wrote:

> >=20
> > Now that thhis is in mainline ... I suggest two more changes:
> >=20
> >  - at24 (i2c eeprom) doesn't need to be EXPERIMENTAL
> >=20
> >  - we still need interfaces whereby kernel code can be
> >    given handles to the EEPROM devices, and then use
> >    them to read board config data out during boot.
> >=20
> > Obviously, the first one is easy.  ;)
>=20
> Indeed, but where's the patch?

I may be missing some irony here, but just in case I don't, here is a
patch :)

=3D=3D=3D

=46rom 622e104ea7c0ee99c631701919289792c8a890a4 Mon Sep 17 00:00:00 2001
=46rom: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date: Tue, 27 Jan 2009 10:46:11 +0100
Subject: [PATCH] at24: remove EXPERIMENTAL

This driver has been widely used since inclusion and no problems have
been reported.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/misc/eeprom/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index c76df8c..89fec05 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -2,7 +2,7 @@ menu "EEPROM support"
=20
 config EEPROM_AT24
 	tristate "I2C EEPROMs from most vendors"
-	depends on I2C && SYSFS && EXPERIMENTAL
+	depends on I2C && SYSFS
 	help
 	  Enable this driver to get read/write support to most I2C EEPROMs,
 	  after you configure the driver to know about each EEPROM on

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl+2ZYACgkQD27XaX1/VRtpOwCfXIFwJ49p9RxJqeWxXnxvnZ78
rR4An0qOX8nDRLJ7y4Mz+sAgxJdAGuZV
=NCa0
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
