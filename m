From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: ARM: pxa: build error in arch/arm/plat-pxa/ssp.c
Date: Tue, 1 Sep 2015 19:43:35 +0100
Message-ID: <20150901184335.GY5313@sirena.org.uk>
References: <1441073073.12012.3.camel@ingics.com>
 <55E54754.1060002@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kdyvsFMDMDKuFgXB"
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55E54754.1060002-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kdyvsFMDMDKuFgXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 01, 2015 at 09:36:04AM +0300, Jarkko Nikula wrote:

> No I'm pondering how to fix this. I see these bindings are added by the
> commit a6e56c28a178 ("ARM: pxa: ssp: add DT bindings") but some of the types
> are not used anywhere. For instance PXA168_SSP or PXA910_SSP. Then
> PXA3xx_SSP is used in sound/soc/pxa/pxa-ssp.c and CE4100_SSP in
> drivers/spi/spi-pxa2xx.c (where LPSS_SSP was used too before differentiating
> it).

IIRC the PXA168 and PXA910 are software compatible with the PXA3xx SPI
controller.  Those SoCs never got wide distribution compared to the
older PXA models I think.

> What I'm wondering is this binding below correct in arch/arm/plat-pxa/ssp.c?
> LPSS_SSP was meant to be for Intel Intel Low Power Subsystem SPI.

> "{ .compatible = "mrvl,lpss-ssp",	.data = (void *) LPSS_SSP }"

> Mika, Daniel: do you know is there any change there is a Marvell PXA
> platform compatible with Intel LPSS or is above binding bogus?

I bet it's just cut'n'paste because everything else about the driver and
all the DT is for Marvell stuff.

--kdyvsFMDMDKuFgXB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV5fHWAAoJECTWi3JdVIfQYOkH/AmAH3oOhDOhwuPLWEkhaoIn
fOehNsXaWIkZJAtRRjmb10vrITFRA1vYgk+7sSzR2NTLuaSRCqDtsVSpx6m6qTi+
NxuoPnAKpNYsUVT1PBTN+cepIaPIhKKKl9BEAp/V/aUviiQEOOZDUiWseaXlGVkm
OcGoMQTvlCErWujPJSpB+2ruP3edcfleV/MfC1IEtx8NwsBLJDSnm2ljIisM30qE
gRtHSIJZYdfm+raJ/CCp1h/H6uvDgd1oAYx+a7VFiC6qZrpBZp3DjnYQco2dV0+1
K5fow3jbmYXTIpzCrQ94X8PO6awjIJjyoh2Q+ws5+3841rLXV7YMOQpymvP3CTM=
=U/Ji
-----END PGP SIGNATURE-----

--kdyvsFMDMDKuFgXB--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
