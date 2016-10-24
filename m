From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/28] spi: fsl-espi: avoid processing uninitalized data
 on error
Date: Mon, 24 Oct 2016 19:45:43 +0100
Message-ID: <20161024184543.GR17252@sirena.org.uk>
References: <20161017220342.1627073-1-arnd@arndb.de>
 <20161017221355.1861551-5-arnd@arndb.de>
 <20161024172713.GI17252@sirena.org.uk>
 <f364c025-91c0-6625-e2a3-d00baf17d71c@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="By57YlnFViWR/M0S"
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Heiner Kallweit <heiner.kallweit@web.de>,
        Nobuteru Hayashi <hayashi.nbb@ncos.nec.co.jp>,
        linux-spi@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f364c025-91c0-6625-e2a3-d00baf17d71c@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--By57YlnFViWR/M0S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 24, 2016 at 08:36:37PM +0200, Heiner Kallweit wrote:
> Am 24.10.2016 um 19:27 schrieb Mark Brown:

> > This doesn't apply against current code, please check and resend.

> The not yet reviewed part of my patch series from Oct 2nd,
> namely "[PATCH 07/11] spi: fsl-espi: fix and improve reading
> from RX FIFO" replaces the code in question.
> There's more to fix like removing polling from the ISR.
> If you prefer to apply Arnd's fix first I'd rebase the open part
> of the patch series and resend it.

If there are dependencies you should mention them when you resend (in
general you should always mention any unapplied or cross tree
dependencies when sending things).

--By57YlnFViWR/M0S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYDlbVAAoJECTWi3JdVIfQkzYIAIVf0fPd0zNwSgmyBFo2B6ic
WklJfI3yw6BLbuOo6reX4iqjVURk0taWdgHK+00/P05fKeF/GhQAG8BZHJFAvOgn
G2iGR/cTcUWeQXLHFP0NA7DmrI8e1Ua+Zw7NRaTqhVTfWA9vzmWZHWovN91UlnpY
6JXPng2ARQF8zsiAxAAf6SLe70BHOZHmmJYeGgvDq+asHfwmlowD/D2cEOGxwLwR
J8mJ16lxdnVJQ67iYdVAkFjRPG3BUD185uPs5fJuAl127Zidj7rVfpYLO070SFgC
DyD0LUMgMzSNO+0ktWaioONyHPUQXfe1XwHj7Gg5JHvtZPm75eeKF2o5kXG4GA8=
=uRfA
-----END PGP SIGNATURE-----

--By57YlnFViWR/M0S--
