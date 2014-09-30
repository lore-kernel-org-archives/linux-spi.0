From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 5/5] m25p80,spi-nor: Share the list of supported chip
 type names again
Date: Tue, 30 Sep 2014 02:50:40 +0100
Message-ID: <1412041840.9388.77.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
	 <1410714708.3040.43.camel@decadent.org.uk>
	 <CAMuHMdUs+7uidcD6tivnq6+TbD4_piixLVqwuSa0Z1u3sF7EoA@mail.gmail.com>
	 <1410793627.3040.61.camel@decadent.org.uk>
	 <CAMuHMdVSYvUh3qVRhw15KmOn0MYocbJVQBr9TkHtebM19c8dJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-o25/WjVznYUAh0NXkN+y"
Cc: Brian Norris <computersforpeace@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>,  Jason Cooper <jason@lakedaemon.net>, linux-spi
 <linux-spi@vger.kernel.org>, Huang Shijie <shijie8@gmail.com>,  MTD Maling
 List <linux-mtd@lists.infradead.org>, Ian Campbell <ijc@hellion.org.uk>,
 debian-kernel <debian-kernel@lists.debian.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
In-Reply-To: <CAMuHMdVSYvUh3qVRhw15KmOn0MYocbJVQBr9TkHtebM19c8dJA@mail.gmail.com>
Resent-Message-ID: <ZWtgiP02oZO.A.0sH.HygKUB@bendel>
List-URL: <http://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Id: linux-spi.vger.kernel.org


--=-o25/WjVznYUAh0NXkN+y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2014-09-17 at 10:23 +0200, Geert Uytterhoeven wrote:
> Hi Ben,
>=20
> On Mon, Sep 15, 2014 at 5:07 PM, Ben Hutchings <ben@decadent.org.uk> wrot=
e:
> >> >
> >> > +#define __SPI_NOR_ENUM_TYPES(c_id, str_and_c_id)                   =
      \
> >> > +       c_id(at25fs010)         c_id(at25fs040)         c_id(at25df0=
41a)  \
> >> > +       c_id(at25df321a)        c_id(at25df641)         c_id(at26f00=
4)    \
> >>
> >> Can't you just have the IDs in a header file only, and let the header =
file
> >> generate either a struct flash_info or a struct spi_device_id table, u=
sing
> >> a macro defined by the file that includes it?
> >
> > How would we match up the rest of the struct flash_info to the name?
>=20
> Ah, you use the enums to match the names to the rest of the flash_info.
> But you can do it in one-shot, can't you?
[...]

I know, but I didn't want to expose the data in a header file.  As other
people consider that a lesser evil than this rather complex approach,
I'll do it the simple way.

Ben.

--=20
Ben Hutchings
The two most common things in the universe are hydrogen and stupidity.

--=-o25/WjVznYUAh0NXkN+y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVCoMcee/yOyVhhEJAQpUcQ/9Gzjr+giicDSQT+2MCjtU1CO+fwg1+Dwo
J+IPQRVvVPwqW7lWVPM89U01GNA15ewmodYZIzE4VPd2V8HdfvCohXqwaRtOFDHb
1RWYyBiptHq1CbmnwgxVOxELWNNgNfrY323iXqPw79kxR53N15SfCRpncXLADi6e
dERgrikXkropbM2tCt48iV2xmdxYE8JIWqCXxJ6Gubld24xpf6mEtSFPPDnuWcae
nIn0xrKapux5yKpBxqoOEQyxaAlOXrftMa6gCYEo6INUh1i9RxNYsf79zhOyoZBc
1Yax73PUBv5fmnuG4Ov3n0FG9BbehMgdY80qI9GRRd4kq8RBGZ/YJqhmeCEEc7c3
9ESd1PA8T+HK4ppbkV1rCxAKCYFXymMbJvWR/+joNbip0pgZFlyCb3lKVp3RLKxr
FD2QdCmT+rLfslMg/QS74yI3pKbnPvnFr48gaTBmwUG9vfNfQ1Qps3ry0MAkA5kR
6wXUZ9Fqzzi2KQMhF0NPRt5E2XoKBveehXguf2CAI2OEILgv4dEUYkiTEglcsydI
Lf1vXZIJdMtkJA06NW5QNSFv76mXrkD20c4ynkntu1PFH0klQkZrqmtC5aMm40Do
UtXPngevAV91BjJDyo1aNRsJ+xReBu9sNZLcmtFGM3Wb83pDcNNeaN+SZsoCt0df
3SzrkNhkiUs=
=cGtu
-----END PGP SIGNATURE-----

--=-o25/WjVznYUAh0NXkN+y--
