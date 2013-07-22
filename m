From: Mark Brown <broonie@kernel.org>
Subject: Re: support DUAL and QUAD[patch v1]
Date: Mon, 22 Jul 2013 10:33:42 +0100
Message-ID: <20130722093342.GJ9858@sirena.org.uk>
References: <CAHSAbzP0Nc1ahf_ra6yDuMvV998_+EGcUOGDv5ifKaagYf+NOg@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9E84D2@DBDE04.ent.ti.com>
 <CAHSAbzMDOWo5oBqUHqMxybuDwUjFbczYwN+85gH+rxZ9z8u2Pw@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9E851E@DBDE04.ent.ti.com>
 <593AEF6C47F46446852B067021A273D6D93B49E1@MUCSE039.lantiq.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9E85D0@DBDE04.ent.ti.com>
 <CAHSAbzP5jqHwCm0qhu=DiNzpP0swqWHsQ0=MnF+EKaSN22E5hg@mail.gmail.com>
 <CA+7tXihoZZhpoyvxj58c+Zi-Zy631kK5s-kDoSxPKq=ej0qyvA@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9E967D@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5423557569479053209=="
Cc: "thomas.langer@lantiq.com" <thomas.langer@lantiq.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, "Poddar,
 Sourav" <sourav.poddar@ti.com>, Trent Piepho <tpiepho@gmail.com>,
 yuhang wang <wangyuhang2014@gmail.com>
To: "Gupta, Pekon" <pekon@ti.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9E967D@DBDE04.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============5423557569479053209==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QPZaqi6af6gbSrAE"
Content-Disposition: inline


--QPZaqi6af6gbSrAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 19, 2013 at 07:34:45PM +0000, Gupta, Pekon wrote:

> > Maybe it would make more sense to have a spi-rx-width and spi-tx-width
> > than can be set to 1, 2, 4, etc. bits instead of a bunch of properties
> > that are mutually exclusive?  Sooner or later someone is going to want
> > 8 bits.

> Then it would not remain a serial interface (Serial Peripheral Interface),
> rather it would be more of parallel memory like interface.
> And you would not like to use SPI controller for it, instead you would use
> On-chip General Purpose External Interface controllers (like GPMC)
> because it gives you more options to tweak and configure.

It's still not beyoond the bounds of possibility, and of course some
bright spark might decide to use 3 wires.  Unless it's expensive to do
so in some way it seems better to keep the interface as generic as
possible even if we've no expectation that some of the flexibility will
be used.

--QPZaqi6af6gbSrAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7PxzAAoJELSic+t+oim93zMP/iaSGf2AwMeCLjtodncJwdlT
2J1tksjA4Cssv6Mdr1IZZTnP/5pbnP3WzTzJImHl9HrNAz7RDSBRm0VowUmZu0Ss
kB5wKwEfuKTz0Xb8Oc65hEKG6rVWQDf9DY4/7sp92NDvke7BwjWW8NtP50W58bj9
UN4uQFe/EwjaS4WjcIQ5tqLYXdHAXMo19U3JDR44QyhVuvsThDAoxRhGu02v21cE
QkTF6zvOP6SO9T8TN2NIoD8JUrMX+QMzRqJbYMkvjp9es/74gyYJU+vRNUf3sBwL
AliYZut7XQG+33CBqShlGsD6Y/ELBJ5LIyCDbKMf1FZkW/+kVu+WstRjmyvjvdKI
Tyfl9Uz1drmqsCBIrOIabwVboMsvwY3zjWZx4Fg3CLGUnGt8KpMX2vb8m6CVtHHj
a55KCZ8XG1J7pziwG+pYPOy3vwJB/caa1Bcublp5VE7Pxt4OB5TteptxH9NXG/F7
EdjBxzK4giv5dSj8OR4SWm8bGuAoXzp+rJYVCPR9Bxywloo7mhyEChGNgkrW9Orl
0Xch5SCAqe7isHDICEhEGNn0m7QuvbHOAVhE5HrnAhJZlUIJBIu/2ZSBH3tz1bR6
W1+myS7DFQ8xFjUNVxjAtnFcBeAM/YV12/x+chP7CuDvauuWfLD48NDL+MJgQijd
/oToHw/iqMJ7K+0rfmXs
=sv+M
-----END PGP SIGNATURE-----

--QPZaqi6af6gbSrAE--


--===============5423557569479053209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============5423557569479053209==--
