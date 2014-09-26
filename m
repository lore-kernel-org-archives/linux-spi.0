From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm53xx: Fix module dependency
Date: Fri, 26 Sep 2014 09:13:32 +0100
Message-ID: <20140926081332.GY27755@sirena.org.uk>
References: <1411712311.23531.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dwN3S3mscniL3FCL"
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411712311.23531.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dwN3S3mscniL3FCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 26, 2014 at 02:18:31PM +0800, Axel Lin wrote:
> config SPI_BCM53XX needs to depend on BCMA_POSSIBLE and select BCMA.
> This fixes below build error:
> ERROR: "bcma_driver_unregister" [drivers/spi/spi-bcm53xx.ko] undefined!
> ERROR: "__bcma_driver_register" [drivers/spi/spi-bcm53xx.ko] undefined!

Applied both, thanks.

--dwN3S3mscniL3FCL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJSArAAoJECTWi3JdVIfQIhkH/3wAK+FBqnKogkkuISYFU7bP
BvkQ1YE0xl/e9wbXvzTzZ614Bd/b8I8zAEvXrCUSb64yfDFj6hW9FRq10QIOoKJK
0waYF9NYWK1QP3+T1nHrULLSH4m/kcNIggRlYsObu6avcBPcOu/bDDBLsvBWVMS1
5LcWfxUQdxZ1mg0bCkeCo9ZTGV0ypsFZE2m0UkUj28FN5/AJXBuo4/k5mF+CYJ44
PDvuDlTyWGICCWRu/lXkzXD0MsQEjIPLrD8XaOdZYEd1tzacNRSS8ioHVq011DZM
wAD6i0599k/p678wLUo94S87R6dp3AglgZsiM9bMsrxMSDZJI0txIu4m3THRi3Y=
=rTBP
-----END PGP SIGNATURE-----

--dwN3S3mscniL3FCL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
