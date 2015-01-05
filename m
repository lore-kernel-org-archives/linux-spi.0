From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sirf: drop redundant sirf,marco-spi compatible
 string
Date: Mon, 5 Jan 2015 21:27:50 +0000
Message-ID: <20150105212750.GS2634@sirena.org.uk>
References: <1420275884-10942-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TOcFo/l1T3s1H/TJ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420275884-10942-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--TOcFo/l1T3s1H/TJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 03, 2015 at 05:04:44PM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
>=20
> "sirf,marco-spi" is redundant as all SPI controllers in CSR SiRFSoC are
> compatible with prima2-spi.
> at the same time, the whole marco project was dropped and its replacement
> atlas7 is also compatible with prima2 in SPI.

I don't see any pressing reason to do this (the cost is basically zero)
and the compatible string seems to be used in a DTSI file, though
perhaps that's going away?

I'd also say that the binding document update is missing but it seems
this binding is undocumented.  :/

--TOcFo/l1T3s1H/TJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqwHVAAoJECTWi3JdVIfQuCwH/07iA5h7aBG5/3e07eC3bwia
Sakf9c+///F+eFR7VcjQkDnTweB9tohB2+uZPZD3fPk+d2jnxGSbNTShiq+e++Zw
KMpnom6OblEqT4sLDcGdu6+UhqkS0QSE1sFnVyUyGQasAxEb9zgj4mHdRr5DTLbP
kgWwUuoEfA+STLBoaxAwTVbDxBNefT1DBNlmJglgUdH0Ymg/Mt8vrucnose8xnSA
llWVqsHXYYDSrfyebKpTTS9euOvh51EUk9IsJmoExU6bVn+0WEQUnrBdghWcmrOV
YBPfw9Je7i85yxsq0yneWCl9frNF+bK+1JxJZi1onYJh8bEZJBqBH98665w1GYA=
=FYZM
-----END PGP SIGNATURE-----

--TOcFo/l1T3s1H/TJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
