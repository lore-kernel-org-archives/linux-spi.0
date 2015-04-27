From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sirf: replace BUG condition by error code for
 unsupported transfer
Date: Mon, 27 Apr 2015 20:53:39 +0100
Message-ID: <20150427195339.GD22845@sirena.org.uk>
References: <1430126548-8171-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fSNrgljvV+ZO20YT"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430126548-8171-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fSNrgljvV+ZO20YT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2015 at 09:22:28AM +0000, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> return error for unsupported bits-per-word format, BUG() is not right
> for this scenerios as we are not an ASSERT but an error handler.

Applied, thanks.

--fSNrgljvV+ZO20YT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPpPCAAoJECTWi3JdVIfQqyIIAIGZS1v05CB5vDxpHw+hsVuN
L60n1BSkkhK6m9/BjQtTrSGruCqw2il4+KAW7kLRwhhNKhnU915ifhYgW6SU5wib
Qr8KzkS6UMxPzfpbvyAiyE1mfwn/swHMp8WPyA4e29vyKLanYWl3u/LDz+rRGfR0
wASvuz5X6UvS9UI3PhItsBjCGPbZuxFP0K95FIXsHYDDqDpu3LzSguTeTJ+1Da28
IhUJNTLLtMg+3S0+IJGxxsALTT4W0Cqk3/9jgZHo0e/rHMF4d3JqZt096ioyhjKZ
2pAocvhuRIAV5f8hBcpmYZMeAaODlOEirGd8uYjBoEqCF4UbqlmCU8jK63r6Vvc=
=Xzpr
-----END PGP SIGNATURE-----

--fSNrgljvV+ZO20YT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
