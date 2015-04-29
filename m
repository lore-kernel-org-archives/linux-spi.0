From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Wed, 29 Apr 2015 11:47:37 +0100
Message-ID: <20150429104737.GC22845@sirena.org.uk>
References: <1430106270-17142-1-git-send-email-mwelling@ieee.org>
 <20150427195550.GE22845@sirena.org.uk>
 <20150428012150.GA12713@deathray>
 <20150428143425.GS22845@sirena.org.uk>
 <20150428230643.GC19294@deathray>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bLwrn1Kt3RWHCIGI"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150428230643.GC19294@deathray>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--bLwrn1Kt3RWHCIGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2015 at 06:06:43PM -0500, Michael Welling wrote:
> On Tue, Apr 28, 2015 at 03:34:25PM +0100, Mark Brown wrote:

> > > 	if (gpio_is_valid(spi->cs_gpio)) {
> > > 		if (cs_active)
> > > 			gpio_set_value(spi->cs_gpio, spi->mode & SPI_CS_HIGH);
> > > 		else
> > > 			gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
> > > 	}

> > That's good but please have braces around the inner if for clarity.

> I try to follow the CodingStyle documentation and it says differently:
> http://lxr.free-electrons.com/source/Documentation/CodingStyle#L156

That's for free standing if statements, the reason I'm asking for braces
at both levels here is that you've got a nested if - it's similar to
having braces on both branches of an if, being consistent within the
same statement.

> I have also been looking at ways of allowing more GPIO chipselects than
> DMA channels. Currently this driver is limited to one chipselect per
> DMA channel.

> Do you have any ideas on how to accomplish this?

Just use a single channel for the controller rather than allocating them
per device?  It's not like the controller is going to be able to
interact with multiple devics simultaneously.

--bLwrn1Kt3RWHCIGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQLbIAAoJECTWi3JdVIfQV9oH/jduCQg/fGoRjxpPJn3CNeCz
rsspL1kN8N3u/0FDhyM5EKu/ZIkAGAXuY8YwO5XafJIM67syZIgv28xnEMvXrnRu
7tcRk5ijOVgzZ4/pkof24RxxLLzzoLvvgLQTHgr1QFc5cF/zL5DnnI6U512Bfc2V
VgL2vRmXnETCDYXo1Lfx9T52RTvVw91SoBS1Ge3Jqama2151d8stXzBHX4UtLiOz
/mw5oD3g2toQaytrZwjd7lwsoWa6Cs2ocNbnpNPwYTxVK842WnnaeiHw8RjjCF/U
lrBsPsTtYVwo3yn9OA/zvJC3zB60may5hugGe4HDwQlX2hirktIbnV0Pudvx1Ro=
=yyaL
-----END PGP SIGNATURE-----

--bLwrn1Kt3RWHCIGI--
