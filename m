From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: sh-msiof: Configure MSIOF sync signal timing in
 device tree
Date: Wed, 24 Dec 2014 12:31:28 +0000
Message-ID: <20141224123128.GX17800@sirena.org.uk>
References: <5493DEB9.1080906@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YIbTR3mqhHpBjtK1"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org,
	Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5493DEB9.1080906-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--YIbTR3mqhHpBjtK1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 19, 2014 at 05:15:53PM +0900, Yoshihiro Shimoda wrote:
> The MSIOF controller has DTDL and SYNCDL in SITMDR1 register. So,
> this patch adds new properties like the following commit:
>   d0fb47a5237d8b9576113568bacfd27892308b62
>   (spi: fsl-espi: Configure FSL eSPI CSBEF and CSAFT)

Applied, thanks.

--YIbTR3mqhHpBjtK1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmrIfAAoJECTWi3JdVIfQCK0H/jn56k1JgpRke5m++TfJAtz1
fS1r8ODeIfaa3pr7AgZRV96VGTi/g+4UFGCCLu+IYyaj3jxW9TImIzBdlc2SJXRC
lrLycvxAJN85mZdZnsdFvLUWmdJfqVSKG7nuZaFJvl82t+MjAh38XPivF1hWBeBZ
gDyNRs9p9UJfQQ7rVJ6OJvNCs3m7vZ6FXx9oqWW1MfJ4DoU9AqGxygGOk8Sbjuwr
3J6Qn8fmmCUcZjqCqWmyoVaufbGQSaVkp1Vp4d1lhlZ/1dzqvV5hK0j642npKi+M
ti8kyL2gk6S8UQkTyXhNGOHXMWqj8nC8h/AA64gwdzRz5c4R5nthfY26l785nLo=
=K/R7
-----END PGP SIGNATURE-----

--YIbTR3mqhHpBjtK1--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
