From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/2] spi: add driver for J-Core SPI controller
Date: Thu, 28 Jul 2016 20:11:53 +0100
Message-ID: <20160728191153.GL11806@sirena.org.uk>
References: <cover.1469686300.git.dalias@libc.org>
 <2a46090a5a7c177b7eca83f68406650844423e7f.1469686300.git.dalias@libc.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Epi5nlKhkk4Kf+ga"
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
To: Rich Felker <dalias@libc.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2a46090a5a7c177b7eca83f68406650844423e7f.1469686300.git.dalias@libc.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Epi5nlKhkk4Kf+ga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 03, 2016 at 05:12:45AM +0000, Rich Felker wrote:

> +config SPI_JCORE
> +	tristate "J-Core SPI Master"
> +	depends on OF
> +

An architecture or SoC dependency with || COMPILE_TEST would be useful
for avoiding cluttering Kconfig for other users.  Though as this is in a
FPGA it's perhaps likely people will pick this up for other FPGAs so
perhaps a comment to that effect if it seems likely.

> +static void jcore_spi_baudrate(struct jcore_spi *hw, int speed)
> +{
> +	if (speed == hw->speed_hz) return;
> +	hw->speed_hz = speed;
> +	if (speed >= hw->clock_freq/2)

Coding style, spaces around /.

> +	return count<len ? -EREMOTEIO : 0;

Again here, and please also write this as a normal if statement so it's
easier to read.

> +	/* The SPI clock rate controlled via a configurable clock divider
> +	 * which is applied to the reference clock. A 50 MHz reference is
> +	 * most suitable for obtaining standard SPI clock rates, but some
> +	 * designs may have a different reference clock, and the DT must
> +	 * make the driver aware so that it can properly program the
> +	 * requested rate. If omitted, 50 MHz is assumed. */
> +	clock_freq = 50000000;
> +	of_property_read_u32(node, "clock-frequency", &clock_freq);
> +	hw->clock_freq = clock_freq;

Why are you not using the clock API for this?  Just require a clock and
use clk_get_rate() to find out what rate it is.

> +	pdev->dev.dma_mask = 0;

Why are we doing this?  There's no DMA code...

> +	dev_info(&pdev->dev, "base %p, noirq\n", hw->base);

This is just adding noise to the boot, just remove it - it's useful to
log information we get from the silicon but things like the base address
don't really add anything and end up cluttering (and slowing) the boot
when everything does it.

--Epi5nlKhkk4Kf+ga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmlj4AAoJECTWi3JdVIfQy5QH/35g8/6zlsdIcQujUaCJiXiO
2zojNTrkofTDrfsHQCT7/5Pp82Q9Dze1XZ3LmAEFLg/mWgJX5VZA89WYBEAw/Jkf
dEpLBN/FfnnLJH60ReZf80nytfbKIidLm8gpfjrGZ+KNM1UTACOrN5kkwvdJHk+t
7jQZJ5M/rOu++CFKBmMIE3zXk81GkbPe1OBs8/S0/phTUFEah7GxaJ8i6iK5cECM
du+mzvYU2D9oiPC4rFeQw3Tcigmm4GmYItsqq3ePYxJBuEB0nHrU3+xFbFvw1OgR
rMfZjDHM0KWFdZaxozl4UxqbC0RWE8+cbzmjhglxe54BjvDjh59wzhRhfH/uXYk=
=1y9J
-----END PGP SIGNATURE-----

--Epi5nlKhkk4Kf+ga--
