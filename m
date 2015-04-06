From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: setting up cs_gpio levels prior to registering spi
 devices
Date: Mon, 6 Apr 2015 18:36:07 +0100
Message-ID: <20150406173607.GX6023@sirena.org.uk>
References: <1428340592-3196-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4o7zxXGKBnJhDNqV"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428340592-3196-3-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4o7zxXGKBnJhDNqV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 06, 2015 at 05:16:32PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:

> +	mutex_lock(&board_lock);
> +	list_for_each_entry(bi, &board_list, list) {
> +		sbi = &bi->board_info;
> +		if ((master->bus_num == sbi->bus_num) &&
> +		    (sbi->chip_select < master->num_chipselect) &&
> +		    gpio_is_valid(master->cs_gpios[sbi->chip_select]) &&
> +		    (sbi->mode & SPI_CS_HIGH))
> +			gpio_set_value(master->cs_gpios[sbi->chip_select], 0);

Please write a series of if statements with continues instead, the above
block is pretty much illegible with the lack of vertical space, mixture
of bracketing levels and small indent for the active statement at the
end.

As far as I can tell this code only works for GPIO chip selects?

> +static void acpi_spi_setup_gpiopins(struct spi_master *master)
> +{
> +	/* probably not needed, as there seems to be no cs_gpio
> +	 * information in the ACPI structures but left for completeness
> +	 * to get extended if needed
> +	 */
> +}

Please don't write placeholders like this.

--4o7zxXGKBnJhDNqV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIsQGAAoJECTWi3JdVIfQfQcH/15ORTqWaZB4e24c2QfIPUH9
VYPdbgCNV0ggaiEiYJQqu5gnRnfOaCZufg4EgNUWUQgLqvrfRma0PXeTrFpeM1lc
jJ/sOKgFg7dB/+2ReuNCYxTr7wz64QLRXlC7axE0k/g0dhMWYEfV0tExSVeNdiT2
Ee0SRLUrODBWAsXH2HGKCwJIatJB1FYCvLxkN9ku3OFYKMruEVaxL0QXW7Cw/ysa
qdulWAhxd1P4zB6Rj/prw7Nw5EVAV+AOfWoyV7qp1PPf/pj1IDMlwx7gBCkLrrBs
r16YeH4KLV2mo8rWlrcMdYFsuUd7iLNZdVmnBpUAWMlG8+XM3wNZyiCrYHhtCno=
=g6Nu
-----END PGP SIGNATURE-----

--4o7zxXGKBnJhDNqV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
