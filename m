From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] mtd: spi-nor: fix DMA-unsafe buffer issue between
 MTD and SPI
Date: Wed, 27 Dec 2017 10:36:09 +0000
Message-ID: <20171227103609.GQ1827@finisterre>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <1514313927.26695.19.camel@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hIO1AjEoFJ7b3ahE"
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "boris.brezillon@free-electrons.com"
        <boris.brezillon@free-electrons.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "radu.pirea@microchip.com" <radu.pirea@microchip.com>,
        "devicetree@vger.kernel.org
To: Trent Piepho <tpiepho@impinj.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1514313927.26695.19.camel@impinj.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--hIO1AjEoFJ7b3ahE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2017 at 06:45:28PM +0000, Trent Piepho wrote:

> Or, since this only fixes instances of DMA-unsafe buffers used in
> access to SPI NOR flash chips, and since there are other SPI master
> interface users, those chip specific fixes in some/all spi master
> drivers are still needed to fix transfers not originated via spi-nor?=20

SPI client drivers are *supposed* to use DMA safe memory already.  How
often that happens in cases where it matters is a separate question, we
definitely have users with smaller transfers that don't do the right
thing but they're normally done using PIO anyway.

--hIO1AjEoFJ7b3ahE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpDd5gACgkQJNaLcl1U
h9AEpgf/RtY0/PG8AYuqJuqcXHvaDEP59zvItyFKdgesM7P9Wu7LNe0mL1F+jPb8
rD+jQ9AY0Ks7Q1wcjx8p8PJQdc25ybQoHrAfPqGtHbxlP7QsmCk1bbFJQ8zElHES
cL969cO2GYxfb/uxpg0+Gl4OPqJs9CTkyzHphGgYZ8fIrbhCMbFmfjnuU4NcRuwF
ODAsdhhWZRN4JxB+JAlpFy9KgSV59I/82alu4QhVuZcsuicDymafDb/Cx3EQ/inO
nsdkp2g0nt4e9CNP6N5UUT6Chbah/oRNT3YMg5Zn3ez8IwmSq9t/82GoxEOYGIty
OKq5AwLtmn2uVDAcJ+cfldZ4yCBGxA==
=8I+R
-----END PGP SIGNATURE-----

--hIO1AjEoFJ7b3ahE--
