From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: pl022: Add support for chip select extension
Date: Wed, 24 Sep 2014 09:32:05 +0100
Message-ID: <20140924083205.GZ4015@sirena.org.uk>
References: <20140916183431.GX7960@sirena.org.uk>
 <1410936418-26443-1-git-send-email-anders.berg@avagotech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1IWgL8yD8uKyf/Tu"
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Anders Berg <anders.berg@avagotech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410936418-26443-1-git-send-email-anders.berg@avagotech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--1IWgL8yD8uKyf/Tu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 17, 2014 at 08:46:58AM +0200, Anders Berg wrote:
> Add support for a extended PL022 which has an extra register for controlling up
> to five chip select signals. This controller is found on the AXM5516 SoC.
> Unfortunately the PrimeCell identification registers are identical to a
> standard ARM PL022. To work around this, the peripheral ID must be overridden
> in the device tree using the "arm,primecell-periphid" property with the value
> 0x000b6022.

Applied, thanks.

--1IWgL8yD8uKyf/Tu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIoGFAAoJECTWi3JdVIfQqzEH/jXdjXelxupUyZXDr6EmgzNe
xEbMFtB0thR/Z74+rYsRlYcJLWOCnpn3X3Xx7h2F3obu6X7JlGTTJ/f8cHtQEOC7
wDb5qLY0KCdvtFaQ7IMY4W4120OXzZ6WrRnPOUFU2CJ0mhERQK/63cuZ4vtdO/KU
DKVZ7pOFgyZ/X76bcjB3eoQAUI4zaV0S8aniKONLbnnYJAE9hQUink60FTVbcWPM
PsXGB70HFKbIrqou+o3Tpih6RgKHb5IkJSY4jZD0UyvPBrmvdLNwbMuk1ePGEk3R
MzZm77I7Fryn4g8ZnlMKy/jgvVYVdTgNoXIn3Cb+P92KjX1K/flQz/qfgGqxEVw=
=8ZMs
-----END PGP SIGNATURE-----

--1IWgL8yD8uKyf/Tu--
