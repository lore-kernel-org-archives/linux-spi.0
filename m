From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH 5/5] m25p80,spi-nor: Share the list of supported chip
 type names again
Date: Mon, 15 Sep 2014 16:07:07 +0100
Message-ID: <1410793627.3040.61.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
	 <1410714708.3040.43.camel@decadent.org.uk>
	 <CAMuHMdUs+7uidcD6tivnq6+TbD4_piixLVqwuSa0Z1u3sF7EoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-TysYJ8PDZuh+4UPQ7+no"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUs+7uidcD6tivnq6+TbD4_piixLVqwuSa0Z1u3sF7EoA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--=-TysYJ8PDZuh+4UPQ7+no
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2014-09-15 at 09:55 +0200, Geert Uytterhoeven wrote:
> Hi Ben,
>=20
> On Sun, Sep 14, 2014 at 7:11 PM, Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org> wrot=
e:
> > Move the list of chip type names to spi-nor.h.  To avoid putting all
> > the chip type information there, we define this list as a macro
> > SPI_NOR_ENUM_TYPES() that invokes another macro SPI_NOR_ENUM_TYPE()
> > that must be defined to expand each name to whatever form it's needed.
> >
> > In spi-nor.c, use it to define enumerators, then use the enumerators
> > as indices when defining spi_nor_info so that we cannot accidentally
> > use a name that's not on the list.
> >
> > This is somewhat complicated by the fact that some names include
> > hyphens.  SPI_NOR_ENUM_TYPE() therefore takes separate string and C
> > identifier parameters.
>=20
> Thanks for doing this!
>=20
> However, the table generation still looks overly complicated to me, with
> too much duplication which needs to be kept in sync.

It does need to be kept in sync, but the compiler will check that.

[...]
> > --- a/include/linux/mtd/spi-nor.h
> > +++ b/include/linux/mtd/spi-nor.h
> > @@ -198,4 +198,76 @@ struct spi_nor {
> >   */
> >  int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode=
 mode);
> >
> > +#define __SPI_NOR_ENUM_TYPES(c_id, str_and_c_id)                      =
   \
> > +       c_id(at25fs010)         c_id(at25fs040)         c_id(at25df041a=
)  \
> > +       c_id(at25df321a)        c_id(at25df641)         c_id(at26f004) =
   \
>=20
> Can't you just have the IDs in a header file only, and let the header fil=
e
> generate either a struct flash_info or a struct spi_device_id table, usin=
g
> a macro defined by the file that includes it?

How would we match up the rest of the struct flash_info to the name?

> Cfr. include/uapi/asm-generic/unistd.h and its use of __SYSCALL()?
>=20
> Or am I missing something (e.g. this is impossible due to the hyphens in =
the
> names?).

Well the hyphens are only a problem because we want C identifiers.  But
we only need C identifiers so we can enforce that each struct flash_info
matches a name on the list.  If you can find a way to match them up
without having to define enumerators, that would of course be
preferable.

Ben.

--=20
Ben Hutchings
Make three consecutive correct guesses and you will be considered an expert=
.

--=-TysYJ8PDZuh+4UPQ7+no
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVBcAoOe/yOyVhhEJAQrmGw/+NF+SlqoVI91TRgnUY8OIZbuzb+8EcLOM
FagJz6PvzyqehMHzAs/QOcWMdfOvt1X4fcvIvokimrD0YqaAmvRZfcxqgW24Oql8
mhW5FtnpihqcITkL0i6A5AXEw7X6xHL9lZyLNO/tzhrfDXaYTqHU/754DyCpXn47
s3l9hYujI01tyD0Fi15N00xtaH7EE142oalMYdV1mUESeNV433LNcEXtZC5N/CE8
I1CJKzvIodAaBw5UeBp046wi+E9PdwTuZ2y2dLx7RXUVHZL8HjhsLtIq36jsQVH+
IigVHtjX6yKqM7yB4kfabMHswAOEUIwuWAainloQGZj0e0Cjz8hbMNXKIYWl5ry6
xAkD7qYF59peq8n2NBfErOeBfSC0McRef8pyduNLVAlKKHOE08P8T+Rq0DCuapkm
OluNGQojTa08KQkGiB1hgn9vziZ6jz+kxO3nmxuHPHodxy/ohEZPOBVihGuYjjJn
PFtXr4VbBc4Sv7X/2eb8objEnPo0DgOKAWhhkalvWi/V/d+ecZd8BQpgcfhTHA5I
eVQ0jbWOBY7hKhEQERPikBEW4GKkvIYOGp3NFrHeg/b/6MObrwWPA7NX1S57K7gq
60ODlhUvN2b0fUIxoAEtCH/pVQQwluMT+b0/yX6/PF0gthZpetT8NzRj5VijjS1J
5pymVjrYKsU=
=G1LT
-----END PGP SIGNATURE-----

--=-TysYJ8PDZuh+4UPQ7+no--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
