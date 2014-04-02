From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1] spi: convert spi-bfin-v3.c to a multiplatform driver
Date: Wed, 2 Apr 2014 19:19:04 +0100
Message-ID: <20140402181904.GA14763@sirena.org.uk>
References: <1396511250-344-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396511250-344-1-git-send-email-scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2014 at 03:47:30PM +0800, Scott Jiang wrote:
> Spi v3 controller is not only used on Blackfin. So rename it
> and use ioread/iowrite api to make it work on other platform.

This is OK but doesn't seem to apply against my spi-v3.15 tag - can you
please check and resend?  For simplicity it's probably best to wait
until v3.15-rc1 and send a patch against that.

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPFSUAAoJELSic+t+oim9KqkQAJzn+xnNA5UjIoJ74c0X/4zH
O8gG0WyTzikbEF+kg7x4azsGnXiWMgRr1p86C2tyG12B/1iWhbzOvbIw9cZiMn6/
JV1EIGwVLHsvr0vRgTfnJ+dwBwRNk1Iuj/8H8m0pPkgbwC4sDnSti4tmWlp+AjOV
itLDcF3F0RzRnNE5NlNpqECqIBRBflhc8MQBwBBsWlvvwTZysEgSmYq33OZ67VR7
HK1+xI3Ro1JA7AGj9CglFFi23iUpEs84Jq9zbZi6n2a7QDubN7UfhShBI2hPmvnh
lF6OwLkMd+BYqJob60iDYcHqXb7EQrlLgqja7arIU/l6IsMYRHkBqGiYsnPLidUx
hads3XvAZaXq1vp1sncj2LbqEVyt+0JkdVmQgbiNbkmtZyM2EbAUngG2lxm+x60N
n7h/DC2bL8pVZgCfn8x0BRytH4EYfLQ8Kli2mWa8+80RGalmVjXFScaiZxL0QarV
i97616Mc/1yyb6jXmS9GTSzw4ECbUEUb74hfITob5bpzxseNKHI4Z+YbD0Mq4rjq
L/PtlN+mSj8L6c/RkcDy3k+WhecLS/zgoSnYQ5hp/UdWwdejM0859+zqouWgphQu
CMFwAA0weNsG2OLmumht5+L2lskh6RIEIESL+ukxPMLppSWmAs+m+kn5xl4U9avd
VR4boAuCHApikuwdR5Qr
=j3Pg
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
