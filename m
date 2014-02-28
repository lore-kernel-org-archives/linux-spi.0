From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: spi-imx: spi_imx_remove: do not disable disabled
 clocks
Date: Fri, 28 Feb 2014 15:15:21 +0900
Message-ID: <20140228061521.GE29849@sirena.org.uk>
References: <530EFE8E.5050303@freescale.com>
 <1393492575-32495-1-git-send-email-phdm@macqel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Philippe De Muyter <phdm-vQo90/bmh3WzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393492575-32495-1-git-send-email-phdm-vQo90/bmh3WzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2014 at 10:16:15AM +0100, Philippe De Muyter wrote:
> Currently, at module removal, one gets the following warnings:

Applied, thanks.

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTECl1AAoJELSic+t+oim94JkP/RpO527OZkyuG9IHsPIj4OEX
/8AcuYbtYh+Y3VKEzI428Q76lHdEwx66t3cYfgdjKl6LC0qECD1RFCeZA4O1+m6A
MGYKVsSfo1SqJSv6tQDxkCnGlDEE32VMze6ksjLebqXbTJbniAnu7oU1SxBzCHBp
nM+sEC0gOdMK7RAA/EL+jDCwEy+VU8ZFiwTwFzYOOWr/efyARFDuG9pfow1TJyJz
MlIIiRX//lw2iOGXqwwFUJdZ1gBkAkzS+4lUzadJEgv4jhr3LEVaETpSa5vfmJEw
m3uAUEXs1rC8zN09tp3GwjCSx7Gn8ZD2lnVka0FrI6J8aiyfkPEaXFhXE9wCeQI+
VUN4/nPpuu06C1R/GBgxMtDC1jKvdQgOsQd6Ywd7b6sY1J8wozG/w8ouRrLerzPs
AZdkPdEvhhXMDCxEDvTF1e3BaxSxanUqLI0kg5Y0FkcNgKjf1o0d3ATxwAUMSEek
WHTMsPxe64GtMb9SFHP0MrvzMRjl75qmbkf1C16ad0zG1ottpcq9EVNy7wFkL9Jh
GBjsuyj48JztauKOjidcvfxO3gFsWWNeTzuvbtvXFiIWRxJP7mbdv6vn2isWmT/H
/QXu52oOmQN/4cCeh5pTjvKjV6xx9A3v2Mu7V1pzsypzoVfIWBmON7z/ThdLoBwN
Q11zB4gsEe7Cs0T6ACtv
=VjXb
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
