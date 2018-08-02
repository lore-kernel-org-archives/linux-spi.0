From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v2 5/6] spi: Add QuadSPI driver for Atmel SAMA5D2
Date: Thu, 2 Aug 2018 11:17:42 +0100
Message-ID: <20180802101742.GF9117@sirena.org.uk>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
 <20180627131609.13681-6-bugalski.piotr@gmail.com>
 <20180801172747.GJ5509@sirena.org.uk>
 <20180801215733.4dfa3a95@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Cc: Piotr Bugalski <bugalski.piotr@gmail.com>,
        linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <pbu@cryptera.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180801215733.4dfa3a95@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 09:57:33PM +0200, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:

> 2/ Getting this patch [1] merged and implementing the ->get_name() hook
>    in this driver so that SPI NOR devs declared to the MTD layer keep
>    the same name after the transition to spi-mem and mtdparts=3D passed on
>    the cmdline keep working. Without this in place we're likely to
>    break a few setups :-/.

> [1]https://patchwork.kernel.org/patch/10508693/=20

I don't seem to have a copy of this patch...  not sure it was sent to
me?

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlti2kUACgkQJNaLcl1U
h9BcOAgAgAz5lMpc2flvBJhdnlT29tzROXqSpM6wz1kpJM0vXKIBnD1f+CVqWg5x
isd9zCSCYinC8A8qNtC8KeRZNWDWsuSc0oiizuFp8G5Nf/ep6iIoxlKV8FMwmOVm
DITz7SZUqd/Ej1peuGNsE3/3dGd2sT0TKnjrrJT7ZjAjfH4OwfWkUS9lshgp0H+y
l7HDz5Z5JAmEkkCbe97AHnZQv0jths9imXVpaAJJl6uYRkxM3zIAp6vRKf71MSSz
ubaV2h3gejoYUviXa6zp4+o373AwNwSV/2JSV93wt4ogLkuECl3PMTzm74d+jlJq
vRr2BQqeV9RkMdcDJmrV27AxH4TvsA==
=R9Tx
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--
