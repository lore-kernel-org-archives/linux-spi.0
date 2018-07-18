From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] spi: dw: fix possible race condition
Date: Wed, 18 Jul 2018 11:51:12 +0100
Message-ID: <20180718105112.GF5700@sirena.org.uk>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-2-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Cc: James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180717142314.32337-2-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2018 at 04:23:10PM +0200, Alexandre Belloni wrote:
> It is possible to get an interrupt as soon as it is requested.  dw_spi_irq
> does spi_controller_get_devdata(master) and expects it to be different th=
an
> NULL. However, spi_controller_set_devdata() is called after request_irq(),
> resulting in the following crash:
>=20
> CPU 0 Unable to handle kernel paging request at virtual address 00000030,=
 epc =3D=3D 8058e09c, ra =3D=3D 8018ff90
> [...]
> Call Trace:
> [<8058e09c>] dw_spi_irq+0x8/0x64
> [<8018ff90>] __handle_irq_event_percpu+0x70/0x1d4
> [<80190128>] handle_irq_event_percpu+0x34/0x8c
> [<801901c4>] handle_irq_event+0x44/0x80
> [<801951a8>] handle_level_irq+0xdc/0x194
> [<8018f580>] generic_handle_irq+0x38/0x50
> [<804c6924>] ocelot_irq_handler+0x104/0x1c0
> [<8018f580>] generic_handle_irq+0x38/0x50

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPG58ACgkQJNaLcl1U
h9BvoAf/f/6rtJgyme3vvCowQ16IZAJN774h4L9HXBSudyiaol+mrAx4ZlJdHxzB
OYZwbbqeHHLqr9E9wdQCHDfNz0gAwXzg/kt5BbuNBx5oHLj7JESirezasI5GidMK
nnW92RtEwrt5ygajIO33E/cWeNwLBo3Au0H2/hJnMA4L6RakTJoRT0h6+80XUkJR
q5cHWMH8+kcvPk344EvZ/VkN3bNGo3I1jvcFSYYRwmHe42JWiQSYURBbDynJnI3t
Bx/vo5KR+aA5n3uYfbwMD/Gj9ZbjU3pt/4P4Xhp0u4TkMKZSu3sEuO5EuIbQZ0Fn
Fcu9kqKRVRq5DMt91jBRMEjjEP7HzQ==
=nPpa
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
