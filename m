From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: fix possible NULL dereference
Date: Fri, 11 Sep 2015 13:25:13 +0100
Message-ID: <20150911122513.GT12027@sirena.org.uk>
References: <1441883893-20596-1-git-send-email-sudipm.mukherjee@gmail.com>
 <55F2C4F4.3090704@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eYwrjeFR5b5I2bsF"
Cc: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55F2C4F4.3090704-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--eYwrjeFR5b5I2bsF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 11, 2015 at 03:11:32PM +0300, Jarkko Nikula wrote:

> Actually this fixes a *real* NULL dereference case but it is not related to
> normal open/close life cycle of spidev. It requires that spidev is kept open
> when SPI master is removed.

> spidev->spi is set to NULL in spidev_remove() and it is called before
> spidev_release() in case master is removed while spidev is in use

> It would be good to update this to commit log, add a tag below and Cc
> <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

> Fixes: 9169051617df ("spi: spidev: Don't mangle max_speed_hz in underlying
> spi device")

The patch was already applied :(

--eYwrjeFR5b5I2bsF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8sgoAAoJECTWi3JdVIfQXwQH/2P4lB56Wdq0SR0Cjd/oUR0X
fdeB0JkEebpEpIq1PcOArBjaqUvbNz/pClefAxTglZGpUR6pq8BvmWWJ4Mhinvmc
Scy3oixD2QNgheurfeBdyX+diMCuXbRpRAi0fiZ8pL3iG3JHVjsbOs6LuYHNWLOT
8jHjxckKmtP/3Le8wcUOzXI1AKsWBP+hRFX8D5wHukpLtwwGiJWjzwUbwAltsq8s
daPJK5GMKZupzqkOwen5sZtg6ncIxTbr/XeqcQrbPutXuFaPVm1I/Xt7aiEEi5Nt
jCYojFAh1r5L8l+cMsWDz5ocUVHfpH5goDKiHwD2gqxfRRwAztsMRK9NrPbvSMU=
=9B6H
-----END PGP SIGNATURE-----

--eYwrjeFR5b5I2bsF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
