From: Mark Brown <broonie@kernel.org>
Subject: Re: Backport of spi-fsl-spi bugfix to 3.14.y
Date: Sun, 25 Jan 2015 20:12:54 +0000
Message-ID: <20150125201254.GX21293@sirena.org.uk>
References: <1420472564.803.9.camel@gmail.com>
 <20150105154834.GV11764@sirena.org.uk>
 <CAOR3GqUBWyfUvNG-8JiPVkis6b_25Eq_REtcp=kLN3CUoqsG6g@mail.gmail.com>
 <20150123124529.GU21293@sirena.org.uk>
 <20150125173853.GA6467@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/cFG30PKHi9lwv6o"
Cc: Esben Haabendal <esben.haabendal@gmail.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Stefan Roese <sr@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150125173853.GA6467@kroah.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--/cFG30PKHi9lwv6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 25, 2015 at 09:38:53AM -0800, Greg Kroah-Hartman wrote:
> On Fri, Jan 23, 2015 at 12:45:29PM +0000, Mark Brown wrote:

> > So, I now see this has actually been merged into stable without getting
> > to the bottom of why it's helping anything...  this is a bit worrying
> > since it's adding new functionality and not really a bug fix.  It'd have
> > been good to at least get a followup here.

> Do you want me to revert something from the stable tree?  If so, has it
> also been reverted upstream?

The patch just isn't an obvious -stable patch - it's adding new
functionality, not fixing a bug, and I was surprised to discover it had
been added as a result.  It's fine as new functionality and therefore
hasn't been reverted upstream.

We can probably leave it there, though if this is OK that's a bit of a
change, but if this new functionality is a good fix then we're probably
leaving other systems unfixed which isn't good, I would be very much
happier if we understood what had changed here.  If new functionality is
OK there's a probably a bunch of other changes we should be pulling
back.

--/cFG30PKHi9lwv6o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUxU5FAAoJECTWi3JdVIfQeEsH/ipnAy0CGkCv480YmZDjNnPD
VX6o5p+GAYKN/tLhwpYlo9y3zWcapoZsLpJmxOrztsNjCes7vIC3g7eu1776mXyF
hg5Qu8jszl63V1ZiEEXL9gv6CNt63p/bEiQXTnfdzta9zQx8mLqIxcAdVuF8w5BD
89c+H6bsYB2WCnXRq+MFiaRKK0SLW0syINW0XGDRyabNM3kSGzpitN9YN99U9Tll
YLV63kCSOThQPCg5f5sJ9S/SaeQioCaQWorwvzSUV5VTMbte6tPlx8EA55K967yY
tWFJSNFzbe0hDqfqs9RekkFdh79ouv0oEtNhcc3v/ITVk1mSpY9yBaPaaJJUpmk=
=/z9D
-----END PGP SIGNATURE-----

--/cFG30PKHi9lwv6o--
