From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: enable dma modes for transfers meeting
 certain conditions
Date: Mon, 11 May 2015 19:24:48 +0100
Message-ID: <20150511182448.GW3458@sirena.org.uk>
References: <1431290849-11151-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RCcFxJ34+mAtH0DM"
Cc: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431290849-11151-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--RCcFxJ34+mAtH0DM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2015 at 08:47:28PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> Conditions per spi_transfer are:
> * transfer.len >=3D 96 bytes (to avoid mapping overhead costs)
> * transfer.len < 65536 bytes (limitaion by spi-hw block - could get exten=
ded)

Applied, thanks.

--RCcFxJ34+mAtH0DM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUPPwAAoJECTWi3JdVIfQAc8H/1XZkzIRxpfhtxFJCtYTVOo8
+JzPaevm68LnD0j5wiaqzSeCGxzLSx1S11ggFw6sS5uHUg+ktplXO91cjk8dZaCM
fyUaLAy7xBi7yirdEp867TTwC6If0YFf1h3yWcHyt4jCovf37l4LPTQud6veS9bW
m1CIWSIWwgUqcOUwR4GUDUXq9V23rpaPAmuiF9dQ+MAVCK5aOeIpW6W8xNvmEOCL
JPuDX7VF78s1aXCAKVNH4Y4wFV8KrvFyE0m4tyYYroeoLBUKrjENo5t0HnVwl1zl
XP/dgk3TwY+be3RU+9AtKawq9wh9iYzkJ8AUrJpZmJq3KtBWJN5iJA7NxmhiXDQ=
=KvSp
-----END PGP SIGNATURE-----

--RCcFxJ34+mAtH0DM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
