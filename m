From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Mon, 13 Jan 2020 14:27:54 +0000
Message-ID: <20200113142754.GL3897@sirena.org.uk>
References: <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
 <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
 <20200110193119.GI32742@smile.fi.intel.com>
 <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com>
 <20200113114256.GH3897@sirena.org.uk>
 <6dd45da9-9ccf-45f7-ed12-8f1406a0a56b@huawei.com>
 <20200113140627.GJ3897@sirena.org.uk>
 <CAHp75VfepiiVFLLmCwdBS0Z6tmR+XKBaOLg1qPPuz1McLjS=4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rnP2AJ7yb1j09OW/"
Cc: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        chenxiang66-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Jiancheng Xue <xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>,
        fengsheng5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        wanghuiqiang <wanghuiqiang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, liusimin4-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfepiiVFLLmCwdBS0Z6tmR+XKBaOLg1qPPuz1McLjS=4Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rnP2AJ7yb1j09OW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 13, 2020 at 04:17:32PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 13, 2020 at 4:07 PM Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Mon, Jan 13, 2020 at 01:01:06PM +0000, John Garry wrote:
> > > On 13/01/2020 11:42, Mark Brown wrote:

> > > > The idiomatic approach appears to be for individual board vendors
> > > > to allocate IDs, you do end up with multiple IDs from multiple
> > > > vendors for the same thing.

> > > But I am not sure how appropriate that same approach would be for some 3rd
> > > party memory part which we're simply wiring up on our board. Maybe it is.

> > It seems to be quite common for Intel reference designs to assign
> > Intel IDs to non-Intel parts on the board (which is where I
> > became aware of this practice).

> Basically vendor of component in question is responsible for ID, but
> it seems they simple don't care.

AFAICT a lot of the time it seems to be that whoever is writing
the software ends up assigning an ID, that may not be the silicon
vendor.

--rnP2AJ7yb1j09OW/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4cfmkACgkQJNaLcl1U
h9C9SAf/QUGxpHCyO2c4xltDoYDcAjrwD0T5cZM7n1f3yKywuxkpNt6pJtFXI0Vy
pHN6G5MnEma6TGY+6gO6mfUwgMeMedj8jy8ZlEhWNWEigXKm09SXXf7cNhz/z27G
UFyxXenpV0xU9839bZ7PfRqgFGhQTOaXCbpqGiL+N9dU0V+jzkpMSL30FJFa8acS
WSMZlt54a1f462AQepyauxqdCJ5/krBwV2/z1xRJ5z0NwlrqqYWWr77AoZP0chuL
mjQWulsjgyUGRN7OIt9S51bHPF82uUg+rYKkNLZGmeAz2jVf1nI73h4T88NTlj9H
msiLxupn8vvcpRM9fc5sYSH6Y0Zmcw==
=y+l1
-----END PGP SIGNATURE-----

--rnP2AJ7yb1j09OW/--
