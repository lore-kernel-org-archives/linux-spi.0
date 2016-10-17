From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] spi: mark device nodes only in case of successful
 instantiation
Date: Mon, 17 Oct 2016 23:07:52 +0200
Message-ID: <20161017210752.GA1681@katana>
References: <20161014193113.29275-1-ralf@ramses-pyramidenbau.de>
 <CAMuHMdUMvjZvwBMUrWTk+obbUYsfRJxPTmdnv7Fz6uzkQ8nbbQ@mail.gmail.com>
 <39e8d53a-a93d-feeb-044f-9b1b239dff21@ramses-pyramidenbau.de>
 <33118B65-9BF4-45AF-AC55-B44BECB5BBD1@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Cc: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux I2C <linux-i2c@vger.kernel.org>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <33118B65-9BF4-45AF-AC55-B44BECB5BBD1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2016 at 10:20:47PM +0300, Pantelis Antoniou wrote:
> Hi Ralf,
>=20
> > On Oct 16, 2016, at 12:55 , Ralf Ramsauer <ralf@ramses-pyramidenbau.de>=
 wrote:
> >=20
> > Hi Geert,
> >=20
> > On 10/16/2016 10:49 AM, Geert Uytterhoeven wrote:
> >> Hi Ralf,
> >>=20
> >> (Cc i2c)
> >>=20
> >> On Fri, Oct 14, 2016 at 9:31 PM, Ralf Ramsauer
> >> <ralf@ramses-pyramidenbau.de> wrote:
> >>> Instantiated SPI device nodes are marked with OF_POPULATE. This was
> >>> introduced in bd6c164. On unloading, loaded device nodes will of cour=
se
> >>> be unmarked. The problem are nodes the fail during initialisation: If=
 a
> >>> node failed during registration, it won't be unloaded and hence never=
 be
> >>> unmarked again.
> >>>=20
> >>> So if a SPI driver module is unloaded and reloaded, it will skip nodes
> >>> that failed before.
> >>>=20
> >>> Skip device nodes that are already populated and mark them only in ca=
se
> >>> of success.
> >>>=20
> >>> Fixes: bd6c164 ("spi: Mark instantiated device nodes with OF_POPULATE=
")
> >>> Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
> >>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >>> ---
> >>> Hi,
> >>>=20
> >>> imagine the following situation: you loaded a spi driver as module, b=
ut
> >>> it fails to instantiate, because of some reasons (e.g. some resources,
> >>> like gpios, might be in use in userspace).
> >>>=20
> >>> When reloading the driver, _all_ nodes, including previously failed
> >>> ones, should be probed again. This is not the case at the moment.
> >>> Current behaviour only re-registers nodes that were previously
> >>> successfully loaded.
> >>>=20
> >>> This small patches fixes this behaviour. I stumbled over this while
> >>> working on a spi driver.
> >>=20
> >> Thanks for your patch!
> >>=20
> >>> drivers/spi/spi.c | 7 +++++--
> >>> 1 file changed, 5 insertions(+), 2 deletions(-)
> >>>=20
> >>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> >>> index 200ca22..f96a04e 100644
> >>> --- a/drivers/spi/spi.c
> >>> +++ b/drivers/spi/spi.c
> >>> @@ -1604,12 +1604,15 @@ static void of_register_spi_devices(struct sp=
i_master *master)
> >>>                return;
> >>>=20
> >>>        for_each_available_child_of_node(master->dev.of_node, nc) {
> >>> -               if (of_node_test_and_set_flag(nc, OF_POPULATED))
> >>> +               if (of_node_check_flag(nc, OF_POPULATED))
> >>>                        continue;
> >>>                spi =3D of_register_spi_device(master, nc);
> >>> -               if (IS_ERR(spi))
> >>> +               if (IS_ERR(spi)) {
> >>>                        dev_warn(&master->dev, "Failed to create SPI d=
evice for %s\n",
> >>>                                nc->full_name);
> >>> +                       continue;
> >>> +               }
> >>> +               of_node_set_flag(nc, OF_POPULATED);
> >>=20
> >> I think it's safer to keep the atomic test-and-set, but clear the flag=
 on
> >> failure, cfr. of_platform_device_create_pdata() and of_amba_device_cre=
ate().
> > Ack, no prob. Let me change this in the next version.
> >>=20

> Thanks for this. This is a very rare case that=E2=80=99s easy to slip thr=
ough.
> It is good to be consistent :)

I read this as acked-by for the series?


--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYBT2oAAoJEBQN5MwUoCm2erUP/3lFGDe/GXFUgzTIhDSSx3ny
PwXc/Oxc3McXzH+n6ncAdxad5E5l0tj4xvP35SiavJVPRxuI53D4uaUvzxzIIzpp
HN0M2PkCCFsrcqPwBu5GOa6juj7DldsFldlgmSMOnesffe2+Ml9M3BWjCVgR/UMh
o06t46KFiuuO4NWMT/qF4Q43r/E0oB8AqdSlY/i5zNrkkzhsF/m+HV0INFnTObXP
+8GrpgygQOd3i2NgsEaHVPnz+cmA8d9pXPPv0EJTbqv182+aUxb3VBJQrszp4ORT
K8acCJZatiE5LNjOoc1/d1ee63qSnzv+dmALhpFWHa4QrlMII8wvJjAbBOeAR6G7
+ZKG9XGaZtGGvPBrP11Ppz5qmjkyj9m89wR4i7RKrgs6VDG5xRXOApfss6d+bAzP
NhsXPxTmUZBAG5tCiFJtL66waFqVom65Le+pycuJNgt8O0TGXuxkCH9674ga0sMz
5IfDfapLZtp3bbFq4ywdq0N2IgkYe2j5fJpRSFrW56eEPG/guPeMUdgF9G29BZIq
EXXtHnEn6ZH5/6LlTbi9acRwqbJh+TwBTgZh6nbqkpjOsD011xcn0gWlFxh3T9Tt
0UDonADwcvXxjKqDPgqUr9s/Gev+kjj0u7Qhj0JINbM3WJE+f2JoNqgkyusmI5Sz
IIEjCH9h1z8FQLOW3Eeg
=y17K
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
