From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 21:41:06 +0200
Message-ID: <20150513194106.GG4004@lukather>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513125102.GA2628@lukather>
 <CAMuHMdWJ730G_a6=vQgs4gV837am5KKd7zEhU2FaHw2cpv=aRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWJ730G_a6=vQgs4gV837am5KKd7zEhU2FaHw2cpv=aRA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 09:10:48PM +0200, Geert Uytterhoeven wrote:
> On Wed, May 13, 2015 at 2:51 PM, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> >> > This also adds an i2cdev-like feeling, where you get all the
> >> > spidev devices all the time, without any modification.
> >>
> >> I2C is a bit safer here since it's a shared bus so you can't do
> >> anything to devices not connected to the bus by mistake.
> >
> > I'm not sure to understand what you mean here. How is SPI different
> > from that aspect?
>=20
> If you talk to a nonexistent i2c device, nothing happens, as it just sends
> a message with a nonexistent address on the shared bus.
>=20
> If you talk to a nonexistent spi device, hell may break loose if e.g. some
> "smart" hardware engineer used the "unused" CS as a pull-up for the
> _RESET line on an external device... It's a bit like banging random
> "unused" GPIOs.

Ah, right. I'm always surprised by how creative the hardware engineers
actually are :)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVU6jSAAoJEBx+YmzsjxAgESsQAIaSfvD6/CGHhYYyy/0tCK2C
JNkmTYiEIgydq+9O3iHYqDFQWbxUtHrr3c9/co8S4xRLjTPAs3ghIEH6vO2AQ8Ov
ctBWq2cnG36/ky4QZOaidjYlUjBGvEXveewSkDhaXuD1FSjiJDmFsEkC+kmRy7ds
hdueiNqlWfJXeHHShc/OTDsaSBl8z6B5WwsTzxVIATjH6zItP8uIY2/JJMZvkWdb
4nuhgHQXgnOunq8wjdgwk4C1eRHHt8EVu76MEpKd5N6Df3eZN8dxC49TLPrem8Ov
uZ+bInBzW9R3b61kP82ZrmxyDJCz4G5RSyp3YQCzfE6b6YhsnQrD5WzMg99/xDEV
3bdi1oZUeYThUKERg1gZFnKd7MqP/pZO7+IY095K3EnfPVvXxJvKb0QdI5ayJa4z
MDJoMnIvpo+hM9mxJfW/oeGWzQ+gLxegijh+XlfzOYSPGnqsksI+Unm3QCjQd5Bd
ALdgga2mWIVWshtNsFMi1kRKTFazCDpoPQRqQKeocZDUAthUrzVxuyGajSU12dp/
vb36XWYT8WlTsPXtg0o0YVNzLJR0W79kbEEEg2nxcRLSD6Uq+4f5x8JH4YWVJK4Z
lvuM4l3Yd08uykXh0I8h0bamHXO4dpj+FHxfS9PbULXkxN0bZnwXWKqmBGcYylXt
pVEdF9IdDwHqZqPKqfrN
=zb6q
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
