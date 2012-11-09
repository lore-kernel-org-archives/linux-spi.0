From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 3/6] ASoC: wm8974: include MCLKDIV in pll_factors
Date: Fri, 9 Nov 2012 14:55:15 +0000
Message-ID: <20121109145515.GH23807@opensource.wolfsonmicro.com>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352469625-32024-4-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7892590995285272007=="
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1352469625-32024-4-git-send-email-s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--===============7892590995285272007==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zq44+AAfm4giZpo5"
Content-Disposition: inline


--zq44+AAfm4giZpo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 09, 2012 at 03:00:22PM +0100, Steffen Trumtrar wrote:

> To calculate the integer part of the frequency ratio, the whole output
> path has to be considered (post and pre are optional):

> 	    Ndiv = (pre * target * 4 * post) / source

> In the current implementation only the fixed- and pre-divider is
> considered, but the post-divider is omitted.
> To calculate Ndiv, this post divider has to be applied before any
> calculation happens. Otherwise Ndiv is considered to be to low in the
> later stages. This leads to a wrong value in the PLLN register, which
> in turn produces a wrong playback speed of the audio signal.

This changelog doesn't mention where you're using MCLKDIV here but it
does rather sound like the PLL configuration is not being done correctly
here.  The expectation is that when the PLL is configured the raw output
frequency from the PLL is specified.  The PLL is then specified as the
system clock with that rate and then any division required to make that
usable happens afterwards.

> +	case WM8974_MCLKDIV_1:
> +				reg = 1;
> +				break;

Please do follow the Linux coding style for kernel code.

--zq44+AAfm4giZpo5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnRlMAAoJELSic+t+oim9Xy0P/R0wwpx5mTMF17c8cubVionP
1O609p/9T6aNH6HWj0XjZ/pw9sESF1LhcOKPUPE8MZKxIiaJLVC/wGj7OcobIjHg
9qiRlz3oRVzXa3VjwgZ4ci6YCnpT/hecgMK4xsRUq6L79rwLsro+Xu/VX7q/xE6M
88Igw4fmg7V8qmqMPGn6VF+DirfybJkT8WA2ugkmpToz/sOyefiU94ZcuoPYEzTy
a9iBdasV7kvWVt0BNpQNyWQegKsxeNne3kHoeAbK7eBFwZ0qGnnqf99/Z5UiS8vR
8Uxv9cnm2/Ppf6pY+J2OHCVopC5JN703nJ8hJXFZiM9calt/zmzmtQQ6Yyw4LNOI
wa7pPFjfTCYIOzhpL4/3hEYqoOUkxtcvQ0Wd4GB9aEfY3CGrg9DU6mPJQK7XBWm2
sFab8DpsM1pvbbPG1mBHa61tvRtDar0q3DalSkti3rXmXIbfuBKZFpcrO6ev/n5U
dfX6Jk8JG/EAsPgR4+8vZOA4N1Q2poVxW4wcSxPcA9ge4jz3gr9GQzM8weGIvqz/
C16gmHRdfFT4t8MDInUPYIECcneaiAcSvvSsAw53w4UM7Og1F+otv2BS8jkpr9aY
dDquZFJ4pUwCvJOu/RKdmP+Jrn6HWnr7CzbSSK0BkzzWUZMEoAcNdjoQGCZAI09x
malQDO7j/fQxRpSpk4fo
=PJv8
-----END PGP SIGNATURE-----

--zq44+AAfm4giZpo5--

--===============7892590995285272007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7892590995285272007==--
