From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
Date: Thu, 30 Jan 2020 14:46:09 +0000
Message-ID: <20200130144609.GD6682@sirena.org.uk>
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, andrew-zrmu5oMJ5Fs@public.gmane.org
To: Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1580328504-436-1-git-send-email-eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 29, 2020 at 02:08:24PM -0600, Eddie James wrote:

Overall this looks good, some comments below but they're all fairly
minor.

> +++ b/drivers/spi/spi-fsi.c
> @@ -0,0 +1,547 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) IBM Corporation 2020
> + */

Please make the entire comment a C++ one so things look more
intentional.

> +
> +static int fsi_spi_data_in(u64 in, u8 *rx, int len)
> +{
> +	int i;
> +	int num_bytes = len > 8 ? 8 : len;

Please write normal conditional statements to improve legibility, the
ternery operator isn't really needed here.

> +static int fsi_spi_reset(struct fsi_spi *ctx)
> +{
> +	int rc;
> +
> +	dev_info(ctx->dev, "Resetting SPI controller.\n");

This should be lowered to dev_dbg() at most, it's not really adding
anything otherwise.

> +static int fsi_spi_remove(struct device *dev)
> +{
> +	return 0;
> +}

Remove empty functions, if they can safely be empty then it should be
possible to omit them.

> +static const struct fsi_device_id fsi_spi_ids[] = {
> +	{ FSI_ENGID_SPI, FSI_VERSION_ANY },
> +	{ }
> +};

This needs a MODULE_DEVICE_TABLE annotation.

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4y7DAACgkQJNaLcl1U
h9A9TAf+MkugoZ6sUpGxBfx/kkjLIYhw0zx+HOwK7LSA++HLwW76LEm+KamfSANm
7g9UhKQUdHhBs2ahWu+pZwF39cd4HgoQqCSe6iW42IUWvh5XVXlTYrDqnh3zoqYX
V1NjkEDzs+50zaJIJWAMAZmQ6vZYupmDEtVO6oeAa1Q2GlhZbYgEkpLrEuXQFm35
dyfhAZTN6VICNPaUZXzZdg+5lFm7wskffv0RQhUUxo+5aPoa/o8EIEqHRb3emjvS
nHcoisf9jxj8YJWkpzCJ5lOf+naaI0mENZa8k+Enbtkh8iktHNWp0tfPKmgEpMuF
4qfEnnMtc5U99fHkihfnLTy1Afzg2Q==
=Hyju
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
