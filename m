From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: convert spi-bfin-v3.c to a multiplatform driver
Date: Thu, 3 Apr 2014 22:32:25 +0100
Message-ID: <20140403213225.GZ14763@sirena.org.uk>
References: <1396600037-2811-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5OPIRG5sBUHnKBkK"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396600037-2811-1-git-send-email-scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5OPIRG5sBUHnKBkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2014 at 04:27:17PM +0800, Scott Jiang wrote:
> Spi v3 controller is not only used on Blackfin. So rename it
> and use ioread/iowrite api to make it work on other platform.

Applied, thanks.


--5OPIRG5sBUHnKBkK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPdNlAAoJELSic+t+oim95a0P/A4Xk+MrCDKQ5FMrCRK9vhHh
AbMvoCWA2xrSZ8rs16GrEseIxIK+uE9+BRy4TUmZ5unLGVSJ8zv7ectD5gAbeIgT
LrNHH26d2/nSMvfM3EkYAX3x2tBnvtPIbwkdn7u3OykEknYD/tQrIOgiAUxBjl4c
UEaEB4q1i1/zI584uE7ciEW23IuIY+l+GhwHjUeVuIJKY/dk7jV0M2AqOuQRqg0n
oVyKJzJVvLfK5DzcnHXf2DopsnialbwyF50YvXh9VtbLvdNsdIxzcPS2nXVKZ7DQ
/P3r/J+XYv/dDDYGM3kZO12bqI4QWecpR3jeSk0QkYnqLAtY4cv5QSdXNf1lneHM
hS2TVkooizIIRLjaynHjVkSSpXcAwfHaqZVa7ebVHaVq6urMDc3W1jiBpPkhSn5e
6r5muk/3IWhz+FycggO5xtO5BxsejzTXEtJ1VAIhrdKLsTehFvHcmcKe9YyhECFA
INF0qGcMcY5QADCButyzhv9ZjoTmkGa8zNgD0Mdd6UxvpnVMOR9c7bL6WQxtJBBa
uelDLnKIMl1AAUFzlS0Z15R9r+2te1S+A5sQgbefwO8y2G40fotIoJI3Kh7qYgwb
FrK419LqgPQP/t17/6U/z0eb+yo+VIFW4RJpiDURx2trMB7oMwjPbry4CoACT8TM
Gl1YOsDlQ90644LYnd4K
=mjv2
-----END PGP SIGNATURE-----

--5OPIRG5sBUHnKBkK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
