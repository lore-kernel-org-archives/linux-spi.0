From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] spi: sh-msiof: request and set cs-gpio direction to
 output
Date: Thu, 1 Sep 2016 12:08:07 +0200
Message-ID: <20160901100807.GD2893@katana>
References: <1468832259-26476-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <CAMuHMdWb4PngmRa+U=4x1Nq8s+ehWu_ZSTvSzovPs9ngeKhK-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWb4PngmRa+U=4x1Nq8s+ehWu_ZSTvSzovPs9ngeKhK-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2016 at 02:09:03PM +0200, Geert Uytterhoeven wrote:
> Hi Ulrich,
>=20
> On Mon, Jul 18, 2016 at 10:57 AM, Ulrich Hecht
> <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Required for the CS signal to actually be visible to the device.
> >
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> Thanks, I can confirm this indeed makes cs-gpios work with MSIOF on
> Koelsch, hence
> Tested-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

This one doesn't show up in renesas-drivers. What about V2?

Thanks!

>=20
> > ---
> >  drivers/spi/spi-sh-msiof.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> > index a7934ab..d4b5772 100644
> > --- a/drivers/spi/spi-sh-msiof.c
> > +++ b/drivers/spi/spi-sh-msiof.c
> > @@ -536,15 +536,35 @@ static int sh_msiof_spi_setup(struct spi_device *=
spi)
>=20
> Is there any specific reason you don't do this in .probe(), like spi-efm32
> does?
>=20
> >                                   !!(spi->mode & SPI_LSB_FIRST),
> >                                   !!(spi->mode & SPI_CS_HIGH));
> >
> > -       if (spi->cs_gpio >=3D 0)
> > -               gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH)=
);
> > +       if (spi->cs_gpio >=3D 0 && !spi_get_ctldata(spi)) {
> > +               int status =3D gpio_request(spi->cs_gpio, dev_name(&spi=
->dev));
>=20
> devm_gpio_request()...
>=20
> > +
> > +               if (status)
> > +                       return status;
> >
> > +               status =3D gpio_direction_output(spi->cs_gpio,
> > +                                              !(spi->mode & SPI_CS_HIG=
H));
> > +               if (status) {
> > +                       gpio_free(spi->cs_gpio);
> > +                       return status;
> > +               }
>=20
> ... or even better, devm_gpio_request_one(), as it allows configuring dir=
ection
> and initial level in one go.
>=20
> > +
> > +               spi_set_ctldata(spi, (void *)spi->cs_gpio);
> > +       }
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXx/4HAAoJEBQN5MwUoCm2V/EQAJ0V5Hkb+tBLilPBfNE/NYeV
u/AiI2lTnekvG04VvHc7OHYJYBspfcoQZ6nrtqtr7+C1NrzR0J0AQPtoBAKb5u9p
hD7sXuBzFZk8mtVeGS/QKwZBuAyknaFucbl4T6mFWP5CBpKXvMOycy9n7gxHZzRj
+qtE68EGin8gSxP+c+f5pxoXGxbamRSTIkv6Wng1QlC60KxiBH/EJURMvtkaQITR
cVFD8QtJAn3CxhG75LLrJjaLSX2ty5eax6PfBGx+iiZh/MNHaIhlSqaN5D/ZlFfj
x/7NJjfiEBDeQC+fbCRAFZXye2h1cXrG/DM3OfHEb9ubQKUA/ufPUJKEOKlDXwEX
eHwH/1EKL9DY0tjWNIP+LeTrbaNWGyE/L9g/qFTETrnn0VgHE1d9a7fQCPl/8z4E
/OenBsFbhmWiZ3Ij49qUpKng6oG4nPr9uSoE3PYfSfjsqm90QbWTpf0SuT1ekSSP
UFsBGyg5EG1xhjzvpVrOyANkYvRfB6XSOHWs3cMFD5JMVMi+E6b3sKAMUCQB5D2i
R+pm41twge792JqoRyy7CXuhRCnCeI9SaEc40IzzB5Kb0L17N9pInBvoLCRzvo8w
Cbtho+qNm97ubhnvrQgoPqpB5LbuDhXqdr9J3YSXkgSmH04irQJeJZ9q3nxipai/
YF06XosR/ZtKecu9TYdc
=KU13
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
