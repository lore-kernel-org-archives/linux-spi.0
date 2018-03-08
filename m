From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] spi: tegra20-slink: use true and false for boolean values
Date: Thu, 8 Mar 2018 14:14:40 +0100
Message-ID: <20180308131440.GC3529@ulmo>
References: <20180305235339.GA646@embeddedgus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180305235339.GA646@embeddedgus>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 05:53:39PM -0600, Gustavo A. R. Silva wrote:
> Assign true or false to boolean variables instead of an integer value.
>=20
> This issue was detected with the help of Coccinelle.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/spi/spi-tegra20-slink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqhNz0ACgkQ3SOs138+
s6FpSA/+KQBYiHSNVnrRvJ6y7/N2jBi1X1tQlelO5L/E98voet8WK7BW+gvPItvJ
ZEKsmDqAUtLioRQ2zoxTfl76GF7jVgOoRuj9nGx2GOYmQrbY9+rKJzSv9zWsGwBD
2k0XAtQAyFayXUdkYHcTZ+2GS+0OWbjiBm3HPIeMaZ9nvzj9bTbNtILdfrPLjDYy
dRJ75AgBuPybEI1ckYy63tYzYeHltsQ4324eGtFBcnN+YMrtij9RfvWuNBeKCkng
mdzuMpmKkRwC9G3lMjKV01RUOGtMZhSh84P+Wfs/3xDjIQajETEKxZ7wD7Xj8AOH
/ZBrNlj1TlH7gBQiKuQYB8hbQwc7ORdRBchGkXj40dw2eifNGZfOcdFPDB6qA8er
qZxGrWumue/QG1qEHCHqDrriBfmUBwnTTaoabwwg0ms3otvgP9b9ofqfKgSWjFLI
icfTlBo+nI64/sAEcnnuiVxWH4PXSd4CBVoVm+DxqlVvmgpLRXxIaCR20uFeyMMB
uedJk8hlxwlg7vJSrmXedUqzHU3rRnQH329bI68VdSIybZa4VIe7AAxCYSY4at0O
QPAHzvr7BMrBwAW/r34NiOWt8h+ODtT/FwBAL7ejYvJcHXz7KqacSH6ouG8qmNYG
ITvdQbL2zt8DL9M+agF+wWLccoVL19fPrf1HpWItwlPn4DUaaJ8=
=h8jU
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
