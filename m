From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] spi: mark device nodes only in case of successful
 instantiation
Date: Sun, 16 Oct 2016 11:32:01 +0200
Message-ID: <20161016093200.GA2017@katana>
References: <20161014193113.29275-1-ralf@ramses-pyramidenbau.de>
 <CAMuHMdUMvjZvwBMUrWTk+obbUYsfRJxPTmdnv7Fz6uzkQ8nbbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Cc: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux I2C <linux-i2c@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUMvjZvwBMUrWTk+obbUYsfRJxPTmdnv7Fz6uzkQ8nbbQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 16, 2016 at 10:49:11AM +0200, Geert Uytterhoeven wrote:
> Hi Ralf,
>=20
> (Cc i2c)

Thanks for letting me know! Adding Pantelis to CC, as he is the original
author of OF_DYNAMIC. Please keep me in the loop.

>=20
> On Fri, Oct 14, 2016 at 9:31 PM, Ralf Ramsauer
> <ralf@ramses-pyramidenbau.de> wrote:
> > Instantiated SPI device nodes are marked with OF_POPULATE. This was
> > introduced in bd6c164. On unloading, loaded device nodes will of course
> > be unmarked. The problem are nodes the fail during initialisation: If a
> > node failed during registration, it won't be unloaded and hence never be
> > unmarked again.
> >
> > So if a SPI driver module is unloaded and reloaded, it will skip nodes
> > that failed before.
> >
> > Skip device nodes that are already populated and mark them only in case
> > of success.
> >
> > Fixes: bd6c164 ("spi: Mark instantiated device nodes with OF_POPULATE")
> > Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Hi,
> >
> > imagine the following situation: you loaded a spi driver as module, but
> > it fails to instantiate, because of some reasons (e.g. some resources,
> > like gpios, might be in use in userspace).
> >
> > When reloading the driver, _all_ nodes, including previously failed
> > ones, should be probed again. This is not the case at the moment.
> > Current behaviour only re-registers nodes that were previously
> > successfully loaded.
> >
> > This small patches fixes this behaviour. I stumbled over this while
> > working on a spi driver.
>=20
> Thanks for your patch!
>=20
> >  drivers/spi/spi.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index 200ca22..f96a04e 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -1604,12 +1604,15 @@ static void of_register_spi_devices(struct spi_=
master *master)
> >                 return;
> >
> >         for_each_available_child_of_node(master->dev.of_node, nc) {
> > -               if (of_node_test_and_set_flag(nc, OF_POPULATED))
> > +               if (of_node_check_flag(nc, OF_POPULATED))
> >                         continue;
> >                 spi =3D of_register_spi_device(master, nc);
> > -               if (IS_ERR(spi))
> > +               if (IS_ERR(spi)) {
> >                         dev_warn(&master->dev, "Failed to create SPI de=
vice for %s\n",
> >                                 nc->full_name);
> > +                       continue;
> > +               }
> > +               of_node_set_flag(nc, OF_POPULATED);
>=20
> I think it's safer to keep the atomic test-and-set, but clear the flag on
> failure, cfr. of_platform_device_create_pdata() and of_amba_device_create=
().
>=20
> Shouldn't of_spi_notify() be fixed, too?
>=20
> The same issue exists for i2c in of_i2c_register_devices() and of_i2c_not=
ify(),
> which is what I had used as an example.
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

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYA0kQAAoJEBQN5MwUoCm2uSUP+wWykxXtk7O6m8UTA08IyZqw
p5zcfIjcjlIam1kzVgH3b0TGq2wMtGvlhQ733Odsiqklk22KRBpmfKEA3+bQxfac
4eAUwjr6kMPPcCrv4L3d0HVZfIk6lAAiI6AovvTaN4XwLRRXarannjHcU0gcyWNk
k+vk5zP6hlPfdjl8gGMCWMsI/DFx6RpErmuFhitnZ0e4lYRsWRzZdAFcEx3ItsLA
h9CF3U+DMVCiSVL8fEAZ9Y6DdDeW7aZkD1gqosc9GLbog6lZchrywilrhupP12xI
QvkggP6f9bxWSkWRAVYIWRbGolGc9dUWVHFE1Y94WTIu2SV+sW2Tiv4nPwOuNydY
HXKmgU7sltzdPRl9/54t60jkXHVGnMBNMCi/XmkjTiUoZSPWqDJCh7XGQ/iqemmx
D6Uw8RJqmbO7bNDNh7KKzQPF5K5A/Y7F1LSZbmBB+4O0TC+7b2fORFvdOOiAlFOr
eZmY8SsfupRNQfe9IcUCrPGtTMCB5xDmb9JC/s1vSAq6pUz4Bfl2GYNNCjUak0d9
mI0hp6DBX64EfyXJzpRzk3ruWymaVmqOOresKEm/+vNjjMQMPrNhGB6DKC080qUW
NNUmcVAoFmG9EKwtKeInMz44rsqwI5I5lIjnzFdqZ7lSG3vC9TKntGManjdKtoRo
y1sWKklswTR1vwQmhmKx
=57vD
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
