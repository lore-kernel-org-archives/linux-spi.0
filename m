From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] [PATCH 1/3] lib/scatterlist: Add support to clone sg_table
Date: Wed, 22 Jun 2016 16:18:03 +0100
Message-ID: <20160622151803.GP28202@sirena.org.uk>
References: <1466203513-4771-1-git-send-email-fcooper@ti.com>
 <1466203513-4771-2-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IihjUyvzd0n5Ehsu"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	david.s.gordon@intel.com, akpm@linux-foundation.org,
	nsekhar@ti.com, vigneshr@ti.com, peter.ujfalusi@ti.com
To: Franklin S Cooper Jr <fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466203513-4771-2-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--IihjUyvzd0n5Ehsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 17, 2016 at 05:45:11PM -0500, Franklin S Cooper Jr wrote:
> Occasionally there are times you need to tweak a S/G table while
> maintaining the original table. This function will duplicate the passed
> in S/G table along with its chained sgl and return a pointer to the cloned
> copy.

You ought to send this to whoever looks after the scatterlist code as
well, or at least a wider circulation.  Unfortunately that doesn't look
100% clear...  off the top of my head Jens Axboe and Andrew Morton look
like good candidates.

--IihjUyvzd0n5Ehsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXaqwpAAoJECTWi3JdVIfQTPUH/RGWz2BZ8fsFGrm7GxePYmSB
3QtR/jjLroc1MmSY7UJ7lY4aKfjlIbBgMHpqDEXSs2fJuFWeSMbMz/UCaJmE5mYw
szEjwv+dPRKS17U0hgwX1AGnkvaSh3Q4rLqIkZPlJ2ZjvK7I3EIRYXgkxiT3FyIw
mklBO+oMrGuG4vwtnLAHYtVI72N0Of+OfOdRUJIojJ4Ak/T7XNxkUFj/SW7/EYhS
Uyi48LeErY08J0DlDG4sq/Zvwmb3cZ2wxj/+A+Cyhbq6vBO+3xpoRJ7//mMF0QxP
NCmjQoJbSko/zIPFG9LPJlsn01FCfy7utkTh1GgG090oQ/FgEYCXvGe8g/nykC8=
=wsq+
-----END PGP SIGNATURE-----

--IihjUyvzd0n5Ehsu--
