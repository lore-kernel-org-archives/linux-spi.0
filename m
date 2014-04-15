From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] spi: sirf: fix spi full-duplex DMA transferring issue
Date: Tue, 15 Apr 2014 10:26:09 +0100
Message-ID: <20140415092609.GJ12304@sirena.org.uk>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
 <1397457001-5266-6-git-send-email-21cnbao@gmail.com>
 <20140414200628.GX25182@sirena.org.uk>
 <CAGsJ_4yO-LGJEkpNy=dizQWjSE3pHEBOrrPndho3jt1_YMRvHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yO-LGJEkpNy=dizQWjSE3pHEBOrrPndho3jt1_YMRvHg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2014 at 09:43:24AM +0800, Barry Song wrote:

> i felt strange too at the first look from internal gerrit. qipan told
> me there is one:
> drivers/spi/spidev.c

OK, that needs fixing.  That code predates anyone doing DMA.

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTPsuAAoJELSic+t+oim9fSMP/1yrJ5jC9L9KdoLZn0GFNQ/M
p4cEQ4LV4wj2XSIeivRY0palnT1SjGAfTyrPXRKhGLAgwbbItRwbTuXLU7yjNPwc
QkipcTPVRWTd9k68u9fF+nsNl7KfAFDRdcNU1q/nKCU5IpZpeA1jmUGA8pYcDU6o
34d/++6MNduBYDt71b+5KdlCwTWEvW9XF5AQwemiFUzyQGmVsAcHjQYLyh4Z4/c3
/liQkjZxrq3DzKz3KTMudxz0JprEw74NdzV62AkgFfij6OSdh/gksG4BWVR/Zqxd
vg1J0fAZaJYYKkJO0l2ij8r5/6k8GQPl+vgq0qBygVDWkMF45phfU+T0H6ZSG4iq
OKnWOWfDV6NtAnGSLzTiGwVbBfofR5cvOuJxbHspRXHMmJsjNVOy9Zvfz1J+Rddu
d8/2h0CA+2dwU32s0kes7/7ifdkvbmK/KwB9YOcz3o5aM2gHTO3KZlDqFr8CmEb3
WHN84Nh9CtCyExqxHTMYJo+9DE+YYoX33aZCjLT8S7YGq/gz4VbkLJbCQxuzogBV
iTztRwH6R1qX+wdw60hQ6t2UUGbs99aWYyyZaxGWr3S/zQeGMnmKa/l77gKsVl1N
Y+Uva5RegE2lix5IVqYhmwgpNuwA3iyK0O0WyR+R7ffNdm3ofkzzqsHKDCeDvBqH
sf/0+X7uGgXrg6EIv0lx
=eaCK
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
