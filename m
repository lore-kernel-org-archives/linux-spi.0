From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: fsl-espi: add runtime PM
Date: Tue, 25 Aug 2015 18:45:49 +0100
Message-ID: <20150825174549.GG12878@sirena.org.uk>
References: <55D9BB0D.7080604@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B8ONY/mu/bqBak9m"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55D9BB0D.7080604-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--B8ONY/mu/bqBak9m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 23, 2015 at 02:22:37PM +0200, Heiner Kallweit wrote:
> Add runtime PM and use autosuspend instead of suspending the
> SPI controller after each transfer.

This looks OK.

--B8ONY/mu/bqBak9m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3KnMAAoJECTWi3JdVIfQg9kH/RBBA+7ANxUdoK5C5NNtgdHn
z1wCc2iJLkInrr3e7xQkZeq0ixcjeJ5zb8Be41u3DfKAQ2qjtM1afjRomrhNqB/P
smc0VBqft0sp1/zms0WNJV4TBvKqeBw1aOSqpAxvMBcZWmYy16yVhgPoZEO2UXK4
ZE9nBPQxZCaiNrwxG/R+BJB8wfmeZ8WHw+kNjalwZ/k6sT1PvI58h3ZQPLuD1mPz
RyqFbpjyzn7x78Apvmr+hEsaYdcT6+WCWOSPfog3yitkg8Yo8KtTBM1uQT856H4D
VHzcnAEw+V0JU6xVRSITA5bls4xNawC7VhAKBUgO9mPrSLcK6kGrATzu4nQGIbw=
=DPOj
-----END PGP SIGNATURE-----

--B8ONY/mu/bqBak9m--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
