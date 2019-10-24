From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Fix NULL pointer when setting SPI_CS_HIGH for GPIO
 CS
Date: Thu, 24 Oct 2019 20:32:25 +0100
Message-ID: <20191024193225.GM46373@sirena.co.uk>
References: <20191024141309.22434-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0+35XlDF45POFHfm"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "kernelci.org bot" <bot@kernelci.org>, stable@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191024141309.22434-1-gregory.clement@bootlin.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--0+35XlDF45POFHfm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 04:13:09PM +0200, Gregory CLEMENT wrote:
> Even if the flag use_gpio_descriptors is set, it is possible that
> cs_gpiods was not allocated, which leads to a kernel crash:
>=20
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
000
> pgd =3D (ptrval)
> [00000000] *pgd=3D00000000
> Internal error: Oops: 5 [#1] ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.4.0-rc3 #1
> Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> PC is at of_register_spi_device+0x20c/0x38c
> LR is at __of_find_property+0x3c/0x60
> pc : [<c09b45dc>]    lr : [<c0c47a98>]    psr: 20000013

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--0+35XlDF45POFHfm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2x/EgACgkQJNaLcl1U
h9Dc+Qf7BOBELW73o6MOZxD5Uq2/Eahp26z5rN7PMc+EvRwda/BzHGhUTsTrotmX
ppdm6tsBosW3dH8P6tbwXIIJHO11BO4ma/pbO5ZZloEqeo3Zvxt89+AxZD4roa26
GEnDMWLNn2Y3L0YENJzNelC3RMBY7sIv7wMgiGZR7qadTFrx6Y3v+VLAEEEsSnA6
f3AmuiyCWtiNyuhi1gIst/hGeDzLyNOGVJuNfH7SV4RbQVN51k9Cam5JEaBB6NjK
PTKDGt0u2CGaKQxTZRHb8al+SznFqEk0eKU06KEWpdcPJAOPW24cLVXl2YAb6b2l
yg1Wz4gE+9D908qKFUl3e+fimC6N+A==
=pES0
-----END PGP SIGNATURE-----

--0+35XlDF45POFHfm--
