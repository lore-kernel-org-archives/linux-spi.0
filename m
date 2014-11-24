From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2 v3] SPI: spi-pxa2xx: Add helpers for regiseters'
 accessing
Date: Mon, 24 Nov 2014 18:59:41 +0000
Message-ID: <20141124185941.GH7712@sirena.org.uk>
References: <1412783423-9408-1-git-send-email-alvin.chen@intel.com>
 <1412783423-9408-2-git-send-email-alvin.chen@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HywGgDAwzDJj9z7S"
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mika Westerberg <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Hock Leong Kweh <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Boon Leong Ong <boon.leong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Raymond Tan <raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Weike Chen <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412783423-9408-2-git-send-email-alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HywGgDAwzDJj9z7S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2014 at 08:50:22AM -0700, Weike Chen wrote:
> There are several registers for SPI, and the registers of 'SSCR0' and 'SSCR1'
> are accessed frequently. This path is to introduce helper functions to
> simplify the accessing of 'SSCR0' and 'SSCR1'.

Applied both, thanks.

--HywGgDAwzDJj9z7S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc4AcAAoJECTWi3JdVIfQRyIH+wZImRqQJN7PU9dzxgmiy7TX
9GWfxfYOInrqz5Vq+1C9fSQa5BaPc5gEIxYhzhSTx2epN0iVzWPRAQ+9cWbJ8AzL
LimcFSDx8/TB4yj82fIPg64cN8HaPDqw/KP4vF4DkL0RNzTtLqY2voeZtbdcqnKC
1MgV3rVsB1KCaeOqjSUpiOt8S+yuX9HL5z7BJ0gTpM5oQUuQHLa/pXyr5DRx5mUB
lN0B5KNiwDRiNBMpK3J33gtC5fdjeJN6OhGkVggSnDOulcMl6gEfS6XNPFL4uXQu
t1KhUwHHi7RKyK4r9zYapidv0so4+6sNCgpEG0AywecVZ3ObZx3ybi9FCnrBlyk=
=hcgV
-----END PGP SIGNATURE-----

--HywGgDAwzDJj9z7S--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
