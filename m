From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: do not fail if the CS line is not connected
Date: Sun, 26 Jun 2016 13:48:43 +0100
Message-ID: <20160626124843.GP28202@sirena.org.uk>
References: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
 <1466150245-2648-2-git-send-email-andi.shyti@samsung.com>
 <20160617104725.GC26099@sirena.org.uk>
 <20160617113622.GA10760@jack.zhora.eu>
 <20160617122803.GN26099@sirena.org.uk>
 <20160619060902.GB424@jack.zhora.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aNVUg3Xo9UgCa1D+"
Cc: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160619060902.GB424-A05emIGRluN/OPZsa/fw/Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--aNVUg3Xo9UgCa1D+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 19, 2016 at 03:09:02PM +0900, Andi Shyti wrote:

> > > This is true, but there are cases where the CS is not connected
> > > and this case needs to be treated separately to allow the device
> > > to work.

> > In what way?  It is just as easy for a device with no physical chip
> > select to have a logical chip select of 0 that it does nothing with as
> > it is for that device to handle any other number.

> That is indeed my case: the s3c64xx doesn't send anything, unless
> I manually enable CS (from the next patches I need to write '0'
> in the CS register). But I need smoething to tell to the
> device that the CS line is not connected, for example a flag in
> the DTS.

I'm sorry but I just don't understand what you're saying here.  You are
saying that there is no chip select but you need to enable the chip
select?

--aNVUg3Xo9UgCa1D+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXb88qAAoJECTWi3JdVIfQWFQH/icyIM42/qc2kgo9DfxAZC4O
3tSyGU2AzS4HjmfK/v3Pozo2N1q64zN0rUHvRtwYOXypbGTP5mGxykbQ1P/Iw+ap
LmQeqbEOB/ZNoIRBWk9ZmE/XRHN9vltqnHCcU6cUZb6Zx1MDxlZtgcwGst/mJnJE
89JEqViAHAO4CvrRYoo1KtRFOB0wtixfORBqVZ2hHAjTYBBAH72AWDfj+2mtjW6L
TLKNVqG+4Ol08Q7M/Ku+pYk4UyqENSN1Vxq3v1OJlvDoHrxSkE/mjHEV5iv/QVHN
LiP49EwhZlK/Tg95EnX0jfXefeA/0xNDE4pIRzjdkxuRWapadV0DXuVmnpkFVCE=
=tFZG
-----END PGP SIGNATURE-----

--aNVUg3Xo9UgCa1D+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
