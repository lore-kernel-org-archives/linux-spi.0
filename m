From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi:fsl-dspi:add support of DSPI IP in big endian
Date: Fri, 10 Jan 2014 12:40:14 +0000
Message-ID: <20140110124014.GI29039@sirena.org.uk>
References: <1389161655-21856-1-git-send-email-b44548@freescale.com>
 <20140109175208.GK12858@sirena.org.uk>
 <e9c8019df2cf4d76ae2b77c5d1420050@BL2PR03MB163.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LYw3s/afESlflPpp"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e9c8019df2cf4d76ae2b77c5d1420050-AZ66ij2kwaYw6E1ICcNxleO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LYw3s/afESlflPpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2014 at 08:11:33AM +0000, Chao Fu wrote:

> [Chao Fu] Our CPUs are working on only ARM architecture. But DSPI have tw=
o endianness=20
> In different series CPU, so we use __raw_read that do not take of endiann=
ess.
> We need observe ARM io methods  make sure avoid instructions executing re=
order .
> ARM IO methods :
> #define readb(c)                ({ u8  __v =3D readb_relaxed(c); __iormb(=
); __v; })
> #define readw(c)                ({ u16 __v =3D readw_relaxed(c); __iormb(=
); __v; })
> #define readl(c)                ({ u32 __v =3D readl_relaxed(c); __iormb(=
); __v; })
>=20
> #define writeb(v,c)             ({ __iowmb(); writeb_relaxed(v,c); })
> #define writew(v,c)             ({ __iowmb(); writew_relaxed(v,c); })
> #define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })
>=20
> So add barrier here. Could you give some suggestions? Many thanks!

OK that makes sense, please add comments explaining that this is due to
the endinaness translation.  Given that people are starting to use big
endian more it might be sensible to have these factored out into generic
code but that can wait.

--LYw3s/afESlflPpp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSz+orAAoJELSic+t+oim96dMQAI4MG2fi3ww1k11jbExr7Dv3
Dl1IdDastkkJfz3Q1K0AjjF0flbxs7mrCTUKgjWPwbE8dfzGrD1keR31FQOIgFBA
2iebtGpIQIILYPMUY3HNO3xYmU4lWnNNtUNW/RBzhdVu5+s1M3zdF1Cp5KWmyTMP
Mvt12XkMyRR1dpQ02GzZpN+KdLXaNaTYtMulpaZXfgBNzpHGUPwCsUeFQ1pSnNYN
jDpNfFS4tTq/gyV/yvYVE/h/T8Wik1aSjHnO4yfO6a/Q8ODMr+DNAnmPbJbmIkf6
Pi0eBuPICtQiJNeFnYj0HXzluyeS4SGOJNVeu+WEX6CBlb/wDd3NzfWl5lf01yHj
wwWkar4PY7jj8AcC5tJXWy3oFIvjgF5O5hQjBAymfxtwR8XoB/kJjpvBA9L+Ivzg
xbwKIAt+IeNWBN+HCFYe9OjCySTaz/ftPIBiV7mz9yfMx4T6SKs1gKccw+kZ+bUB
AIxr4oq9pccMRN0Gn8Av276HRvBdpJUta3iTQ+cixND7USSpBY5zoRFY6mnu5jQf
PBHL+3/kO9unem+KphsNw2zwg4N+4G2V+xEcvXY4PjFAcHKTGZmcHn6vmMWXLaUr
AymLyGdT0Y+162DfGDXsaIKVBAqZW+AlNNOo5Dz2xtik5Zveul/M9etoJH0E0kL/
nIjFwLUBxPTAdtCETWAq
=vn3X
-----END PGP SIGNATURE-----

--LYw3s/afESlflPpp--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
