From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH 1/5] m25p80,spi-nor: Fix module aliases for m25p80
Date: Tue, 30 Sep 2014 03:07:38 +0100
Message-ID: <1412042858.9388.79.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
	 <1410714670.3040.39.camel@decadent.org.uk>
	 <20140928222150.GC3248@norris-Latitude-E6410>
	 <CACna6rx=GyZ-4JpDix==WKszABseQXK6qCCkfiKCm9-WzBmM3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-TGD2hr4wdnDCdzrlBjhd"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACna6rx=GyZ-4JpDix==WKszABseQXK6qCCkfiKCm9-WzBmM3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--=-TGD2hr4wdnDCdzrlBjhd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2014-09-29 at 08:36 +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> On 29 September 2014 00:21, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> > + Rafal
> >
> > Rafal has been looking at the same area of code. I'd really like to get
> > this patch into 3.18 if possible, so the more eyes the better.
>=20
> Thanks Brian.
>=20
> I took me a while to follow this issue, too bad I wasn't subscribed to
> the ML earlier. Let me try to sum it up.
>=20
>=20
>=20
> 1) The main urgent issue: broken auto-loading
> Tracked in the thread: http://www.spinics.net/lists/linux-spi/msg01726.ht=
ml
> Problem: m25p80.c references spi_nor_ids (from external file)
> Short-term solution: duplicate IDs in the m25p80.c
>=20
> Ben: just like Brian, I think the patch like this one (
> [PATCH 1/5] m25p80,spi-nor: Fix module aliases for m25p80
> ) is the way to go. However few comments:
>=20
> a) I don't see why you modify m25p_probe in it.

Because spi_nor_scan() requires a struct spi_device_id with the
driver_data field pointing to a struct flash_info.

> b) I don't think the described clean solution (you described it in the
> commit message):
> > A clean solution to this will involve defining the list of device
> > IDs in spi-nor.h and removing struct spi_device_id from the spi-nor
> > API, but this is quite a large change.
> is the correct one. I think there should be a single string to trigger
> m25p80 load and the rest should be handled using JEDEC, with some
> workarounds for incompatible devices only.

That certainly makes sense for Linux-specific platform data, but I don't
think it works for Device Tree "compatible" strings (see
<http://mid.gmane.org/1410660009.3040.29.camel-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>).

[...]
> b) Removing spi_nor::read_id
> https://patchwork.ozlabs.org/patch/389073/
> Ben: I think this one has a NACK from me, because I'm going to use
> custom read_id in the bcm53xxspiflash driver.
> See following thread for bcm53xxspiflash description:
> http://comments.gmane.org/gmane.linux.drivers.mtd/54578
> Initial commit (it uses read_id): https://patchwork.ozlabs.org/patch/3819=
02/
[...]

But it has to use spi_nor_match_id() because of the driver_data
requirement.  This just illustrates that the read_id operation doesn't
make sense as currently defined.

I accept that there will be a need for a read_id operation, but I think
it should fill in a struct flash_info rather than requiring every chip
to be described and named in spi-nor.c.

Ben.

--=20
Ben Hutchings
The two most common things in the universe are hydrogen and stupidity.

--=-TGD2hr4wdnDCdzrlBjhd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVCoQb+e/yOyVhhEJAQpF6A/+MXs/U4zzD52X7l9D2bdNSDHmRhEX5M8f
zVzjqD98YQ1e8qzcVKL6UGoKvK4aNR9vrqP2HY9MFpCFlSpw8O63qibui+gM/uOu
02WtSP8sKBc/Drl7SCIkK/VuE13lypb52ms8YI9nvoiAVXaxEhyeKletTd8JS7ea
fBg93Pg8YO394qg9RSevVEyLca06WKfEr+kMoQG7+D7znL9z7Jcf3C+TO1iyJMtN
lQdJQKlE1pcacKNJpNoiXOWBp2xrtjrSJT5ouZsyEdtmhuAK9nfkPdurzh9DGpsI
cE8M8MkrCWS6PzVMQAfIlFZvzVI3s7dSgZqCN+fcfOkCQ0pcKdSfYs4YSxr9M7Xm
fmJW4D3gqFYNvJloLNSsyYmFBr/2/re6oZVsMBmnACIlxJx3NFoXzhhhJRITMJ9v
C8Qfwz5GBsn/9LLHKa+I/yAi6bxY8YqGYJfeIexEbb6hKwi5R1sTZ578L8kDQ3nE
/A3pUYpKDLTzgOc8UeJYQ1WgRzXLG41u0v+aazfxFnWJ3miIa7muLDSHWwK2go0j
8Jhi5nrXnfjrfWTwVndmQvctXun0uIfOJ5IkhFA0kRbMd+e6RPdFCy9UFJydMhkJ
I7m7rvYm8nE+Gg9RUnj/QUYB5FMr8S9NW+y71lsF1Sxbclu+yFW+vpqe6RXwofXx
dI+6z7ZYGWg=
=pU5k
-----END PGP SIGNATURE-----

--=-TGD2hr4wdnDCdzrlBjhd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
