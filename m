From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Enable Cadence SPI driver for ARM64
Date: Tue, 24 Feb 2015 17:08:07 +0900
Message-ID: <20150224080807.GS6236@finisterre.sirena.org.uk>
References: <859f9c4d3fbbc5153d924d7a6e36aa3a734e1b16.1424763838.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kjwfQs4m3ZHLWJuw"
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu,
	linux-spi@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <859f9c4d3fbbc5153d924d7a6e36aa3a734e1b16.1424763838.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--kjwfQs4m3ZHLWJuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 24, 2015 at 08:44:01AM +0100, Michal Simek wrote:
> This driver is used on new Xilinx ZynqMP SoC.

Why does this have an architecture dependence at all?

--kjwfQs4m3ZHLWJuw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7DFmAAoJECTWi3JdVIfQ9YUH/RTwoEIDB17yvYbTRle2jIAv
uvGfSiXCsup17Kw+vObe2LNzZqpD4bA7a70WPfZC9m5MB2oUBnixD+OXDeYwfNQ5
zx+ix037ov1w+8koGNdXFFKjwh8WiFtjbojh2ixrk8Z0cbdBE+qWOaYGgkkUt76Z
xbfMk2LReq5alJXR0eiOluiBu+AQ4m5O3m6XstzaqAD1FOaWZdYSJXnE/Y5tzq78
hdioWlvnSyTeqoXKO+n8xfspIq6ywQ8ckqqyHlSFAv2nCi3xdvTxWPMob7qiwHK3
79jdokj+Zhddg0jGJWYS8FoHg++nJ9S4H3l1VTuUiQtbV5javlT0VbiJhXGaVIU=
=Qefe
-----END PGP SIGNATURE-----

--kjwfQs4m3ZHLWJuw--
