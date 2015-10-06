From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 2/4] spi: bcm2835: add bcm2835 auxiliary spi device
 driver
Date: Tue, 6 Oct 2015 12:23:20 +0100
Message-ID: <20151006112320.GP12635@sirena.org.uk>
References: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org>
 <1441970527-2403-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4t0ONBuCiVxn5iiM"
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	eEric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441970527-2403-3-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4t0ONBuCiVxn5iiM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2015 at 11:22:04AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:

> +	bs->irq =3D irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	if (bs->irq <=3D 0) {
> +		dev_err(&pdev->dev, "could not get IRQ: %d\n", bs->irq);
> +		err =3D bs->irq ? bs->irq : -ENODEV;
> +		goto out_master_put;
> +	}

Why are we using this unusual DT specific API here?  I'd expect to see
just use platform_get_irq() here and this seems to be the only DT
dependency in the driver.=20

> +	err =3D devm_request_irq(&pdev->dev, bs->irq,
> +			       bcm2835aux_spi_interrupt,
> +			       IRQF_SHARED,
> +			       dev_name(&pdev->dev), master);
> +	if (err) {
> +		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
> +		goto out_clk_disable;
> +	}
> +
> +	/* reset SPI-HW block */
> +	bcm2835aux_spi_reset_hw(bs);

I'd expect to request the IRQ after we reset the hardware in order to
ensure that the hardware is in a known good state=20

> +
> +	err =3D devm_spi_register_master(&pdev->dev, master);
> +	if (err) {
> +		dev_err(&pdev->dev, "could not register SPI master: %d\n", err);
> +		goto out_clk_disable;
> +	}
> +
> +	return 0;
> +
> +out_clk_disable:
> +	clk_disable_unprepare(bs->clk);
> +out_master_put:
> +	spi_master_put(master);
> +	return err;
> +}
> +
> +static int bcm2835aux_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master =3D platform_get_drvdata(pdev);
> +	struct bcm2835aux_spi *bs =3D spi_master_get_devdata(master);
> +
> +	bcm2835aux_spi_reset_hw(bs);
> +
> +	/* disable the HW block by releasing the clock */
> +	clk_disable_unprepare(bs->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id bcm2835aux_spi_match[] =3D {
> +	{ .compatible =3D "brcm,bcm2835-aux-spi", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, bcm2835aux_spi_match);
> +
> +static struct platform_driver bcm2835aux_spi_driver =3D {
> +	.driver		=3D {
> +		.name		=3D "spi-bcm2835aux",
> +		.of_match_table	=3D bcm2835aux_spi_match,
> +	},
> +	.probe		=3D bcm2835aux_spi_probe,
> +	.remove		=3D bcm2835aux_spi_remove,
> +};
> +module_platform_driver(bcm2835aux_spi_driver);
> +
> +MODULE_DESCRIPTION("SPI controller driver for Broadcom BCM2835 aux");
> +MODULE_AUTHOR("Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");
> --
> 1.7.10.4
>=20
>=20

--4t0ONBuCiVxn5iiM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWE68nAAoJECTWi3JdVIfQ/qgH/2PcUYVXb6ISydKbZ0v7az9W
pKY20xfna4nsQ1a67IgF1vGf/swO8sPp/DgMHn0FsVGktymIr3v0tNWMQ9PeaSht
KuW76VJquLoOpM8nQU6DxsqzfrIgqcGaOboS9CMZeB/go7EZjeaHwa2e5WILjNK3
oBVugSSjYHNVkf+11fCLfqM9Ka86kwoZ1ZHKqB6bjPRcwb0knuBztkgOi8pPoXgy
GFLQLj2euvwBvMeqJcIwSmND6PUw4ynI4VFSZiE67Lc93B55CqSKd4OZSOAb8D6Q
MbbKhcEcuyPoYmmvqDbM6mBAU03XpoW0EYIu6zZ8yPREIbgRR9musy5Qc6Hy0mY=
=1T6T
-----END PGP SIGNATURE-----

--4t0ONBuCiVxn5iiM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
