From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/6] spi: octeon: Add thunderx driver
Date: Sun, 24 Jul 2016 22:04:52 +0100
Message-ID: <20160724210452.GB6345@sirena.org.uk>
References: <cover.1469174814.git.jglauber@cavium.com>
 <f87d7a5ef8a713fb6e64c5d9471e7e5bf2051d18.1469174814.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Steven J. Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f87d7a5ef8a713fb6e64c5d9471e7e5bf2051d18.1469174814.git.jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 23, 2016 at 12:42:55PM +0200, Jan Glauber wrote:

> +config SPI_THUNDERX
> +	tristate "Cavium ThunderX SPI controller"
> +	depends on 64BIT && PCI && !CAVIUM_OCTEON_SOC

This is a *weird* and most likely broken set of dependencies - why
exclude this if we're on Octeon (or Octeon happens to have been enabled
in a config)?

> +static void thunderx_spi_clock_enable(struct device *dev, struct octeon_spi *p)
> +{
> +	int ret;
> +
> +	p->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(p->clk)) {
> +		p->clk = NULL;
> +		goto skip;
> +	}

This is really not clever - we should be requesting clocks on probe, not
only when we're trying to enable them, and using devm_ outside of probe
paths is usually a warning sign too.  Now, this is actually called from
probe so it works out fine but obviously it'd be better to improve the
power management to only enable the clock when needed and at that point
this function will be used and we'll fall into a bad pattern.

Given how tiny this function is and that we've not bothered splitting
out any of the other resource acquisition it's probably better to just
inline it into probe.

> +	dev_info(&pdev->dev, "Cavium SPI bus driver probed\n");

Again, this is just adding noise to the boot log.

> +#define PCI_DEVICE_ID_THUNDERX_SPI      0xa00b
> +
> +static const struct pci_device_id thunderx_spi_pci_id_table[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_THUNDERX_SPI) },
> +	{ 0, }
> +};

The define for the device ID doesn't seem to be adding much here.

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXlS1zAAoJECTWi3JdVIfQfGAH/2tFpOy5l4QPY5ba71xv2ucs
EB4zSLVICi0N+ebySRF89BD+eSIX/8TPAP5+GjAfAf2BkihtaHzXpzNN3xkD39ed
VFQdhpS2RS7W55JWEJHtTVLBns4Mhvvt/LBBHrS55c5ph1ERjhd0AT037VXpxktL
64BHi01sLCrK6jVLACpIYUCn3C93ucCPO+c0iwj1UFA8w8ugBQ1EGRT3AHwPXYR7
OXd9uV1P8DrwXi1CiRKlN+xFwlQcCX/OP5wum2BexUkusxkruTMsvtZr6OjqbAT+
ca8gAYpt0NhV3o3A5WABe7mV0RdG0c5BUiRy17IFLR7Dohn2VF1ycllXUhH+nJ0=
=GbMc
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
