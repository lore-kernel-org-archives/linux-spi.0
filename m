From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/4] spi: Use Apple device properties in absence of
 ACPI resources
Date: Wed, 28 Jun 2017 19:27:22 +0100
Message-ID: <20170628182722.mwak7afo5rtwt6zw@sirena.org.uk>
References: <cover.1498636759.git.lukas@wunner.de>
 <bca7fb9e406bbfa9ee7e8457cacd34418ef689be.1498636759.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5tzaeas3i5ilwizs"
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        linux-acpi@vger.kernel.org, linux-spi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bca7fb9e406bbfa9ee7e8457cacd34418ef689be.1498636759.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--5tzaeas3i5ilwizs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 28, 2017 at 07:20:19PM +0200, Lukas Wunner wrote:
> MacBooks and MacBook Pros introduced since 2015 return empty _CRS data
> for SPI slaves, causing device initialization to fail.  Most of the
> information that would normally be conveyed via _CRS is available
> through ACPI device properties instead, so take advantage of them.

Acked-by: Mark Brown <broonie@kernel.org>

--5tzaeas3i5ilwizs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllT9QkACgkQJNaLcl1U
h9BoCgf/ReA+WPMF1swrVd1jqaZHTAvdpP4W1qdM0BLBi70TzVc1X6OpvNTueh7W
zRvYE62KF/VuNsUzyKFWcZP2ajI/zHzwS8PjGTg+KtrlSoTxFUARFX9A4Ffh0cWm
3sObdqlG/qHAFYz+lAyWuzetxQ9HjWM75aKYdlTuC7MdTueKM0NaVXCFF9RG+eon
lhRva35OLPYKO52yuS6iwMdk93K64s2AUPzKoM3pUwtKqhv52het4a8ve1CL38aU
bwGnFpsQpmMAEbSuPX/zjrhC/dSK7uFpEyfr1X2/y3B3h1/QsIU/0hpYUMu0zAj7
Ad6lMZ+dEZ0PUllEDWl/lvNgSfJdYw==
=8VHs
-----END PGP SIGNATURE-----

--5tzaeas3i5ilwizs--
