From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Dynamically adding SPI buses (was: Re: [PATCH v8 0/8] Device
 Tree Overlays - 8th time's the charm)
Date: Fri, 27 Nov 2015 13:24:41 +0000
Message-ID: <20151127132441.GS1929@sirena.org.uk>
References: <CAMuHMdUPa6YMa98v+qXMnxeMZ41AKFY1ni12rJewSEnqSB7TRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5UN41tlPsqEEbq75"
Cc: Michael Fiore <mfjord02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>,
	Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUPa6YMa98v+qXMnxeMZ41AKFY1ni12rJewSEnqSB7TRA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5UN41tlPsqEEbq75
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2015 at 02:06:41PM +0100, Geert Uytterhoeven wrote:

> (replaying to an old mail, as I'm seeing the exact same behavior with cur=
rent
>  overlay code)

I don't seem to have this mail...  I'm not even sure that mailing list
archive does (at least

   http://thread.gmane.org/gmane.linux.kernel.spi.devel/18597

anyway).

> When adding an SPI master device node to DT, or changing its status to "o=
kay",
> of_register_spi_devices() will scan for SPI slaves, and will add all of t=
hem.
> Later, the notifier kicks:

>     static int of_spi_notify(struct notifier_block *nb, unsigned long act=
ion,
>                              void *arg)
>     {
>             ...
>=20
>             case OF_RECONFIG_CHANGE_ADD:
>                     master =3D of_find_spi_master_by_node(rd->dn->parent);
>                     if (master =3D=3D NULL)
>                             return NOTIFY_OK;       /* not for us */
>=20
>                     spi =3D of_register_spi_device(master, rd->dn);

> Woops, this fails, as the device has been added before!
> Should the code just check for the existence of the SPI slave first, or w=
ould
> that cause problems when just modifying an existing SPI slave node in DT?

Looking at the I2C code it seems like it's using
of_node_test_and_set_flag() to check for OF_POPULATED before
instantiating, doing that manually in every place where it might
instantiate a device and manually clearing when deinstantiating.

I have to say I don't entirely understand the logic behind how this
stuff is supposed to work, it's confusing to me why we have separate
dynamic and static instantiation paths in the first place or why this is
open coded in the buses.  It seems like a more robust thing here is to
always use the dynamic path even on static instantiation, or to move it
more into the driver core.

Ideally I'd like to see the I2C code factored out into the DT core but
otherwise probably we have to cut'n'paste it.

--5UN41tlPsqEEbq75
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWWFmYAAoJECTWi3JdVIfQ16sH/39UmlyUxLJKoepUttqg/+hC
G9QxyRRmhbBxpgWY0wOsMOvm/TYQ59RKZAlgziO33Qo9U0AnE5seHlyxT851ogJz
SUQNFO9fvBulgyr810tRzqZ3KhSJ+j4uzcX/bxCPYqToB4m5gMgWOzMkMR8mSgfu
wSlDe1vdAGxEymdJqbV+6LDINkxRRDoEm9PqekWRazaXIOYuRrcE8uNbafqAwL5x
4hJITbkKlCwqKGJtvLamD6iEXC0cY60PEFfVr3evYZSpYSrm8hpw7Q1fEVnMyYk2
tp7+vXTDoKh+JKcCOt51QoiTjQogf8lujseZbgZkialgNeu2z2ijphXF2/czpLc=
=cgv3
-----END PGP SIGNATURE-----

--5UN41tlPsqEEbq75--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
