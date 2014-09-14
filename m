From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: Re: Autoloading of SPI/nor driver on kirkwood (qnap devices)
Date: Sun, 14 Sep 2014 03:00:09 +0100
Message-ID: <1410660009.3040.29.camel@decadent.org.uk>
References: <1409673299.14324.43.camel@dagon.hellion.org.uk>
	 <1409796689.27524.34.camel@decadent.org.uk>
	 <CAMuHMdWBr=B0_Xivti9K5ReryHHEunQj2P26FjhmzhO-L9t+9g@mail.gmail.com>
	 <20140910060004.GA5732@norris-Latitude-E6410>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-472siJ3+iWte/rNWi9Zy"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140910060004.GA5732@norris-Latitude-E6410>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--=-472siJ3+iWte/rNWi9Zy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2014-09-09 at 23:00 -0700, Brian Norris wrote:
> On Thu, Sep 04, 2014 at 09:02:04AM +0200, Geert Uytterhoeven wrote:
> > On Thu, Sep 4, 2014 at 4:11 AM, Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org> wro=
te:
> > >> I noticed that many platforms declare the flash chip as compatible =
=3D
> > >> "st,m25pXXX" whereas the ts219.dtsi just said m25p128 but I tried
> > >> changing that and it didn't help. In any case without spi-nor.ko bei=
ng
> > >> autoloaded I don't support m25p80.ko ever would be.
> > >
> > > m25p80.c has:
> > >
> > > static struct spi_driver m25p80_driver =3D {
> > >         ...
> > >         .id_table       =3D spi_nor_ids,
> > >         ...
> > > };
> > >
> > > while spi_nor_ids is defined in spi-nor.c.  Since they end up as two
> > > separate modules, modpost can't read the ID table and add the device =
ID
> > > aliases to m25p80.ko.
> >=20
> > Woops. This indeed doesn't work.
> > Note that the MODULE_DEVICE_TABLE() is also gone from m25p80.c
> >=20
> > So m25p80.c needs to contain the IDs, while spi-nor.c also needs the ID=
s
> > because it's a framework/library.
>=20
> Actually, m25p80.c only needs the strings (i.e., the named aliases --
> character data), and for the most part, spi-nor.c only needs the IDs (i.e=
.,
> the identification bytes).

Unfortunately, spi-nor.c also needs the strings to implement
spi_nor_match_id() (which is only used by fsl-quadspi.c) and to report
mismatches in spi_nor_scan().

But spi_nor_match_id(), spi_nor_scan() and spi_nor::read_id should work
with something like struct flash_info, not struct spi_device_id.

> What's more, I don't think that any modern SPI NOR user really needs to
> be specifying exactly which SPI device it is via a specific string. Our
> driver code pretty much always re-detects the device by reading its
> device ID. All the SPI NOR code needs to know is how to read its ID.
>
> > A quick solution would be to move the ID table to a header file, and in=
clude
> > that by both, and re-add the lost MODULE_DEVICE_TABLE() to m25p80.c.
> > That duplicates the data, though.
> >=20
> > Hmm, for the built-in case, we can avoid the duplication by letting m25=
p80.c
> > refer to the table in spi-nor.c if !MODULE.
> > Does anyone see a better solution?
>=20
> A little bit of a shot in the dark, as I haven't fleshed this one out:
>=20
> Would it work to just copy the SPI ID strings into m25p80.c, keep the
> full table in spi-nor.c, stop adding SPI ID string (and DT) bindings to
> the m25p80 table (force platforms to use "m25p80"-compatible probing, or
> maybe something generic like "spi-nor-rdid", "spi-nor-sfdp", etc.) and
> eventually kill the strings from spi-nor.c entirely?

I think that a DT node is always supposed to include a compatible string
for the specific device.  It could also include a generic compatible
string for SPI NOR chips, but the *only* thing a driver can do with that
is to use the JEDEC ID command.  It can't even generically read a single
byte, since addresses may be either 3 or 4 bytes long!  So I think that
if a generic compatible string is defined, the DT binding must also
define the properties that spi-nor currently reads out of its static
table.

> I really don't want
> to propagate string-binding much further into the SPI NOR library, since
> everything should be auto-detectable--partly just by an ID table as we
> have now, but eventually we can use CFI or SFDP parameters provided by
> relatively new SPI NOR chips.
>
> I'm not sure if this is great for the short-term problem of fixing
> module-autoloading. Perhaps we should do a short-term hack to duplicate
> the SPI ID strings to m25p80.c by including them in a header (and
> backport for 3.16.y stable?), but I'd like to disentangle this.

I'll have a go at doing that.

Ben.

--=20
Ben Hutchings
The world is coming to an end.	Please log off.

--=-472siJ3+iWte/rNWi9Zy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVBT2rue/yOyVhhEJAQozTxAAoXgFNaoB+7Tgjm2dh7xiI6iQ0KwWBkmZ
ioUr2XZ+45JT0VAp1tw0F3vyXtsCT5jl30YOuviMX4pz1gZbIvKsuJ7fUlJrV0GF
OSQZemMT901+nThmk3WXS1aJ/uidRsKymrurLh4pk62VaPZHd/NMjzPOX4aG6b5C
FAZC4hbOmJb3YUuVccaqPokP9DYvXJSi5mIzyPdzyLqRcV8B9+ky58C+UQzNjGE6
lExda9I3Hgc17ZICHY67bs+s/v0CZqNjQeNxgbA8vWCqkcBfr88UmUT53C4bxDR2
ALHxP1LnyU+xj9TUGUSWCsu7cfsw+zgpzzDRLjrrYwyJn8UjFB6rsYvJ6h+uOK5b
I2mHooUKDa4z+xFpRuwkvfPzMrG68WGqrpzuw2RI6/H4Cf0kPfKt+iLwCE4we/WZ
xUyvu8BeM2pcqIx2CZC+4NcRlTmTqNI35XoscDREKjDhX1Opk1g8yNrqazm4bgC/
W16e064jGk2bw/7SrCIyAEgs9d+8eVMIFhQSbd3CAASkl2dPHrhc3XgsEHtCDIld
DGN6NxlDyQJStEI5xyIA83O4UBOi4+a46DwcucFinHhUoOBUDUCEWA3biS+x+9na
+2othkwkzDszeImekMKcNvDDFVibApOqU4LLJQbvhf4f7XuIxtRI90qWCQ5qN0ZJ
BDWT5epeVl0=
=IaZZ
-----END PGP SIGNATURE-----

--=-472siJ3+iWte/rNWi9Zy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
