From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] spi: octeon: Add thunderx driver
Date: Mon, 25 Jul 2016 17:16:32 +0100
Message-ID: <20160725161632.GD11806@sirena.org.uk>
References: <cover.1469174814.git.jglauber@cavium.com>
 <f87d7a5ef8a713fb6e64c5d9471e7e5bf2051d18.1469174814.git.jglauber@cavium.com>
 <20160724210452.GB6345@sirena.org.uk>
 <20160725155122.GA2710@hardcore>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	"Steven J. Hill" <steven.hill@cavium.com>,
	David Daney <david.daney@cavium.com>
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160725155122.GA2710@hardcore>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 25, 2016 at 05:51:22PM +0200, Jan Glauber wrote:
> On Sun, Jul 24, 2016 at 10:04:52PM +0100, Mark Brown wrote:
> > On Sat, Jul 23, 2016 at 12:42:55PM +0200, Jan Glauber wrote:

> > > +	depends on 64BIT && PCI && !CAVIUM_OCTEON_SOC

> > This is a *weird* and most likely broken set of dependencies - why
> > exclude this if we're on Octeon (or Octeon happens to have been enabled
> > in a config)?

> I agree that it looks weird, the reasoning is that we would like
> to avoid making the driver depend on something like ARCH_THUNDER.

Why?

> So I made the driver depend on the things it actually uses
> (PCI for probing and 64BIT because of readq/writeq) and don't care if it
> compiles on other platforms too (like x86).

The usual pattern would be something like (ARCH_THUNDER || COMPILE_TEST)
&& PCI && 64BIT (so that people on other platforms where the device will
never actually appear don't get bothered by the prompt).

> That said, I can remove the !CAVIUM_OCTEON_SOC, it compiles without
> errors on MIPS too. Would that be ok?

Sure.

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXljtfAAoJECTWi3JdVIfQjVkH/jG2sNoTg316YPftqoyNJGTq
QRvQyyLpiK4NxsQe9lHNmNFJRA+CXl0EaXo5W+E8rEN5ZGOi40eZ7oWF4k7OskP+
MwlKTuLfEQmphwe7D4cL0lp7wNZp7KCPkWftDRiIL4q/vaqp/GZm2CbKFHJHK2OK
ZdDSGqHSWDiSvh42QvuPjROYhOV6780OH+ejn87QOLK+h1R2fCYTMvBpjSB7d1je
H7x+nkb9FG19E+debuoVTuM3xBX7vip2cR3Tj5WT2WG83hPuRuPGFg1yisLdGV5Q
qQr8bWRpK8+xEdMKa5DKOZTOVbNkVPCaBD5NKPXBBWGhxAFmQSsDTtOPa8qQyrs=
=Z0K1
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
