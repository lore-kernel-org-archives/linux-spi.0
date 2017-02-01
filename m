From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 3/3] spi: acpi: Initialize modalias from of_compatible
Date: Wed, 1 Feb 2017 18:34:40 +0000
Message-ID: <20170201183440.yxbei7dg776q4fjj@sirena.org.uk>
References: <1485187737-22414-1-git-send-email-dan@emutex.com>
 <1485523815-9629-1-git-send-email-dan@emutex.com>
 <1485523815-9629-4-git-send-email-dan@emutex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="onlwx7gykur6ajlf"
Cc: linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Crestez Dan Leonard <leonard.crestez@intel.com>
To: Dan O'Donovan <dan@emutex.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485523815-9629-4-git-send-email-dan@emutex.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--onlwx7gykur6ajlf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 27, 2017 at 01:30:15PM +0000, Dan O'Donovan wrote:

> +	if (acpi_of_modalias(adev, spi->modalias, sizeof(spi->modalias)))
> +		strlcpy(spi->modalias, acpi_device_hid(adev),
> +			sizeof(spi->modalias));

I can't help but think that this would be simpler to use if the
interface were something like acpi_set_modalias() and it did the
fallback to the ACPI HID internally.  It'd both avoid a small amount of
code duplication and make the code read a bit more naturally - I have to
think to realise that this means "if there isn't an OF name use the
HID" since it looks like a boolean function.  Then again just putting a
!= 0 in the test would have the same effect probably.

--onlwx7gykur6ajlf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliSKkAACgkQJNaLcl1U
h9BB8Af7BkCoJqVav9Kk0RKD3YFWAvPXbXdaX/CBVhxMcKNVkBsKU5Zr66DxeyGJ
XCxf3qmqcXFBfkM25Mm/cLmlX+RhgtaO+/weMhVNOIEJM9aB+uYyaOfLlsgQgEzQ
WESzHaguYVC3nJB+meT1uvNKq07U87XJvLfjHJGFmxGhpYo5rS4ZOIryxembrqRi
+H+z1SL4D70CPBSXwwUBg7KfmvuiA4arp/2uJiB/5g86hk4vsWL5eRDh8PROWldy
K1pKZhVWW7Z5AJh/L9pUq7Lbi2JVXQcBXhRglvGQb9UoHsSBXRXq2mmwAXQYAyUg
IlOzr3Idc9u46zXRExDmcKYQ10Y5lg==
=M8oa
-----END PGP SIGNATURE-----

--onlwx7gykur6ajlf--
