From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: sirf: request and free cs gpio in setup and
 cleanup callbacks
Date: Wed, 6 May 2015 19:47:58 +0100
Message-ID: <20150506184758.GG22845@sirena.org.uk>
References: <1430649012-1694-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zuNCxxYM0q4b3w2t"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, swingboard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430649012-1694-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--zuNCxxYM0q4b3w2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 03, 2015 at 10:30:12AM +0000, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> move spi controller's gpio request work out from probe() to spi device
> register stage, so after spi device register spi controller can deactive
> device's gpio chipselect. old code can't do it because gpio request has
> not be done until device register is finised in spi_bitbang_start.
> and add cleanup function to free CS gpio.

Applied, thanks.

--zuNCxxYM0q4b3w2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSmHeAAoJECTWi3JdVIfQyxgH/2Vymqxlueg8yqhfOomZiOcB
s2Dv/k5Bfz13LguYf7cJVQwpPyqvTSoO5aqxd6eJ3UB3b6tKLTa0xmIjkIdlVybf
7VTFNPLjrksje4TfHZOs+y2sfGrP+XNhr3NUVtmA6lFO/zfqDFRibTOdDvgl/CPC
mWaj/Fr3kjvXMCJY2M5l4POj7foYELjnlaa6AL3pFTEOFWjqnT1CA1Fv/Zm2V0zE
jNGMDonDPFFa9z4rs3NdLORaK2t4hNH1NEipDSq034CgWcGjlnA0bcQIFHvHUc7B
tqpXN3N9BbzN6qQZ5V5tIvZVfH3slqxRJF4xJDtOeuCDCKSLKnh1kow0gkn5x20=
=9mNk
-----END PGP SIGNATURE-----

--zuNCxxYM0q4b3w2t--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
