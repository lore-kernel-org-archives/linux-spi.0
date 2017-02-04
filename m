From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 3/3] spi: acpi: Initialize modalias from of_compatible
Date: Sat, 4 Feb 2017 11:16:40 +0100
Message-ID: <20170204101638.qmhdvzwmnmmnrpa7@sirena.org.uk>
References: <1485523815-9629-1-git-send-email-dan@emutex.com>
 <1486195228-10929-1-git-send-email-dan@emutex.com>
 <1486195228-10929-4-git-send-email-dan@emutex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="55e4jgix7p4jdrej"
Cc: linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Dan O'Donovan <dan@emutex.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486195228-10929-4-git-send-email-dan@emutex.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--55e4jgix7p4jdrej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 04, 2017 at 08:00:28AM +0000, Dan O'Donovan wrote:

> +	acpi_set_modalias(adev, acpi_device_hid(adev),
> +			  spi->modalias, sizeof(spi->modalias));
> +

The formatting here is really weird (why isn't the third argument on the
line above?) but otherwise

Acked-by: Mark Brown <broonie@kernel.org>

--55e4jgix7p4jdrej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliVqgUACgkQJNaLcl1U
h9DV0wf8CKLaM+Nj0zKzfVMoXk/3rXmwuouaBRHT5CwYcNhLHVzvzS9M/WVhJrij
dT0M5Kl+1l55TFZ68RSc5MXzuAs4xovJ6ZttaFDrPlpJq0Q/wLWW4QdnjlG0AOLZ
g49kYtyeyYo/p4GKFza2Qq9IfjjGK9LcqLZQlVTWdHLIx8ajV7fGvGQ8OAqyWP5h
XQzsJFLWCBqBJomx+UoJDRLmoNxeypRB4CG5BDKfvVfjG26l6OAIh235k8j81fSK
iFc8SllmrYGf3x37xDpw6lz3eP7KbdxEZ3XWyewIJAT2ZpjihPeD4kIFJCzbYB7+
0LU0+pkF/4jg1aGaar+T0ad2SivZGw==
=MzXW
-----END PGP SIGNATURE-----

--55e4jgix7p4jdrej--
