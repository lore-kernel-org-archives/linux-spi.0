From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] spi: SPI bus multiplexer
Date: Thu, 2 May 2019 11:45:24 +0900
Message-ID: <20190502024524.GV14916@sirena.org.uk>
References: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
 <20190412082913.GA6909@sirena.org.uk>
 <d91ab2261a1f4069bc48e090bd4ec702@svr-chch-ex1.atlnz.lc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="worL9B4ITIAQZ1FS"
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tthayer@opensource.altera.com" <tthayer@opensource.altera.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d91ab2261a1f4069bc48e090bd4ec702@svr-chch-ex1.atlnz.lc>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--worL9B4ITIAQZ1FS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2019 at 10:28:16PM +0000, Chris Packham wrote:

> One other problem that I encounter is the interaction between cs-gpio=20
> and SPI_MASTER_GPIO_SS. Having cs-gpio automatically sets SPI_CS_HIGH=20
> which has the undesired side-effect that now my real chip select is=20
> inverted. I actually wonder if this change breaks commit 8eee6b9dd30d=20
> ("spi: Add Flag to Enable Slave Select with GPIO Chip Select.") since=20
> now there is an extra inversion on the CS enable.

That sounds like a framework bug which should just be fixed - we
shouldn't be disrupting users of real chip selects when using a GPIO
chip select.  Depending on the hardware we might need a chip select
assigned that isn't connected to anything for use while the GPIOs are
doing the real work but otherwise we shouldn't be breaking things.

--worL9B4ITIAQZ1FS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzKWcQACgkQJNaLcl1U
h9A8mgf+NUGeTId/vCKU5fgsyKAKgLFNNREzR640DJheAW8jSR+tFvdWIcS+Xzui
wHoMW2SYbEQ9jOoDzhPQKNU9PM4q03Pz3NlbFRkHub9Mz76XQgLzV89K/FvBfOkf
xhh7repFxc81GLG9gTot2SHBOrsHIPz5LkpXK7FgRQJFiemZEdrDpDn6hmZuiK+v
kcU4mVpd7rza0fXLRoOcTCSnwjUU7+leF6zx4VsEqSWZ5Sl8oUy2LlvRqfziRKSg
uvCeyZAn7dYif/78KcjBs5fex/Eb3ac49T85SFAo1GhHPuyQtYJfe2ZxEtz4qrVB
czstXt8yaIV2diO5m+pXnum3mzstaQ==
=ou6s
-----END PGP SIGNATURE-----

--worL9B4ITIAQZ1FS--
