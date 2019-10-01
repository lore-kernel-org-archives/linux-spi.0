From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH] spi: Avoid calling spi_slave_abort() with kfreed spidev
Date: Tue, 1 Oct 2019 11:34:20 +0200
Message-ID: <20191001113420.032dbfef@jawa>
References: <20191001090657.25721-1-lukma@denx.de>
        <CAMuHMdWHTaPkzTdzz-j1rFeT=aAEG+J46fgKiPYrXoAR_DTvtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/_NuMKD1CeMwaipxVqIJqYmB"; protocol="application/pgp-signature"
Cc: Mark Brown <broonie@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWHTaPkzTdzz-j1rFeT=aAEG+J46fgKiPYrXoAR_DTvtQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/_NuMKD1CeMwaipxVqIJqYmB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for a very prompt response.

> Hi Lukasz,
>=20
> On Tue, Oct 1, 2019 at 11:07 AM Lukasz Majewski <lukma@denx.de> wrote:
> > Call spi_slave_abort() only when the spidev->spi is !NULL and the
> > structure hasn't already been kfreed.
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> Thanks for your patch!
>=20
> > --- a/drivers/spi/spidev.c
> > +++ b/drivers/spi/spidev.c
> > @@ -600,15 +600,16 @@ static int spidev_open(struct inode *inode,
> > struct file *filp) static int spidev_release(struct inode *inode,
> > struct file *filp) {
> >         struct spidev_data      *spidev;
> > +       int dofree; =20
>=20
> bool?

It may be bool, yes - I took this "int" from the original code (further
down in the patch), as I've moved it a bit up.

>=20
> >
> >         mutex_lock(&device_list_lock);
> >         spidev =3D filp->private_data;
> >         filp->private_data =3D NULL;
> > +       dofree =3D 0; =20
>=20
> Why not initialize it at declaration time?

I wanted to have it protected by mutex_lock() above. However, this also
shall work with the initialization at declaration time.

>=20
> >
> >         /* last close? */
> >         spidev->users--;
> >         if (!spidev->users) {
> > -               int             dofree;
> >
> >                 kfree(spidev->tx_buffer);
> >                 spidev->tx_buffer =3D NULL;
> > @@ -628,7 +629,8 @@ static int spidev_release(struct inode *inode,
> > struct file *filp) kfree(spidev);
> >         }
> >  #ifdef CONFIG_SPI_SLAVE
> > -       spi_slave_abort(spidev->spi);
> > +       if (!dofree)
> > +               spi_slave_abort(spidev->spi); =20
>=20
> Can spidev->spi be NULL, if spidev->users !=3D 0?

No, it shouldn't be.

The "dofree" is only set to true (the spidev->spi =3D=3D NULL condition is
checked) if there are no references (spidev->users =3D=3D 0).

The if (!dofree) prevents from calling spi_slave_abort() when
spidev->spi =3D=3D NULL and spidev is kfree'd.

>=20
> >  #endif
> >         mutex_unlock(&device_list_lock); =20
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/_NuMKD1CeMwaipxVqIJqYmB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl2THZwACgkQAR8vZIA0
zr2dgAgA1S92SIco0K0aIQNe2B7Yy06PATAG039pcQIraWn4LPI1Ya7e7bwWJKHL
cB7ovrdc/ej+hoi2qfL2Pp0jyGeGAuysIRq2XRrP7O+ApaIwJuMU3rjQdsMDA/tD
z6grGAizrX+KnrpQRBIAVp+YDsvf34MEvQbPAefTaS8CQ9ynGrAV5SOBCcTEG5+o
PpK6WHAC8jstOjlObA5vzlR6vZUl17s5WulIJTUIHC267fFcMhiO8XRRQuvrWt+0
LiqdKUSWLexvX78BuJtcg9h+2FFDQMZU0ag2YSwpg5dY9wVDjiIq/ntgYVRBm3nA
pIVLYoErJUNMh9NEdFr540X8x5aE8A==
=BMNC
-----END PGP SIGNATURE-----

--Sig_/_NuMKD1CeMwaipxVqIJqYmB--
