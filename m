From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Wed, 25 May 2016 19:02:37 +0100
Message-ID: <20160525180237.GB8206@sirena.org.uk>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524174140.GE11605@leverpostej>
 <5744BC76.9090403@gmail.com>
 <20160525092034.GE1337@leverpostej>
 <5745C5A3.6060202@gmail.com>
 <20160525155949.GB30956@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YLBcqQnAC9NQWYFL"
Cc: Frank Rowand <frowand.list@gmail.com>,
	Christer Weinigel <christer@weinigel.se>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160525155949.GB30956@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--YLBcqQnAC9NQWYFL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 25, 2016 at 04:59:50PM +0100, Mark Rutland wrote:

> e.g. stating that this describes a well-defined system-specific bus
> number as documented in a manual, with a note regarding Linux behaviour
> is better simply describing the Linux behaviour.

If it means anything it's really a system specific controller number but
even there it's at least as likely that the system will provide a
textual description as a number (eg, SPI_FLASH) and if it's supposed to
map onto something that can be abstracted between systems there's no
guarantee that if there's more than one SPI device to consider they'll
be provided by the same arrangement of controllers and chip selects on
different boards (which seems to be a use case here) so the spidev names
would still vary.

--YLBcqQnAC9NQWYFL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRei8AAoJECTWi3JdVIfQWp0H/RwJgciSCh7x3JYStB62jtpF
nANVeQAkngd+SGJXnlQzUeuo7bKTWOU247GYrdt/5e/19t2XZKpBSrfCHrzEjwEF
XAC5iJjZAWSZZahPp8iM8rXBLRrp3qTgmwY6tV67y2wKiLNhFYHkLvxZ0guUVMEm
MGwMiai82AOsyq6DRDyG8kJXvXwkYiTnoYFjCMcSGkywnrWY+1IBPACgZks/Z2Ct
Y5NZIsKLN6/HIMvxHmu25rv+r1xBZwWV/sQEye9fTiPoD8ASWBgpyQu0lJP/9xRv
BjlQWmE+UtYXdoWNCvJG3HvXtKy5UV4CHBJHccR14R0v6wHLG08c8VkjU18p24s=
=Urva
-----END PGP SIGNATURE-----

--YLBcqQnAC9NQWYFL--
