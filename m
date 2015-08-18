From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: mediatek: fix spi incorrect endian usage and remove
 redundant clock
Date: Tue, 18 Aug 2015 09:07:49 -0700
Message-ID: <20150818160749.GJ10748@sirena.org.uk>
References: <1439895231-17778-1-git-send-email-leilk.liu@mediatek.com>
 <CAOiHx=nBOtm3c7QQpA-SSxXzJGjUEJQBtR9CynoeqsXRoz4fRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vRyMahX6VF+pdQvX"
Cc: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOiHx=nBOtm3c7QQpA-SSxXzJGjUEJQBtR9CynoeqsXRoz4fRg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vRyMahX6VF+pdQvX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2015 at 02:19:54PM +0200, Jonas Gorski wrote:

> The usual philosophy is to have one change per patch, so this might be
> better as three patches. But this is Mark's call. Since the driver
> isn't yet in Linus' tree, it might be a-ok to mix style improvements
> and actual fixes, but as soon as it landed in Linus' tree you need to
> keep them separate, so fixes can be easily backported.

This isn't just about making the fixes easy to backport, it's also about
making the patch reviewable and understandable.  When many changes are
included in one patch it makes it harder to tell what any one part of
the patch is intended to do.  As Jonas has identified several bugs
you'll need to resend anyway, please split the series up.

--vRyMahX6VF+pdQvX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV01hRAAoJECTWi3JdVIfQz6cH/3DNlew2DvZ1/HnluOiIknH0
ivLgO+u6Dkj7OaYiR/pbG1fFiElH/C+iVV7aveAfaZPnhXZhipoPYnt6JXS8G5v9
Df1oDua6shcoiC+KooEaZ9FnWHCDjQxiZCILYhP+ROVXogsQ0kSOMFLBFYVgEf2N
e+ReqHuG5kncZ4l5U/ClnSbjaEPJXg/0+g2ZU5VSM/Rm2MWA62yvF5CaLgm5jVCQ
MfhIU+mnqRAc/TYV4CRysPO1KY9gdSTVMpePxnXq+XXZ1sGiVeL3TM40YPSiJFGu
5m9yMnd2Nn0DV5Ij6VsuyVFfqHElgmiPKsjftvmukyejAuVPywFJTdRU0k8XCHQ=
=iN/G
-----END PGP SIGNATURE-----

--vRyMahX6VF+pdQvX--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
