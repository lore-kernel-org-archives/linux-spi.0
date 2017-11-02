From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
Date: Thu, 2 Nov 2017 15:14:39 +0000
Message-ID: <20171102151439.6dpfud7a5vtc27dy@sirena.co.uk>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-2-tpiepho@impinj.com>
 <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
 <1509469061.5473.16.camel@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jfacq4arwzkkv6bl"
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "fabio.estevam-3arQi8VN3Tc@public.gmane.org" <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1509469061.5473.16.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jfacq4arwzkkv6bl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2017 at 04:57:42PM +0000, Trent Piepho wrote:
> On Tue, 2017-10-31 at 11:19 +0000, Mark Brown wrote:

> > Do the native chip selects actually work usefully on this hardware?
> > There used to be problems with it wanting to do things like bounce the
> > chip select on every word which made it extremely difficult to use with
> > Linux.

> Still are annoying, but on the device we have connected to it, it ends
> up working as desired.

> I've not thoroughly investigated this hardware to find the details.=20
> IIRC, the designware SPI on Altera SoCFPGA had the same issue, but it
> was a flaw in the driver and I was able to fix it.  I've come to expect
> it, as every new SPI master I use doesn't work properly in some
> different way.

It's one of the reasons why I'm suspicous of making the GPIO optional,
lots of chips use GPIO chipselects because a lot of the breakage is
confined to chip select handling and I remember the i.MX as being
especially far from useful.

--jfacq4arwzkkv6bl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln7Nl4ACgkQJNaLcl1U
h9AhaAf/aHlfFuDpdMqTMBZZKtOnl5YcclHZYjX+zgaasmV3WTA/YgVxuYayrPRb
EcDRfE0Vv1lqgwr6OCCkLXcrE9vizCdQeYBtMRxtfd6DiZLcpF5lgAjdpgChPzse
7OL+ttl81qlozzxoO0l+jscNwhL+JQO5seQcrT2VyROZPUEPvUvBYIEIDv8YREV5
zNy8zProqRIxOmHuPFYsXnu4ZZ/9RVzgROjUaHadBsqXe12VLIYlXgqP/lpbsX6P
x/AoN9Xn7tnuHyihVjEieAvdEnz+yM2kENNFWxSoF+Z28WfelPI+N5T7QnAEL5ti
8QE7UvZFRwHxqVE9LaE8qy8pQVeo7g==
=KdlQ
-----END PGP SIGNATURE-----

--jfacq4arwzkkv6bl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
