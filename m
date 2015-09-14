From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: mediatek: fix wrong error return value on probe
Date: Mon, 14 Sep 2015 19:39:25 +0100
Message-ID: <20150914183925.GG12027@sirena.org.uk>
References: <1441320656-8666-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LtWARj4qtdVynAWs"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441320656-8666-1-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LtWARj4qtdVynAWs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2015 at 12:50:56AM +0200, Javier Martinez Canillas wrote:
> Commit adcbcfea15d62 ("spi: mediatek: fix spi clock usage error")
> added a new sel_clk but introduced bugs in the error paths since
> the wrong struct clk pointers are passed to PTR_ERR().

This doesn't apply against current code, please check and resend.

--LtWARj4qtdVynAWs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV9xRdAAoJECTWi3JdVIfQLRgH/ipV2zUmDs25fKLE4ye6VLy6
243cS/Z/IetZ5fsRvMUfJFrnV4vNRmjrigQwt46K4qojvPFIySmVWcuQm1rXgmrn
fihTRV9XeHnvd2Ho8FGvS7SK1LngYTNnvOSy27fQS0cIUhw3DZhMki5sQE20jIo/
CpP7BAeO41d49zkfxAdN8BwtLwr6aWF5LbNAdIqeESCOHvlbEYCG4/R9FzCPnPID
A0To4nxNgbUzwmEzROtUF3mCopcmW/awHLn+kA4SzI6OBx2Rx+n6ILz/yRjOwwHX
p2JrcPbD5FEpKPhNaJShai7FcnprqqC4iWMEbQBHGKTEG6KgngXnQOsXK8/59a8=
=GEC0
-----END PGP SIGNATURE-----

--LtWARj4qtdVynAWs--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
