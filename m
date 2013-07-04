From: Mark Brown <broonie@kernel.org>
Subject: Re: SPI : DUAL/QUAD support
Date: Thu, 4 Jul 2013 10:00:49 +0100
Message-ID: <20130704090049.GJ27646@sirena.org.uk>
References: <CAHSAbzMGqQgCLL9ymQ6qSeJRybv2jJfm-sbzZVgayVyKYgufLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1823085700866186687=="
Cc: grant.likely@secretlab.ca, spi-devel-general@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: =?utf-8?B?546L5a6H6Iiq?= <wangyuhang2014@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAHSAbzMGqQgCLL9ymQ6qSeJRybv2jJfm-sbzZVgayVyKYgufLQ@mail.gmail.com>
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


--===============1823085700866186687==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mqabeeRFEDQfpoIl"
Content-Disposition: inline


--mqabeeRFEDQfpoIl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2013 at 03:07:31PM +0800, =E7=8E=8B=E5=AE=87=E8=88=AA wrote:

> Now some SPI controllers and Slave Devices have supported
> DUAL and QUAD transfer mode. But SPI controller driver in kernel
> has no member to deliver this information from Slave to Master.
> So in my opinion, adding transfer mode members to deal with the problem.

You'll need to tell us what "DUAL" and "QUAD" modes are and provide some
kerneldoc for the new fields.

--mqabeeRFEDQfpoIl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1Tm+AAoJELSic+t+oim9owwQAJ14oNu1NoWmkr4tHLQOD/W9
N3HcHzRkbomjk098ZqmyBaW1tYC5+sGOdDKrcgNMQbnX5jUhghxArw3LGJ5bRcr4
5xK7sPdU1/PlXYEhb2WcwMYtxhlbz+WhDVCoerpDeuamF45FtjdSvkflViPC8phC
1mrtFd09D2Yrtv94bmCIl2qbGlEg7fS+wZsUhtQmKM+xejw7jCPhPoxHGdsILCAN
tAjxPOgTbobKw2lbkJJtDf7wthZ5e9JbroiwrqQjl71BBV5Ch9qHvCD8xx4h+FVA
vrTHigBfZHs729TNbOmLLFuELRA64rBnRPH+/QTy4FcYKodzSqipjeHO+E1zGa4D
TFL1P/bYlSFIW6HVmnBkHTXvADDvNSC90OQJ6KfG16/vjuFPum2ahqzLtwsLE8Dj
/6qNrbtvQrSzhjTZNbrefF/eo2on44FftMpksSQwhKaU8As7wrxJCPl3poxusaB0
e4NMLZssJ0RJ+tU1yGDYUUa05S1u6qxpeCddmZMJ6/s77UenaaTGsm4QJglbIbmP
djxxyXJa9MQjraEEGBmz8imCabl4DomCQ9bfF85mx88APQo53q9IYJkDyB4+dDbo
m49gGHfgVxIJRUHjEM5sY/lEyJhIyu7BN6o6JzvXePt76VAaF/Dg+V2zphrpNqXC
nynWeNuYM9cpTDpoCEAr
=CsKC
-----END PGP SIGNATURE-----

--mqabeeRFEDQfpoIl--


--===============1823085700866186687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============1823085700866186687==--
