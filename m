From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-pxa2xx: Constify ACPI device ids
Date: Mon, 15 Jun 2015 20:14:58 +0100
Message-ID: <20150615191458.GC18309@sirena.org.uk>
References: <1434198134-8278-1-git-send-email-minipli@googlemail.com>
 <20150615095344.GE18309@sirena.org.uk>
 <CA+rthh8WEzdY0vxV-oQ7xTUCtqbhJkTUeym9VNPU+Xm6a7T=YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k/A+UfywgnnvevLW"
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
To: Mathias Krause <minipli-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+rthh8WEzdY0vxV-oQ7xTUCtqbhJkTUeym9VNPU+Xm6a7T=YA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--k/A+UfywgnnvevLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2015 at 07:47:37PM +0200, Mathias Krause wrote:

> Was that wrong? Who else should I've send the patch to? Maybe they
> should be added to the MAINTAINERS file?

I'd have expected at least Jarkko (who's been actively working on the
ACPI stuff for this driver) - in general MAINTAINERS is a bit
unreliable, you should probably glance at git log.

> Rafael and Len are on Cc because of [1] -- an effort to constify all
> users of struct acpi_device_id. They're on Cc because of the ACPI
> relation. I hope that clears it up.

Consider if every single patch adding a const to an ACPI ID list really
needs to go to the ACPI maintainers (I know I get a lot of really odd
stuff registering SPI devices).

> I was uncertain how to group those changes but tried to split them up
> per-system. So you're seeing only the patches where you are mentioned
> as a maintainer. I thought it would be less noise this way for the
> non-ACPI related patches. It's a simple patch, after all.

That bit is fine.

--k/A+UfywgnnvevLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfyQxAAoJECTWi3JdVIfQt4EIAIXQ0MTGp5Ksg8lUeFnqRjzp
5ty9gatwMRNdyEggBjiEzDttH1zDM+Q5WuoJ81kkpNaxLxEcr6eOR0RH4ne2uGxP
PrdkTc/L5UVMq0QBuxsCBIHlhDCMy49E6hIWkI1n4yBPeVpml/g5VCqeqjXZOgkd
ftouc3X9Dt6+ZACx1Vue8GMA0abVAIQp9xSAg/m7XkuxjYJu5/n+x3S13PaV5PRa
IbgLHthUjKEcHcbLkuV8AyyIKJTCiVzHXI0qVSHm6lrB4jRbiU3GjAznqYaQAbGm
sUYMMIdoqkA4qbFfC3huBjU+ebx3BTWhOlYWajIkI8XQsWJD02ji1zfMyMgyzTY=
=Re0k
-----END PGP SIGNATURE-----

--k/A+UfywgnnvevLW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
