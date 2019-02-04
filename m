From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ARM: dspi: Provide support for DSPI slave mode
 operation (Vybryd vf610)
Date: Mon, 4 Feb 2019 11:57:37 +0100
Message-ID: <20190204105737.GE23441@sirena.org.uk>
References: <20180927150709.17010-1-lukma@denx.de>
 <20190109082644.14941-1-lukma@denx.de>
 <20190204113001.77d59570@jawa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Cc: Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190204113001.77d59570@jawa>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 11:30:01AM +0100, Lukasz Majewski wrote:

> Is there any interest in adding new code (or fixes) to VF610 ?=20

You've been sending ARM: patches to me (the SPI maintainer) and one of
the DT maintainers.  You need to send patches for that platform to the
relevant platform maintainers, I only maintain drivers/spi (and some
other subsystems).  Similarly the DT maintainers only maintain the
generic devicetree stuff (but apply relatively few patches directly).

Please see submitting-patches.rst for details.

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxYGqAACgkQJNaLcl1U
h9ChZAf+IMhKOXOta9O9aHuoCBQ2p2TtyFCR4Zf2n3kP69uR4e+YcTMGEkUAQELe
48mrri6qhni1vhrInwLawEhMcF5bHqwnAZm2E3H0JXYPSoI9PCKcwqKnsMnlwg7x
k5scsb0IguVujXN8fjnBFwUDeBGtS7FCd7sD+QCPGJ9KsGyyFHWrCQQTRpkiux4g
wUWHFIU31wnwM6JPjfaRIge37sS6UB7lWnwJp0InQIFbtq/OK6H4R7cOwamAx3uL
d5OjWB/dX5mpYPhVpRC3bzQWyKJnOsLAoRgSsrmaWawROEWr5tiuNXa4MqT+15Ed
5LBkorkLIX0r3GTyuY2j1uEdeT3XMA==
=LwcP
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
