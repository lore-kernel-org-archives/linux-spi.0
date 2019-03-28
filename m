From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] spi: tegra20-slink: change chip select action order
Date: Thu, 28 Mar 2019 17:34:16 +0100
Message-ID: <20190328163416.GA31762@ulmo>
References: <20190326143050.26232-1-gaireg@gaireg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Randolph =?utf-8?Q?Maa=C3=9Fen?= <gaireg@gaireg.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326143050.26232-1-gaireg@gaireg.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 03:30:50PM +0100, Randolph Maa=C3=9Fen wrote:
> To transfer via SPI the tegra20-slink driver first sets the command
> register, which contains the chip select value, and after that the
> command2 register, which contains the chip select line. This leads to a
> small spike in the chip selct 0 line between the set of the value and
> the selection of the chip select line.
>=20
> This commit changes the order of the register writes so that first the
> chip select line is chosen and then the value is set, removing the
> spike.
>=20
> Signed-off-by: Randolph Maa=C3=9Fen <gaireg@gaireg.de>
> ---
>  drivers/spi/spi-tegra20-slink.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

With the typofix that Sowjanya pointed out, this patch is:

Acked-by: Thierry Reding <treding@nvidia.com>

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyc94gACgkQ3SOs138+
s6HshA//eM/HQvj5Ayl7EEKWD9wFOAT0N4ETiqkZHwoTO/ZNMSht7QdKprY9KLHp
ey3Dm6iLdiBTz8HZnArG37J4dh7gEsbEAy3sd2cDn72+ogHgf2+35G1wVNpsBzM6
zV2EpgRlzIVGHYv5nIZnlEAeIQ4l+5/UxuHZr15yRJkdJnPhrbTRLAnOEvqM92G/
hw0xr3EuMmddR3UCaX7BCrcZ/XNluEHzGCPxr0qnr9vB7EPztbgGMYysdbcMe88J
s5KCjPq8pJV35hKP5+3JG/1UGDA4tqzsw+4lqwvr+VBSqDn0kD4qw40ToYKh3bWK
aGcxSkHIkLzMbJWtvQ+9JPlZjg8Xrfz/FAuGbptlwCYSFK+tM8dP9s4b8ir7fJo8
L0B6hHpLucdmnPOmSiT8zQkhjRfeCmUuVJacdwAafYfqvW4OVXCcnrqsOaBiX/2E
OoXMLmFaloaQqTmsO2a4XtHv2JYoLQ9SgKUl4R01yU+CPq/CT3r1deEwkCIKOdme
Th+zXTJiaksmbPZv+XDHt8o+X18NBtH/us8Z+3gB4iD9s7eBQadlrQQ+cpSXVIpx
ZvamTQPeBmADB7r1UhhI3YBxXS5tyjImouqP94KkngdWjoq+O8Dbqqe1PSTRUaEH
vCbw2MNNHgPPkxiAyRIggzcgv2ZAmaimp//GeGWm6MgBx5l49F4=
=554g
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
