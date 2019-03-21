From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: mt7621: Move SPI driver out of staging
Date: Thu, 21 Mar 2019 14:25:50 +0000
Message-ID: <20190321142550.GG5684@sirena.org.uk>
References: <20190314115212.2396-1-sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8921921268894567749=="
Cc: devel@driverdev.osuosl.org, Rob Herring <robh@kernel.org>,
 Sankalp Negi <sankalpnegi2310@gmail.com>, John Crispin <john@phrozen.org>,
 linux-spi@vger.kernel.org, Armando Miraglia <arma2ff0@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, NeilBrown <neil@brown.name>
To: Stefan Roese <sr@denx.de>
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20190314115212.2396-1-sr@denx.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Id: linux-spi.vger.kernel.org


--===============8921921268894567749==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WkfBGePaEyrk4zXB"
Content-Disposition: inline


--WkfBGePaEyrk4zXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2019 at 12:52:12PM +0100, Stefan Roese wrote:

This looks pretty good, a few trivial issues below but nothing major I
think.

> +config SPI_MT7621
> +	tristate "MediaTek MT7621 SPI Controller"
> +	depends on RALINK
> +	help
> +	  This selects a driver for the MediaTek MT7621 SPI Controller.
> +

I'm not seeing any build time dependency on this, please add an ||
COMPILE_TEST to help with build testing.

> @@ -0,0 +1,422 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * spi-mt7621.c -- MediaTek MT7621 SPI controller driver
> + *

Please make the entire comment a C++ one to=20

> + * Some parts are based on spi-orion.c:
> + *   Author: Shadi Ammouri <shadi@marvell.com>
> + *   Copyright (C) 2007-2008 Marvell Ltd.

That driver dates from 2008 AFAICT, and had some changes after then?

> +static void mt7621_spi_set_cs(struct spi_device *spi, int enable)
> +{
> +	struct mt7621_spi *rs =3D spidev_to_mt7621_spi(spi);
> +	int cs =3D spi->chip_select;
> +	u32 polar =3D 0;
> +
> +	mt7621_spi_reset(rs);
> +	if (enable)
> +		polar =3D BIT(cs);
> +	mt7621_spi_write(rs, MT7621_SPI_POLAR, polar);
> +}

Will doing a reset mess up the rate configuration and stuff that's done
in _prepare(), or is _reset() perhaps not an entirely accurate name?

> +	list_for_each_entry(t, &m->transfers, transfer_list)
> +		if (t->speed_hz < speed)
> +			speed =3D t->speed_hz;

This should be in the core if it's needed, it's going to be the same for
all drivers.

> +	master->setup =3D mt7621_spi_setup;
> +	master->transfer_one_message =3D mt7621_spi_transfer_one_message;
> +	master->bits_per_word_mask =3D SPI_BPW_MASK(8);
> +	master->dev.of_node =3D pdev->dev.of_node;
> +	master->num_chipselect =3D 2;

The driver should set SPI_CONTROLLER_HALF_DUPLEX in flags.

> +	clk_disable(rs->clk);

This needs to be clk_disable_unprepare() to ensure the clock is
unprepared as well as disabled.

> +	spi_unregister_master(master);

Just use devm_spi_register_controller()?  The _master() name is legacy
and devm_ would make life easier.

--WkfBGePaEyrk4zXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyTnu0ACgkQJNaLcl1U
h9Ci1Qf/fyIJv+spxOGEYTe/YOJeoTJVXYzUt/35oK3iU7xRhX4kSArjdqGo/sW/
IvgKgUkDp7HLDatFcStbr0a5d00VlvHGV/Dcq2+XZzhnPFUb8vZLEXVdn89V9BUe
4hHjTNTweo2KJAix6GfgZ/AEPPpFixAsjtQUQ7Bj3F+BVAcF5S7JAqUzK6u/DRqr
5Il9LOMWaO3+9zlYOLmKk3RIAZyqDoKRTjhNWE/q/UZejmbUEu6T3XTbqFNnfTnG
iMDbFbuNLXOrT9wBuP4EgjqjXwfWEiu1+QDWMdZKTEZPTSNjJKxFdq2S1PUEia1g
wnZSCvx+q84RfVyXGJI0Qzj/Q7PQUQ==
=1V9x
-----END PGP SIGNATURE-----

--WkfBGePaEyrk4zXB--

--===============8921921268894567749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============8921921268894567749==--
