From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Add Cadence XSPI driver
Date: Thu, 20 Feb 2020 11:40:49 +0000
Message-ID: <20200220114048.GA3926@sirena.org.uk>
References: <20200128124212.12298-1-konrad@cadence.com>
 <20200210191620.GE14166@sirena.org.uk>
 <20200220082354.GA15619@global.cadence.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Konrad Kociolek <konrad-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200220082354.GA15619-3ZcXq++oLud4Zxsjz0bX7NBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 09:23:56AM +0100, Konrad Kociolek wrote:
> The 02/10/2020 19:16, Mark Brown wrote:

> > >  # Add new SPI master controllers in alphabetical order above this line

> > Please keep Kconfig and Makefile alphabetically sorted as the comment in
> > the context from the diff says.  :/

> What I see is Kconfig is first and Makefile is second file in diff,
> according to:
>  drivers/spi/Kconfig            |  11 +
>  drivers/spi/Makefile           |   1 +
> Is that wrong?

Please keep the *contents* of the files Kconfig and Makefile
alphabetically sorted as the comment in the context from the diff says.

> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id cdns_xspi_of_match[] = {
> > > +	{
> > > +		.compatible = "cdns,xspi-nor-fpga",
> > > +	},

> > Why -fpga?

> This is because this driver was tested only on FPGA board.
> This driver was not tested for ASIC version as PHY
> initialization algorithm is differ.

So there will need to be a separate compatible for any silicon
integrations?  Will that always be the same for all silicon integrations
or should we have properties for the PHY type?

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5OcD4ACgkQJNaLcl1U
h9DjWwf+Kw59oWOq88WN/+Io2xu9qfSpF63ViQuy5f1M3hFbAlGWYEyUoHWkucac
8fPxVqV+5XC3FtIABoU6DYGYoTLnXul0Q6aPE0RCmCPxiRUHl8h6ZNOgNT6WeKXV
TcETE1T7JepwhjT+FL2Lu/ydw4whC1m+CJ6H7grD7gHLktS0Ks64Wi2279R9COwq
chvI0lHmjsrcnsnqUVngI+ZFRbuF4rKIlzzehUuyOcNEEu64+ZW4NgzC99VbyWpp
GDUMIg3UEcWIAjylC8gwLVHFp/SuX/NK5Odp41Fc4079kxhBz1sgYKn5ty8YyRYc
YhOuT0n1aVA03Ph5WddcvDF5P9gIjQ==
=RQrs
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
