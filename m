From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spidev: Fix for reverting spi max speed value only
 on failure
Date: Mon, 3 Jun 2019 16:57:14 +0100
Message-ID: <20190603155714.GY2456@sirena.org.uk>
References: <20190602141959.5616-1-pervivek@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RMorpr61ug7CvG36"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Vivek Pernamitta <pervivek@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190602141959.5616-1-pervivek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--RMorpr61ug7CvG36
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 02, 2019 at 07:49:59PM +0530, Vivek Pernamitta wrote:
> When user space application request for change in spi clock
> using ioctl, current value is taken back-up and new value is
> assigned to spi->max_speed_hz, then spi_setup() function is
> called with new value. If spi_setup() function fails, it needs
> reverting to old spi_max_speed value only in failure condition.

The current behaviour is intentional, we're not modifying max_speed_hz
so we can continue to enforce the kernel limit no matter what userspace
asked for - actually looking at the code we should probably have an
explicit error check in there to reject attempts to raise it here, not
sure why we're not doing that already.

--RMorpr61ug7CvG36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz1Q1kACgkQJNaLcl1U
h9DePwf6A8FaQOvSKwYtjWsoDYPI0DOiaT5U4Sj9v/nmeJeXAjLkg5foaE+aL5MZ
ZGyj4GXTt8jJnQpUDZqJv3FgAHTY5DfpU/cZRumMrSwxy4DwR+pvtH6vSkw0yMlo
Fzb5ZXyLnvEjIqhmYKfjHL2Mj5x1s1OTB//rDuIBDA0NT76HCbX9UUrFWr4BNjh2
5e44KLud+9+g6i4q7r+yz9D/vfzl5dS113R8NvXR90qCv00ulTFfmY4gLWWnegWD
9OykYgC18Z0i0iR3aZhJDCm/lvcbHscmzOYYOOec0r0pSVWwBWXQtOixe64OtbEO
F0Z9w/W75Rcsvbz52HI/ceMOnAgTfw==
=Zr+r
-----END PGP SIGNATURE-----

--RMorpr61ug7CvG36--
