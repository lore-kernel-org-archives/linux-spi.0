From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH resend 1/2] spi: add driver for ar934x spi controller
Date: Thu, 6 Feb 2020 11:31:58 +0000
Message-ID: <20200206113158.GK3897@sirena.org.uk>
References: <20200206084443.209719-1-gch981213@gmail.com>
 <20200206084443.209719-2-gch981213@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZuCi2HMIMuKavysU"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200206084443.209719-2-gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ZuCi2HMIMuKavysU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2020 at 04:44:42PM +0800, Chuanhong Guo wrote:

This looks good, just a couple of comments below:

> --- /dev/null
> +++ b/drivers/spi/spi-ar934x.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SPI controller driver for Qualcomm Atheros AR934x/QCA95xx SoCs

Please make the entire comment block a C++ one so things look
more intentional.

> +static int ar934x_spi_transfer_one(struct spi_controller *master,
> +				   struct spi_message *m)
> +{
> +	struct ar934x_spi *sp = spi_controller_get_devdata(master);
> +	struct spi_transfer *t = NULL;

...

> +
> +	m->actual_length = 0;
> +	list_for_each_entry(t, &m->transfers, transfer_list) {

It looks like this could just be a transfer_one() operation
instead of transfer_one_message() (which is what this is in spite
of the name)?  There's nothing custom outside this loop that I
can see.

--ZuCi2HMIMuKavysU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl47+S0ACgkQJNaLcl1U
h9A2fQf/ZhyF5Pv32BHd7AWFpCiVV/G4v29FwEuOkbTrG3BmW2HxkCyTST0d68BN
8n/GcOWe+yTfE9lJdSUo1yWNsqX2vT0ELdqTZOsu2Jwor6fKUVbHEqmS7hxIBdyM
LtvvOQZQtCr1j4pIeW0iHEfpdhtsZOuZB9BeHG2BwDBnmfeWDWMyQ3JH9yY1YAry
Iuza2QcHqVU+1Y6beD5OCv0YAtUqNuqmKRYBpFFCbmh88/469Fg2lMwCThrtLq17
XvmVQm2nA36vLtBsix4ioL4WJTw+KMne9/G8U6tRaWh3AUwdnZM5N4XezHagYWx/
0oAHkWZVNxNokjlNLImALrBWyfphfQ==
=9gDh
-----END PGP SIGNATURE-----

--ZuCi2HMIMuKavysU--
