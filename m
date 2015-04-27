From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 19:30:36 +0200
Message-ID: <20150427173036.GA10950@lukather>
References: <cover.1430034797.git.hramrach@gmail.com>
 <bb069283a5c2ccfbc05177f1ed41cabb1485796e.1430034797.git.hramrach@gmail.com>
 <20150426103257.GJ22845@sirena.org.uk>
 <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com>
 <20150426110144.GK22845@sirena.org.uk>
 <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org>
 <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather>
 <20150427101601.GN22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150427101601.GN22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2015 at 11:16:01AM +0100, Mark Brown wrote:
> On Sun, Apr 26, 2015 at 02:51:13PM +0200, Maxime Ripard wrote:
> > On Sun, Apr 26, 2015 at 02:38:18PM +0200, Michal Suchanek wrote:
>=20
> > > >> I don't know if it's been suggested before, certainly nobody did t=
he
> > > >> work to make it happen.  I don't think I have a massive objection =
in
> > > >> principal.
>=20
> > Actually, I did it a year ago, and it looked at the time that it
> > wasn't what should be done either.
>=20
> > https://lkml.org/lkml/2014/4/28/612
>=20
> lkml.org is being terrible as usual so I can't see half the thread (or
> at least got fed up trying to get it to load)

A part of it is also here:
http://lkml.iu.edu/hypermail/linux/kernel/1405.0/00484.html

> but I think the discussion there petered out more than anything
> else.

Maybe it did :)

> Or was it the suggestion to make this something that the driver core
> supported so that we didn't have to open code it for every bus?

Probably. That's something I really haven't took the time to look at,
and don't really plan on doing so.

I guess a good way forward would be to revive this patch, and wait for
that generic way to happen.

What do you think of this?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVPnI8AAoJEBx+YmzsjxAgMLEP/AuII2K8XmVq6wytiqgoytbR
tbpvFYai2AP96jNTCsyg605eKRMtIVOMnqCtdToQBSWn1licBR5QdPnARKxScnUN
AiZQGb7zsnvLybc1gSWw83Z3Iw1FKreDyqoTYDuZJ7fCM9fu0V9TfxkjouVa078u
h1FC2ZLOmmOFR8rIanHzHrA4kaI0Xa9QV0h0pMUeJwZlZxfYWFqiBl5i7OnKdfJH
05iT8tGuA8BO8Y43rwlKpzGAFOstVa97I7L9eiJRQTDJgGDtaUMLMNNxXDxWGIVY
jrZxDA/+lnYXydlFPMYr/CabHV3Ixp7b23KlV8dZcWz+YeZuvmK7AvAo+HJ7Vt3M
MNlAh0gzNeF/GqGMegPONqW8YXxBJ0UM+oRrZrecTLjdlMVXyNzDEVqTXGsWgBYm
QaUcBFBwIv62XGpUDPkrh4Xq3K+RThOPte7ZgP3ShlDRoxFHMvvSwwwkUxUEWtL8
9P+IfwZZJaqicv3sSHv4aQYyYkPXxtaw+nPw8oZ78FchLi/KL0hGcjGB5x7akDA+
vZHPuUQY2fd4rFnKZl+2IVGwBF8orIWmBHDRRL+QoJubMVqPJLzIF3GhE5k0cVj3
96PMyIU5xoOI5cmxck/E8uBbnF8+fFL6WSQH0XuxGLUe8AobJJ+nBA/qFHv214M0
TxmVQYtpkORR64L+HjEj
=iafU
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
