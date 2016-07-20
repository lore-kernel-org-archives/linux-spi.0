From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] acpi spi: Initialize modalias from of_compatible
Date: Wed, 20 Jul 2016 12:37:53 +0100
Message-ID: <20160720113753.GF6509@sirena.org.uk>
References: <cover.1468409668.git.leonard.crestez@intel.com>
 <1d26e956f12fcd86ad915659adeb86e242b96ac7.1468409668.git.leonard.crestez@intel.com>
 <20160719102213.GZ30372@sirena.org.uk>
 <a9507dd1-93cf-547a-3bf1-1d7a18fcc761@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Cc: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jarkko Nikula <jarkko.nikula@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a9507dd1-93cf-547a-3bf1-1d7a18fcc761@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 20, 2016 at 02:21:55PM +0300, Crestez Dan Leonard wrote:
> On 07/19/2016 01:22 PM, Mark Brown wrote:

> > Please submit patches using subject lines reflecting the style for the
> > subsystem.  This makes it easier for people to identify relevant
> > patches.  Look at what existing commits in the area you're changing are
> > doing and make sure your subject lines visually resemble what they're
> > doing.

> So the prefix should be something like "spi: acpi: "?

Yes.

> >> +	if (adev->data.of_compatible) {
> >> +		ret = acpi_of_modalias(adev, spi->modalias, sizeof(spi->modalias));
> >> +		if (ret) {
> >> +			spi_dev_put(spi);
> >> +			return AE_NOT_FOUND;
> >> +		}

> > The only reason this could fail currently is that there wasn't a
> > compatible in the first place so why don't we just handle it like the no
> > compatible case?  It's probably not realistic but it seems like there's
> > a small chance this could regress some platform if we do add more error
> > detection in acpi_of_modalias().

> If acpi_of_modalias fails for some new reason wouldn't it be better to
> fail explicitly rather than ignore it?

The current code will happily proceed to create a device without doing
this parsing so clearly we can do that.  It's not clear to me that it's
better to refuse to create the device at all than to soldier on and
create a device with only the native ACPI information, perhaps it just
needs a comment explaining why we do that.

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXj2KRAAoJECTWi3JdVIfQ+3cH/j/95PTTAtamo6IZMtlDeQHY
MW/1vLd4ZEHEvU9i/dokwjR4dLAj7+wcFIGBzNLqygQeY4RLWS0YzTR2VFsFaFwU
h29n2YH1htn5cCqMxZxw/a9suISSExZcLdFxH8msBoqddNXEqeEZ9fZROLBZiJQd
XkUbTYvneodtv52Cn0LsJemT3QbQMvPWGaeu9pnWf6VGW6wYcIJZ2yr8fGN22Qw2
ZOFYwsC1zErjLYj4z0YOS3JFn3WsRTvd22q8sUmzx0IBKAZpVQYflpzDNZT8qlFq
4AmqIOZdC6RVVp2W4iNKtBFxpwbXfmdK41vPJCU/ClEH9HHPKus7NgfXDKbDlhA=
=+bTh
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--
