From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Fri, 10 Jan 2020 14:07:26 +0000
Message-ID: <20200110140726.GB5889@sirena.org.uk>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Cc: marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org,
        linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, fengsheng5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org,
        chenxiang66-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
To: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <df67b562-7d82-19f6-7581-680190a7772d-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 10, 2020 at 11:55:37AM +0000, John Garry wrote:

> I will note that PRP0001+"jedec,spi-nor" compatible DSD seems to be the
> defacto method to describe the SPI NOR-compat part for ACPI - that's what
> I'm using. We could add properties there, but that seems improper.

OK, so that's just reusing the DT binding in which case everything
that's valid for the DT binding should also be valid for ACPI - I
thought that actually worked automatically without you having to do
anything in the code but ICBW.

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4YhR0ACgkQJNaLcl1U
h9CHqQf/fT6tkZc5rjRON7HtRrGsmNaUJN8ElUARXmp+zfbAka7ozgwC4DENqjOK
I9Of3xZsrE2VlGeIpXS7KAkjdbCOvoRmMhChM1VH7yF5lxz+AEOjWwKZlfXpurjM
RxElFm6u7Z9iiP0PDww9K+yEXS91EbxPFi7UvRL783aV3VJORsP9aY7ewmXSb9UP
E3SLtAQQMhQrwrMS7jGd3tex9ik6YdXOqChEsaScE7GDjvGUDNS54yYXK1lfCPHi
yKq7WymCtC2pgoVQxmQloHBzk82z6wMSwVp+DowO1eM3qbdevM6UVKniyJLDT5pN
EEDzuxOjUXvHls2lGkGX9YdKUFFLhw==
=lFqO
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
