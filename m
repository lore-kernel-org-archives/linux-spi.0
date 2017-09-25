From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 -next] spi: fix spi-sprd-adi build errors when
 SPI_SPRD_ADI=y and HWSPINLOCK=m
Date: Mon, 25 Sep 2017 10:36:51 -0700
Message-ID: <20170925173651.zyof5olbas52wb2q@sirena.org.uk>
References: <ed5b8ca2-b853-755d-2801-57cc0b626508@infradead.org>
 <20170922092621.uq2xsvxangeetewi@sirena.org.uk>
 <9dc8b064-8a6c-98d2-4ade-088cbfd56fb1@infradead.org>
 <20170925161221.v23dpeljin5kakhz@sirena.org.uk>
 <449abd0e-8d8b-86e9-2b7a-65c27ab3171b@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dyhvwc3orh5yxhuk"
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <449abd0e-8d8b-86e9-2b7a-65c27ab3171b-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dyhvwc3orh5yxhuk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 25, 2017 at 10:19:56AM -0700, Randy Dunlap wrote:
> On 09/25/17 09:12, Mark Brown wrote:

> > Why is that not just an || COMPILE_TEST dependency then?  The dependency
> > you're trying to introduce is weird and confusing, we shouldn't be
> > having to do things like that.

> It already uses COMPILE_TEST:

> config SPI_SPRD_ADI
> 	tristate "Spreadtrum ADI controller"
> 	depends on ARCH_SPRD || COMPILE_TEST
> 	help
> 	  ADI driver based on SPI for Spreadtrum SoCs.

> but that allows build errors when SPI_SPRD_ADI=y and HWSPINLOCK=y.

> As for the dependency that I am adding:
> +	depends on HWSPINLOCK || HWSPINLOCK=n

> that idiom is used over and over again in Kconfig files to prevent this kind of
> build problem in loadable modules.

And what is that equivalent to in relation to COMPILE_TEST, especially
considering the situations where you'd build this without hwspinlock
support?

--dyhvwc3orh5yxhuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnJPrIACgkQJNaLcl1U
h9B2Rwf7B3oriTjML9g9fjOFZ6kmfUmXDyLqT+l5Ux6BcNvgUBB9dXV98bqamKvZ
nbE46B6l3kEu/AehCVoNXh9C+/jJdVWnrPpWIzTCENrFGsgjBuUV17d0e6JGqHyX
OLdNayC6k0N31AG34R155ay+hV932T1dIE6B+fo6EEqJZC+g5/hsYQqBfoICDczi
KfBOodsJdu7xBpElTzT+u1M8NO0QdSNHgiAweULPXOs//U8JlBA1+ftmWEaD1AzO
/tZ46JnADd9Ve2HTbekijNOmoeELMOfsWnXWI89DWS+8TclesESaG49vgpShzuq0
AXCKswU+UskBCFqUDyWGWUyJLpmi+w==
=z6Rm
-----END PGP SIGNATURE-----

--dyhvwc3orh5yxhuk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
