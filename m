From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: modalias for OF-declared I2C/SPI devices
Date: Mon, 14 Aug 2017 10:20:38 +0100
Message-ID: <20170814092038.ddo76bcfz3vh7sld@sirena.org.uk>
References: <20170811081429.GA9957@wunner.de>
 <1fcd1d99-39ca-6db6-51fc-148c84f66297@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vzh6mqtvlrn6qfhd"
Cc: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>,
        Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
        Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>,
        Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
To: Javier Martinez Canillas <javierm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1fcd1d99-39ca-6db6-51fc-148c84f66297-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vzh6mqtvlrn6qfhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 11, 2017 at 04:11:51PM +0200, Javier Martinez Canillas wrote:
> On 08/11/2017 10:14 AM, Lukas Wunner wrote:

> > The reason I came across this issue is that module autoloading fails for
> > drivers/gpio/gpio-74x164.c as it only declares an "of" MODULE_DEVICE_TABLE.
> > I was going to upstream a GPIO and an IIO driver, both SPI-based, and was
> > wondering what the current best practice is:  Should I only declare an
> > "of" MODULE_DEVICE_TABLE or should I also provide an "spi"
> > MODULE_DEVICE_TABLE?

> That's a question for Mark Brown. My opinion (since I'm not a maintainer) is
> that you should add a SPI device ID table and export it as spi:<foo> aliases
> until this is properly fixed.

Declare both.  Apart from anything else not all the world is DT.

> The correct way to fix this is to move this into the device model instead of
> all subsystem types duplicating the same uevent logic and requiring a table
> per each firmware interface. But that's a much bigger task...

Yes.

--vzh6mqtvlrn6qfhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmRa2AACgkQJNaLcl1U
h9A6QAf+I2VEnk2MMNzyTrORsxwgr2lDcpwsAKioYpAnsJTzwiT/TofpdejKK2k9
61i9irsIAFkc8N1qAGs3ReEnSq8gucqFd1pG2BzdhpSIAhEXF4Rlj7Q4m+sbAI0a
N7Cm7sbo9A4o4IGR9zfufHnr9CKoYFZQyjWd5wguo2bf5c6Ck3CLRTh6nv608Q/z
HC0treKWGqozIDbh0OLw5ge14FnBAWmjMFecSYLSETj1ai2kFvBYKFagFaoUuBDX
LZCY90p/tY5/Cyb7cl2voawFL6Hu+Z5v/0tcCpDi3qH08claa4gm1cpP17SZm/df
MT3LwDNa0SHY60zDcvfvHcEiA5ORkg==
=wf6e
-----END PGP SIGNATURE-----

--vzh6mqtvlrn6qfhd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
