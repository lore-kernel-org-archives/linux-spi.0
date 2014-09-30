From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 0/5] m25p80,spi-nor: Fix module aliases for m25p80;
 clean up chip identification
Date: Tue, 30 Sep 2014 02:47:53 +0100
Message-ID: <1412041673.9388.75.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
	 <1410714795.3040.45.camel@decadent.org.uk>
	 <20140928220300.GB3248@norris-Latitude-E6410>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-af4rIWq8laF++TYmV1B/"
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Lunn <andrew@lunn.ch>,
  Jason Cooper <jason@lakedaemon.net>, linux-spi
 <linux-spi@vger.kernel.org>, Huang Shijie <shijie8@gmail.com>,  MTD Maling
 List <linux-mtd@lists.infradead.org>, Ian Campbell <ijc@hellion.org.uk>,
 debian-kernel <debian-kernel@lists.debian.org>,
 linux-arm-kernel@lists.infradead.org
To: Brian Norris <computersforpeace@gmail.com>
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
In-Reply-To: <20140928220300.GB3248@norris-Latitude-E6410>
Resent-Message-ID: <y_LUHTkTZLN.A.IiH.vvgKUB@bendel>
List-URL: <http://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Id: linux-spi.vger.kernel.org


--=-af4rIWq8laF++TYmV1B/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2014-09-28 at 15:03 -0700, Brian Norris wrote:
> On Sun, Sep 14, 2014 at 06:13:15PM +0100, Ben Hutchings wrote:
> > On Sun, 2014-09-14 at 18:10 +0100, Ben Hutchings wrote:
> > > The first patch in the series restores the module aliases to m25p80, =
but
> > > it does so by duplicating the list of names.  This should be suitable
> > > for stable, but it isn't viable in the longer term.
> > >=20
> > > The following patches change the spi-nor interface so that this
> > > duplication is no longer necessary.  This includes removing
> > > spi_nor::read_id, but it could be re-added after this with a differen=
t
> > > interface, e.g. returning a flash_info structure (which would need to=
 be
> > > defined in spi_nor.h).
> >=20
> > Note that these patch are:
> > - Based on your 'testing' branch
>=20
> Which testing branch? These two are the only official
> repos for MTD:
>=20
>     git git://git.infradead.org/linux-mtd.git
>     git git://git.infradead.org/l2-mtd.git

You had a testing branch in
git://git.infradead.org/users/norris/linux-mtd.git, and that included
commit af249c3a0ca8 ('mtd: spi-nor: remove duplicated w25q128 entry')
which this patch series depended on.

Ben.

> > - Untested by me, aside from compiling and checking that m25p80 has the
> >   expected module aliases
>=20
> Brian

--=20
Ben Hutchings
The two most common things in the universe are hydrogen and stupidity.

--=-af4rIWq8laF++TYmV1B/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVCoLz+e/yOyVhhEJAQq6UhAA0jcXyFfWvhrrztz2B2rSCojXniQy13cs
lIrCKn4afHCMvEviWRnRkwQDd8MyEkpdPwoMMXUEWlBjbBtuw0rDwH6LqJpfg15Y
KRjOh/l1A2vRDMztzkDnD/VyKykQI9kwT5JAMBZzhcUS4LpdHzLppzwEr0lP9hdz
KkI1XxH1DGK4w+PHjoQaRbvwR8GzTUqy25D1hJNF0ACZrkoM+JrLzNUgrJ2h3q7j
VMD15oSwgVjM1888DMbdtfqRcvO9znPoYYTa41WwbYe4nSqpyKMGaUekqyYNQ462
lFLt8uDdfDxpCqVMOvhxhA9aFTgRVeBgo2AsJ0El7jhBXWPO0dympIl8/YisJSoT
775PtOSdBnQdDRpHGYj6qaWzgVCezPUfE2jl/mrKNE38apQ4FCI3vgmejAyyfUNK
Wh/6lzm+/5Q0dJeE/c072bnqe14NXD1fokuAFi16fEApvr4CP0Q0M8En4Yl7hLQx
SDDqU0s4CYB5vmt5q3D9Sn3pkwg5mvosuEKIHcmHJ1/6RE4k45qtk/SWgpUBBY0i
H6xpx/yEUFE8RbUnAq25AMv/XsXzI2iIeKbOKhE99NlKXXmOcFLwhLXGnU3F4rtR
XO4vEa++SZemYrrZodH+CfntlUC5swT1D0tW+Vf8o3aybTF+uZs4MPO2MqzUKkab
beqOz9eaYII=
=Rfr4
-----END PGP SIGNATURE-----

--=-af4rIWq8laF++TYmV1B/--
