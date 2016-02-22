From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1] spi: master driver to enable RTC on ICPDAS LP-8841
Date: Mon, 22 Feb 2016 12:10:27 +0900
Message-ID: <20160222031027.GP18327@sirena.org.uk>
References: <1456105630-28914-1-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DCmRZ841GpRfzaEr"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456105630-28914-1-git-send-email-ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DCmRZ841GpRfzaEr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 22, 2016 at 04:47:06AM +0300, Sergei Ianovich wrote:
> ICP DAS LP-8841 contains a DS-1302 RTC. This driver provides an SPI
> master which makes the RTC usable. The driver is not supposed to work
> with anything else.

So this is something that is internal to a single chip or something?
I'm slightly unclear from the above if this is or is not a SPI
controller.  If it isn't generic the DT should probably just describe
the IP and let the driver create the SPI controller and device if that
is an expedient way of doing things.

> +spi0@901c {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	compatible = "icpdas,spi-lp8841-rtc";
> +	reg = <0x901c 0x1>;
> +
> +	rtc@0 {
> +		compatible = "maxim,rtc-ds1302";
> +		reg = <0>;
> +		spi-max-frequency = <500000>;
> +		spi-3wire;
> +		spi-lsb-first;
> +		spi-cs-high;
> +	};
> +};

This example makes it seem like an actual SPI controller but just one
that's broken/limited?

> +config SPI_LP8841_RTC
> +	tristate "ICP DAS LP-8841 SPI Controller for RTC"
> +	depends on OF && (MACH_PXA27X_DT || COMPILE_TEST)

Does this need a strict DT dependency or can it build without DT?

> +/*
> + * REVISIT If there is support for SPI_3WIRE and SPI_LSB_FIRST in SPI
> + * GPIO driver, this SPI driver can be replaced by a simple GPIO driver
> + * providing 3 GPIO pins.
> + */

What's the advantage of not doing that?  Overall the driver looks fairly
good but it does seem to just implement a straight bitbanging driver
with less flexibility.

> +#ifndef DRIVER_NAME
> +#define DRIVER_NAME	"spi_lp8841_rtc"
> +#endif

If you want to use a define for this just use a define for it, don't do
this ifdef stuff.

> +static inline void
> +spidelay(unsigned usec)
> +{
> +	usleep_range(usec, usec + 1);
> +}

Just use usleep_range() directly.

> +static void
> +spi_lp8841_rtc_cleanup(struct spi_device *spi)
> +{
> +}

Remove empty functions, if they can be empty the core will support
ignoring them if they are missing.

--DCmRZ841GpRfzaEr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWynwjAAoJECTWi3JdVIfQ/5EH/RQ6i6ue8QI+XXSMHzFf1e4f
QdXnzQqD9GD8NnLv7gs+nilD72V2MsTpRcLUVO9O2omZpm9CpUCX0uwEB5xMnDLR
7KGEfAi7OlUdM5doPdN1ox4Dq38uwSuEAh2b9DraZ2hyM8t3BNL480EwoyX6Fdmw
5ZmAPBfXD2+gD6YL0iU5ss+1LAtfRYYLG1EZNJyvAzWp5OcNgS8p/6+9FSaIk6wE
ft7Bw2hLisNNlLQoG/y+pjEIAMpIYhbJj2+y64gqz8FMpERIEL/0DirEA9N4QDQC
nignG3cYmF/LhUbCmTPdDIiPzaEiAwZ53iYGDAHYxLYILMd53j1Is+fglsRrSxA=
=B17D
-----END PGP SIGNATURE-----

--DCmRZ841GpRfzaEr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
