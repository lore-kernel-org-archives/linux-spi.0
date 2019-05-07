From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Date: Tue, 7 May 2019 14:07:30 +0200
Message-ID: <20190507120730.5ylk6v4yvzxuzqld@earth.universe>
References: <20190506143301.GU14916@sirena.org.uk>
 <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk>
 <20190507030241.GC14916@sirena.org.uk>
 <CAHk-=wi4EJQLoMNd4ptiiZvLy8ZW49pcCy0VQwZt4xhDDqSOjw@mail.gmail.com>
 <20190507110345.GF14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="apdjlhrolhn33wku"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190507110345.GF14916@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--apdjlhrolhn33wku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 07, 2019 at 08:03:45PM +0900, Mark Brown wrote:
> On Mon, May 06, 2019 at 08:13:49PM -0700, Linus Torvalds wrote:
> > On Mon, May 6, 2019 at 8:02 PM Mark Brown <broonie@kernel.org> wrote:
>=20
> > >                    Everything I'm
> > > seeing is saying that Google just isn't enthusiastic about domains li=
ke
> > > kernel.org which is going an issue.
>=20
> > Well, there are other people who use kernel.org email addresses.  Ingo
> > Molnar, Rafael Wysocki, a couple of others.  But you're the one
> > getting marked as spam.
>=20
> I'm not going to search for rule 36 SPI.
>=20
> > Somebody just hates you. I do end up checking my spam-box regularly,
> > so maybe it doesn't matter.
>=20
> Some spot checks are suggesting that they use gmail as their outbound
> relay which I can imagine they'd like but would break some stuff for me
> for non-kernel.org mail I think, it'd be a major rework to not inject
> stuff via sendmail.

FWIW, I send out kernel.org mails via mail.kernel.org. Konstantin
added that service in 2014. You can get a password with

ssh git@gitolite.kernel.org getsmtppass

and then use the following settings for (example for git):

[sendemail]
    smtpserver     =3D mail.kernel.org
    smtpserverport =3D 587
    smtpencryption =3D tls
    smtpuser       =3D <user>@kernel.org
    smtppass       =3D [randomstring]

-- Sebastian

--apdjlhrolhn33wku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzRdP4ACgkQ2O7X88g7
+prBZw/+KfZqvuSCjDB0CmIEcWFMa7zz9KEU1klbG3ftpHjdKTrbR6lFBX7jkMuW
6658BbTexe8PmoWKg3daBeDw6pbLYy65jeMMKV/P+9loo6rRnYAuiwv6lMSr4uDJ
75VkJTRflXZiTl5j0RTWiJjg53YNpWJ4TxGhtuTsjBzQWG+DgeL4oNINLFcDaS0m
Cfxs6VQnsQJ3PyfBH8+wIaRQNsvfZukVCU25iAC3G9cs/mvnXvrGyjSEg15AsqUR
otao8WId93VwJbZ+2cg9REs/SlnQm0aiZy9pMoNGUl+J+TIlbbyLsz+uwkQph1Nk
+1kxdxCiBjWjZDfXTWpL3+0/1xKfQ6TmZ3F9LLTChGmSdif9qtYjSY61FEkmUBpu
B0yi0Q+LLqzT9QYl3bBcJWLI1GDnEpG3wJ29O6l5B5W+0qt82Sg8WD16BNgdRpEo
BM2hiDVDNAUDdElA7uDvdvTaW3VXTL1/cUqVfcIZF4ZfcEOBYV5w0mriFsfwmatY
pVz506pbRKC8ww4WllcDxIOlwM1rM2QgKvbnd0eO0OeMhFTXRTaMuX2sc4j+SLgG
1dnBnQ/d2jgX84fhdC2KCIvdUp1nJESGsiXnUgcRyaDEQwOu8UERFYvGM6LtQ6Hh
6lGNfIjHX5UWw6a5Mi1FtJm6mg6fpnd4h3EPiu6XWBm5XIGHQoU=
=sj12
-----END PGP SIGNATURE-----

--apdjlhrolhn33wku--
