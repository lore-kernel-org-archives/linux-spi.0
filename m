From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Add ACPI probing support
Date: Mon, 4 Jul 2016 14:56:00 +0200
Message-ID: <20160704125600.GB6247@sirena.org.uk>
References: <1467628683-5783-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vt4ed5MNefdcgji4"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1467628683-5783-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vt4ed5MNefdcgji4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2016 at 01:38:03PM +0300, Mika Westerberg wrote:

> +	/*
> +	 * The ACPI SPT000* devices are only meant for development and
> +	 * testing. Systems used in production should have a proper ACPI
> +	 * description of the connected peripheral and they should also use
> +	 * a proper driver instead of poking directly to the SPI bus.
> +	 */
> +	if (has_acpi_companion(&spi->dev))
> +		dev_warn(&spi->dev, "do not use this driver in production systems!\n");
> +

This is fine for now since all the ACPI devices are dummy ones but as
soon as someone comes up with an actual ACPI ID for something that
should be managed via spidev it'll need changing...

--vt4ed5MNefdcgji4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXelzcAAoJECTWi3JdVIfQRRsH/jxojd2DgFeO9GJx7dUkXc6L
bxfUBeFoKMGz9y17nS7g4gfKXjFzyPcW7Elf6kn7Mywz57rQVkmWwBfoOz41KAX2
5a49V/AAo864k7w3yohZbzfNmddUi59maRLy09sl5/1cfSW2hZP0gmf5IckZlg2t
BMDNCLIQIR0mSC4jwaKpvJKCu+a3XW5TdEq422u4Myez9CI8R4geTifQo0tF8trC
GWcv4kFDtvoUgQMUr1Us1eQ1hxkqtOxgpzCDMatPz4DrJr+jQVbIQ1NYuQ7M2SQE
bBbw4OUyHLFAS4qtdmxb+5Dr9A1exlDl8egIwakNjR2J5fISN0VguXEiVYAo8jU=
=HTCZ
-----END PGP SIGNATURE-----

--vt4ed5MNefdcgji4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
