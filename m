From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: sunxi: spi: use proper errno when message is
 too long.
Date: Sun, 26 Apr 2015 10:42:21 +0200
Message-ID: <20150426084221.GE5627@lukather>
References: <cover.1430034797.git.hramrach@gmail.com>
 <4c27d44b2bdd759424ce4a4b2e8f6abf5d5a6735.1430034797.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4c27d44b2bdd759424ce4a4b2e8f6abf5d5a6735.1430034797.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 09:21:07PM +0200, Michal Suchanek wrote:
> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

No commit log?

> ---
>  drivers/spi/spi-sun4i.c | 2 +-
>  drivers/spi/spi-sun6i.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index fbb0a4d..8238b4e 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -176,7 +176,7 @@ static int sun4i_spi_transfer_one(struct spi_master *=
master,
> =20
>  	/* We don't support transfer larger than the FIFO */
>  	if (tfr->len > SUN4I_FIFO_DEPTH)
> -		return -EINVAL;
> +		return -EMSGSIZE;

Is it still a thing? The patch to remove such limit hasn't been merged
yet?

>  	reinit_completion(&sspi->done);
>  	sspi->tx_buf =3D tfr->tx_buf;
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index ac48f59..0f5dd91 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -166,7 +166,7 @@ static int sun6i_spi_transfer_one(struct spi_master *=
master,
> =20
>  	/* We don't support transfer larger than the FIFO */
>  	if (tfr->len > SUN6I_FIFO_DEPTH)
> -		return -EINVAL;
> +		return -EMSGSIZE;

Eventually, we should move to using DMA for these messages longer than
the FIFO.

I should post these patches.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVPKTsAAoJEBx+YmzsjxAgNqAQAJoeeMSVKfxVPW3DyDwDbo7q
cy5L0YS1ZZcVXyvZ8M6QBSQ5KUzfvBMk+afubrgWNnLikGTNnUdZGtZR6JgrXPpX
fhz+4qrw4w2SwCdhcr86IF4biku3goaFhjQJ01RnS3zXTQbUTWZChbK+qov9iLjz
LC6X6GpVlAIbTQQ/MF1h4/kvoLxAXjvhYrTEb/4+qw7wW7fvA1GaPCuwEHQsA86Q
+5EEWTohZBKGMk2J+yP14v5NTNYGEr+3iKbTFLZFSvpaTH9zKeXY7DpTrg9Tdfz9
5EZgxNQztuS5n2ReDhf7/uPGKdOCr/hk9PS5aDP8xGXFJFicv1DWcC7fXieqiXup
iizSEFRAPfE5TrsgevoP3zkI15Fk1tekDrfiw+sUtIupSEsMOhEKDf9NYHrWoGpe
Q7KcKqxN4DCr/AdEHN8duwcuOC7FgDIw9DvpyaLvrGt0YGPgjfQ09+r+5uhfS7C8
gpaK8mwAkkqyoAOB/oYxyCQIk7fEcFf2DQao711WIcalZEMj8VhrLf7mkOdEPUpu
63ZfhXSEYRz7ofC8baUbFqppYW3cOJ5bRqxlpTkH8WeRgip8WdM8IfJtfar4Qz1i
vEndzU960k1uTCmIeohzm3WXZ6jMs5vDme554mit0P7pDH1FJpyFHBQxPXnigazj
eme+97SFVjJ8k2YiLx8o
=E+jc
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
