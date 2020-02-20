From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: spidev: fix a max speed setting
Date: Thu, 20 Feb 2020 18:42:01 +0000
Message-ID: <20200220184201.GE3926@sirena.org.uk>
References: <20200220141143.3902922-1-oleksandr.suvorov@toradex.com>
 <20200220141143.3902922-3-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Oleksandr Suvorov <cryosay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Igor Opanyuk <igor.opanyuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
To: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200220141143.3902922-3-oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 02:11:51PM +0000, Oleksandr Suvorov wrote:
> SPI_IOC_WR_MAX_SPEED_HZ command always sets spi->max_speed_hz
> to the initial value come from DT.

This is intentional.  It's doing a call to spi_setup() then restoring
the original value, the goal being just to run spi_setup() with the new
value - it's not really a good idea to change the maximum speed in the
first place.

> It leads to set a wrong max speed with IOCTL call.

In what way does it lead to the wrong speed being set?

> Fix the logic of a max speed assignment.

If the expectation is that the default speed should be changed for the
device this should be handled at the spidev level rather than in the
core.

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O0vgACgkQJNaLcl1U
h9CHKAf/SBwTBBlMx+ka5Ypwl270AEXWAyIyvIekkMZzI/QmE0TkpWpCeBaVyVsK
alxy6DfOGTWecBIn8m/uvMxa/05NxIqlN3PNtXySaEVuMwMePIACJXMNQeg744tu
7iVPnBD94Cdoc7aLsRp8qFBV4FY2xTt2ZaEWNR/5uruIYpfCu/fQpuTG2bPhuO+1
jXGkR4iZLHsHeijEXllLPSOFUMtuqdpPu10rtclYM9gXLDgDxGasdMSkn6MZbm1A
Tj8EPQmque2xnm/YCmqJLE3CsKiknqG6p3DoAaZHS8y1njbvzpAmQ77oinV1XrH2
JyGnqCRwyKIcxuGjeugW2NmUMmQQ3Q==
=D9Fo
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--
