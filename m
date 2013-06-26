From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: add spi controller master
 driver for Blackfin 6xx processor
Date: Wed, 26 Jun 2013 09:28:41 +0100
Message-ID: <20130626082841.GK27646@sirena.org.uk>
References: <1371583828-23788-1-git-send-email-scott.jiang.linux@gmail.com>
	<20130619183928.GE1403@sirena.org.uk>
	<CAHG8p1Dz=PwYQ8Q2ERcAQhpUwjmXfQ5HX6M_wvTezybQ4AB4eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1940810562844070107=="
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org"
	<uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <CAHG8p1Dz=PwYQ8Q2ERcAQhpUwjmXfQ5HX6M_wvTezybQ4AB4eQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============1940810562844070107==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+lkmz3FEiWbOcRWA"
Content-Disposition: inline


--+lkmz3FEiWbOcRWA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 26, 2013 at 01:06:51PM +0800, Scott Jiang wrote:

> This check is in spi_setup, but master->bits_per_word_mask check is delayed to
> each transfer. Don't you think master->bits_per_word_mask also should be tested
> in spi_setup?

Seems reasonable.

--+lkmz3FEiWbOcRWA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyqY2AAoJELSic+t+oim9uFoP/RxnP3xqRxnqkm3/ReO+QHRS
A6HZu4LstWL9vxf4/jwbqKGYFRFNjWnxOpVvDBhtPKOLp6aQ2VqR4mQMP6K/IZug
QVKNXira9JzNjQJlN46S3FjdSlDnzLwp/EKninzau+bleCsBI9s39T6g0EfZ05/D
vejF3jyq9qbVWGcZKHwrTWG4VZeWm87XrHVBisbyQ6knaQUqmYghxrBzmx7X9xID
7cmyGpbFZCTX4b7G8AKxaM8yzc9eNmTGkL4PAFyQNonntdNXKm4OiO0IjjBD5hWW
FUlRc8ypcW35/pU2GTw0kmRgGTYSpdN7CYMOSAxxtj/xGPO/h845a4WTc2F8J+9/
Y7z1zZvFSv03+1GQX0nm4UGv15ivhcCvzdcNLc60GLAPE2opZk7iuw1VkmRCNLw8
z6lxdYMun6aUvo1bl/PD0LrYipvBpALcywOseepu8BUoPcZNxFYuHMfXdisC3nuV
wSzIwBLLmMd7nx5LVEnsTqj83G8TRiiFOXyLERJj13MEeDWqPobDAt4tg4ZTaDvx
osOGUUCKKLhp4rE8ISls2G6LZAxeJZcs8BLj3Fj3OHT6A+wgLnavLbHNXS6+Q+oY
03AOfnIPJ4qaVLqAo5pbOyL+c9hCTyq9vuU+zHbQpRhPSylolAc9XuYVSWALgdr4
Zpit4On86vJdnUA6vGtY
=wZQ4
-----END PGP SIGNATURE-----

--+lkmz3FEiWbOcRWA--

--===============1940810562844070107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Uclinux-dist-devel mailing list
Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
--===============1940810562844070107==--
