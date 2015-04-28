From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Tue, 28 Apr 2015 15:34:25 +0100
Message-ID: <20150428143425.GS22845@sirena.org.uk>
References: <1430106270-17142-1-git-send-email-mwelling@ieee.org>
 <20150427195550.GE22845@sirena.org.uk>
 <20150428012150.GA12713@deathray>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kfq9UAITgQ0kfvUo"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150428012150.GA12713@deathray>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--kfq9UAITgQ0kfvUo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2015 at 08:21:50PM -0500, Michael Welling wrote:

> Before I send another patch how does this look?

> 	if (gpio_is_valid(spi->cs_gpio)) {
> 		if (cs_active)
> 			gpio_set_value(spi->cs_gpio, spi->mode & SPI_CS_HIGH);
> 		else
> 			gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
> 	}

That's good but please have braces around the inner if for clarity.

> If I were to attempt to convert the driver to use the core chipselect support,
> how would I go about doing it?

> Is there another driver that I can use for reference?

Martin and Ezequiel already gave you some good examples - in general
anything providing the set_cs() operation should be reasonable to look
at.

--kfq9UAITgQ0kfvUo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVP5pwAAoJECTWi3JdVIfQQ5wH/0e1RfYxlhIHy4u044LNh2d2
qFjXU05h0eAtztRcdJZpSORgdBX1HeJoxHCOY7VIaG/2c4/od3H9KXwuBZR0qOBq
XTwD7gmZoWudFuGHRGSJ7VGp6qWf6+oEnBr6eY6ngJVUMHUl5ky6ytmqUwsVjfGp
RgZQv+0iLS9CwJFx9RJgL5wXh3B45qjkITzi9mxdmGxndO38nhRNT3idA/iU3hqO
viXlg3BoKzapuwbWAdS1s46z0ego41xIz7e/N9MbHW+hexAWWgScImcT4R8u53nq
MGT7qCG0bQvsg7io39IOt9kDCuJpiS5nns1rtcMphvm01qnzET7iKXBsCEciBYE=
=k7IH
-----END PGP SIGNATURE-----

--kfq9UAITgQ0kfvUo--
