From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/12] spi: spi-fsl-dspi: Fix per transfer cs_change
 handling
Date: Wed, 20 Jun 2018 14:27:55 +0100
Message-ID: <20180620132755.GF6242@sirena.org.uk>
References: <20180620073442.20913-1-esben.haabendal@gmail.com>
 <20180620073442.20913-4-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Cc: linux-spi@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
To: Esben Haabendal <esben.haabendal@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180620073442.20913-4-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 20, 2018 at 09:34:33AM +0200, Esben Haabendal wrote:

> As of 92dc20d83adec565378254c0630e839ff5674e14, transfer->cs_change has
> been supported for non-last transfers, but not for last transfer.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsqVloACgkQJNaLcl1U
h9AWlgf+Jn8V8GuWmqwEjOKvD0pO8SCEE/IgKm5c/+b3o8F/A0emloVE+ajKiHbr
oBK3+hMehOCGdgDuE9TYltcC3q8v64mqtIHqrqunm4cgFaE6xzWzBbBNn6lI07Z6
6zleQcD5fYwaZv/AJOIIdcuxTOFISymveAuR1ghppifKWOub2cFhNdfC7cCUYUII
5hOcMmb8+/P870I/45ZfOVoK+wZZ4Mt5DtXy2zVgwWL95FIIMMBIfFVlQ9UFCib5
baIGM5L7JNNEHR536q9HB7BHqx69yCDNZk9F4SUMrc2yxFavpLzKsTjWZM6vwAnT
e9IJKF1ocTg12yzqRbpGU/uJ6OrtEQ==
=j208
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
