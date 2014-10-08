From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2] arm: dts: socfpga: Add SPI nodes to SOCFPGA DT.
Date: Wed, 8 Oct 2014 21:05:15 +0100
Message-ID: <20141008200515.GK4609@sirena.org.uk>
References: <1412796428-3255-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QSIxHKMNNe9U+x7e"
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org,
	baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412796428-3255-1-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QSIxHKMNNe9U+x7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2014 at 02:27:08PM -0500, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:

> +			spidev@0 {
> +				compatible = "spidev";
> +				reg = <0>;	/* chip select */
> +				spi-max-frequency = <100000000>;
> +			};

No, if you're putting spidev into the DT that's broken - describe the
hardware, not the software you're using to control it.

--QSIxHKMNNe9U+x7e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNZj6AAoJECTWi3JdVIfQIegH+wVVSusgfUH6dIdrCNCcqe8n
IESgKRjvAcro2UgVTWsG2qfPZrsIydgLWlLDt+GNQm2N864trm96i65ZVYodYyYP
cmJVjEjxdeM5fS5xZXr/QWq9NQmkdWQQxmMMdvicEhvsxP8AWv1h/bqL4xw7UMUZ
Z8tqF0rbIORAuSLgunuYWuDbSx7om17KJHzKMsNOrfX4EHURD6QUn3RqSU74wDZT
UBdsPQx9UQa8JUxB/B7FY+qPqVl9BVbHQxjog4S/NKt0XAUB6xV982FwW1iTsXio
abpCakwEo3hKBGSrwldvbywDrNOI5L3qn9/q/kSY4rXmKEzv9VUUsuP21MHcJFE=
=8aou
-----END PGP SIGNATURE-----

--QSIxHKMNNe9U+x7e--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
