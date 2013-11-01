From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 3/3] spi: Use stable dev_name for ACPI enumerated SPI
 slaves
Date: Fri, 1 Nov 2013 11:03:50 -0700
Message-ID: <20131101180350.GZ2493@sirena.org.uk>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1383309356-25430-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1383309356-25430-4-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oUI2l+Vq7ILP1REU"
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1383309356-25430-4-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--oUI2l+Vq7ILP1REU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2013 at 02:35:56PM +0200, Jarkko Nikula wrote:
> Current spi bus_num.chip_select "spix.y" based device naming scheme may not
> be stable enough to be used in name based matching, for instance within
> ALSA SoC subsystem.

Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

--oUI2l+Vq7ILP1REU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSc+0DAAoJELSic+t+oim9pjUP/A3CU3qwzt7SqqNPap12rnmU
qDODftHjvUe5f3t94baKnezoHkVEscYMFbNLRAjW4KRB5t45oNmzDhPyQ/ATPnKR
qWa2FYG25o/hWSlvg18m9tIam62A8LpQaub0y1Wf6Kpob2T5aPsSTj7NBg/NY96O
/pW8ZSc4ZTZA/cVp8jtEx+SDfmJ7g4oBu/7L0NLFJYq4dI0uPzZTzPVJIyXVMO1M
CsGvTtctnqzoIJHTXeT2yAzDhVN4wsyaBOIRsmxlRRqpTcM3PGJE1UbjfjADDNo9
O7+65zkNNV+mXXLjzuK1x+W8sVhFM6KqpFiEp963fft7nFjN1BaZrYqV++rh8qx4
XQtl3sCbi8iHkMGKdNhp2As7zP6d1ohXPpJ5VDZOtJJ72Q5zqfgmegPJQa07eI3s
aETW7vmIk/h4UZAX1h4WrJeUMXPtCtip6cFmZGd0ZLIC1itrPJDIemR98kx9Jw7o
4wTILL5Ae5cfWpOmIN+ZnKhwsYWIucNUHSNd6Z2OSF+vLZX69JSimsfq5DOWCU7m
eh9D1Y78vA5GS0ZLnhwzdjsORdiXJVkxwTGT/phhrWCD/UOEey0ZsSahxDbxns0r
EEEBcptqyWtyWbAihNqVbqDgBn9F9AfniefNHxil0iBmEJrahWJB1oasRV0609L9
BYHohzPZp0unq+mF6mC8
=7XG3
-----END PGP SIGNATURE-----

--oUI2l+Vq7ILP1REU--
