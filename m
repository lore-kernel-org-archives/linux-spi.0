From: Lukasz Majewski <lukma@denx.de>
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver
 is released
Date: Fri, 27 Sep 2019 00:38:49 +0200
Message-ID: <20190927003849.0c9e4335@jawa>
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
        <20190926121438.655f1f10@jawa>
        <CAMuHMdVBrKnA3TJnOEG0G0FVKf7VwQUvLzkmJc7DAX4kvHYWYQ@mail.gmail.com>
        <20190926144342.327a3c66@jawa>
        <CAMuHMdXm+vUB4iRTsTq64Kg2KC2p7AA1TwFgjc7FuCeiS9EG=Q@mail.gmail.com>
        <20190926160645.0a2623fa@jawa>
        <20190926151752.GU2036@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MWul8reh.Rz47nd.lOSx1tl"; protocol="application/pgp-signature"
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926151752.GU2036@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/MWul8reh.Rz47nd.lOSx1tl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark, Geert,

> On Thu, Sep 26, 2019 at 04:06:45PM +0200, Lukasz Majewski wrote:
> > > On Thu, Sep 26, 2019 at 2:49 PM Lukasz Majewski <lukma@denx.de>
> > > wrote: =20
>=20
> > > > The question is if we shall call the spi_slave_abort() when
> > > > cleaning up spi after releasing last reference, or each time
> > > > release callback is called ?   =20
>=20
> > > TBH, I don't know.  Is it realistic that there are multiple
> > > opens? =20
>=20
> > I'm using on my setup only one test program to use /dev/spidevX.Y
> > and /dev/spidevA.B (loopback with wired connection). =20
>=20
> > However, you also shall be able to connect via ssh and run the same
> > setup in parallel... =20
>=20
> It doesn't seem entirely realistic, but I can imagine cases like
> fork()/exec() where we end up with two copies of the file open
> but end up immediately closing one.
>=20
> > > That means the abort is called only for the last user.
> > > And only if the underlying device still exists.  Which means that
> > > if it has disappeared (how can that happen? spidev unbind?), =20
>=20
> > In my case, I just disconnect some SPI signals and the test program
> > just hangs. I do need to ctrl+c to stop it (or use timeout).  =20
>=20
> > From my debugging the .release callback is called each time the
> > program is aborted (either with ctrl+c or timeout). =20
>=20
> Should be on file close IIRC.

Any ideas on how to solve this issue?

Maybe, it would be sufficient for now to move the spi_slave_abort() in
spi_release() before we decrease (spidev->users--) the use count?


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/MWul8reh.Rz47nd.lOSx1tl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl2NPfkACgkQAR8vZIA0
zr021wgAiv7whL2JbgJhEsGJ7+wE8+VstDmdil3dJj2370tZ1TV6dToiTi/UcAIt
ivYET/WG1RxKE0W58RfOvjo/D24kad2MT+RIujWZoWyu3kVVyGOpS1cQe6QUocXx
jXiCRBavxoCn9CEFOmJZ/ypxea62I4gKFQ/VAeGuJJLBCNQnuzZAcAADPfQMKkCj
l0ZYOLF6yQbz47gRdgHxuunPpUDjqw9sdlc7Hv2zMEcW021bi4pYni9Hb6ZAeIJ9
geoh0ep5tWNoS8Vvw+TuG5jGOigRDEazqX1X8uVuRVa1wu3B6wXLjMMwBSUC2rE9
sUS5ctBukWrLZndmHt3CiYIaDz1Rmg==
=nmDF
-----END PGP SIGNATURE-----

--Sig_/MWul8reh.Rz47nd.lOSx1tl--
