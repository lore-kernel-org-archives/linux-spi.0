From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Writing SPI flash driver for Broadcom BCM53xx ARM SoC
Date: Sat, 16 Aug 2014 17:33:15 +0100
Message-ID: <20140816163315.GX28623@sirena.org.uk>
References: <CACna6rzhD9=Pkb5gRqd9A23gfaqnHmYe_vm0fwT_mefAibmhYQ@mail.gmail.com>
 <20140802020036.GR3711@ld-irv-0074>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sL7C0a98p/u5aVah"
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Andre Renaud <andre-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>,
	Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140802020036.GR3711@ld-irv-0074>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--sL7C0a98p/u5aVah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 01, 2014 at 07:00:36PM -0700, Brian Norris wrote:

> You can probably write a pure SPI driver (drivers/spi/) that uses only
> the MSPI hardware to do (slow, single-I/O) true SPI, and hooks into
> m25p80.c.

This seems like a good first pass at any rate, it's uncontroversial and
at least functional even if slow.

> But if you want to integrate the accelerated BSPI for reads, it gets
> harder. You might be able to export a kind of 'lock' API from the MSPI
> driver, so that a BSPI driver can utilize the MSPI for most
> transactions, but then lock it down when doing BSPI/read operations. I
> think with a little bit of work, spi-nor.c can accomodate the right kind
> of callbacks to allow you to do this. But the coordination between
> drivers/spi/<MSPI> and drivers/mtd/spi-nor/<BSPI> would be the hardest
> to architect, I think.

Right, I think we'd need something that allowed the MTD controller to
take ownership of the device, lock out other users and then do what it
wants with the controller.  If we provide a way for the SPI and MTD
drivers to get hold of each other and pass around the underlying device
we probably don't even need to architect the interface too much, we can
just say it's a private arrangement between the two drivers, given that
I don't think we have a good picture of what a standard interface would
look like and the hardware seems to have a reasonable amount of
variation in how things are split this may actually be the most tasteful
thin we can do for the time being.

--sL7C0a98p/u5aVah
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT74fIAAoJELSic+t+oim9bhAP/3+R5/tY9jm+awrweAXldKuh
qN2Q1r+huRkr5NwvY+Md5GJLkWMza9D19qMC8qdAVBKHTVeR/1iWdhHqCV7KBOwU
/8JqgYhObao1EcT0ZUvpXnYf2kkX0P6eEQ02gMNYxfyw+R8idDirwup5AON0sqxy
ezC9ohFhfM09q98HMjbsTGGmvgFBekzseBYJEpZX4k/XhE5KZy9iPvtqXx+vxyZf
d5iIU+r1MSfch5Ldbbc0DxIdrcPI3i1oImUqHmEHYLqhwmxUaLdyWqII/MZwcOtB
GJewmozxE/1uNkaqW9W6C1HPz9egf4tQKFH7qTBYz9htbogLy3ymvCSFn0AeOgIR
eGpdIB5UUjQZYMvqI12b7v9c98XqmnwIwxjvviDh0IMA+ua0d60YBmfTdUGmPjF8
YAGbqkOQIpNVkqzjCiIxuDj3Y3lNNO4AO7+PNJT2QgGs7EqiarYFVOJll/cF7UN1
HN6WtGiE7UsA93mEBra+G19Omw0wzg/u6vlVtIMBuiKBTZiAhSNtockzk1gU6kYR
hjPYvRLN77vwBFSNxc7PbL9fKoXJO2E/6oCbrksV8cHiUj8gzHNqu6PSXOlfVc1A
pI7to7aFMeTu9aa5d8ocOFTSQ5x5IQImYSj0CkfQ/hRJAcytRx70x2QCX1QcXwtq
PHtgUy7+bvbgRFE/hpcd
=IKL5
-----END PGP SIGNATURE-----

--sL7C0a98p/u5aVah--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
