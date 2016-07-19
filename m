From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] acpi spi: Initialize modalias from of_compatible
Date: Tue, 19 Jul 2016 11:22:13 +0100
Message-ID: <20160719102213.GZ30372@sirena.org.uk>
References: <cover.1468409668.git.leonard.crestez@intel.com>
 <1d26e956f12fcd86ad915659adeb86e242b96ac7.1468409668.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0tC/8VcTcTa+VwnR"
Cc: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jarkko Nikula <jarkko.nikula@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1d26e956f12fcd86ad915659adeb86e242b96ac7.1468409668.git.leonard.crestez@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--0tC/8VcTcTa+VwnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 13, 2016 at 02:53:42PM +0300, Crestez Dan Leonard wrote:
> When using devicetree spi_device.modalias is set to the compatible
> string with the vendor prefix removed. For SPI devices described via
> ACPI the i2c_board_info.type string is initialized by acpi_device_hid.
> When using ACPI and DT ids this string ends up something like "PRP0001".

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

> Change acpi_register_spi_device to use the of_compatible property if
> present. This makes it easier to instantiate spi drivers through ACPI
> with DT ids.

This is basically fine but...

> +	if (adev->data.of_compatible) {
> +		ret = acpi_of_modalias(adev, spi->modalias, sizeof(spi->modalias));
> +		if (ret) {
> +			spi_dev_put(spi);
> +			return AE_NOT_FOUND;
> +		}

The only reason this could fail currently is that there wasn't a
compatible in the first place so why don't we just handle it like the no
compatible case?  It's probably not realistic but it seems like there's
a small chance this could regress some platform if we do add more error
detection in acpi_of_modalias().

I'm still not sure why if we want to translate ACPI into DT why we don't
actually translate and avoid all this special casing and churn.

--0tC/8VcTcTa+VwnR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXjf9UAAoJECTWi3JdVIfQjoEH/jMFF3z4brk2Hp4vGQPgsW8B
Q7VIRuCfmaiU2wRv24WbLRx0UMYEXbtg61tOMMfv47NE4K1TR60W4EdoVgB1VQ9Z
ihr7riF3hqB3dcxpN6RalLxArQJkuSXh3LunxgQHmW6xsytWpH6I8XCP4d2jY39D
n37qxM8K/BuYBrFYEKSFUjRQBy8XjeUxprA/BgK512Avknpvj+r0LnhV7ptypsRD
tUkuupmVWVxD3C7aTvGfDPf6zcfRmPlRgAAnNbFOxqrYW5eg2GxflystklLAsY6A
v7Eexp1DymKNCT7UsiUqBvE3260uJrQA8dWUqevjm5ZPFnnvCm+8Iv9V2978AZA=
=OX7b
-----END PGP SIGNATURE-----

--0tC/8VcTcTa+VwnR--
