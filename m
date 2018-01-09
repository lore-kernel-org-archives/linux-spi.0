From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv1 2/3] spi: Add spi driver for Socionext Synquacer
 platform
Date: Tue, 9 Jan 2018 17:41:41 +0000
Message-ID: <20180109174141.GF11471@sirena.org.uk>
References: <1515503383-8909-1-git-send-email-jassisinghbrar@gmail.com>
 <1515503448-9025-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vKFfOv5t3oGVpiF+"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1515503448-9025-1-git-send-email-jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vKFfOv5t3oGVpiF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 09, 2018 at 06:40:48PM +0530, jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

This is basically fine, a couple of style things plus the question I had
on the bindings:

> +++ b/drivers/spi/spi-synquacer.c
> @@ -0,0 +1,664 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Synquacer HSSPI controller driver

Mixing C and C++ style comments on adjacent lines looks messy, just make
the whole thing C++.

> +       speed = xfer->speed_hz ? : spi->max_speed_hz;
> +       bpw = xfer->bits_per_word ? : spi->bits_per_word;

I'm not a big fan of all the ternery operator use in the driver, it's
not super helpful for legibility.

> +	if (sspi->bpw == 8)
> +		words = xfer->len / 1;
> +	else if (sspi->bpw == 16)
> +		words = xfer->len / 2;
> +	else
> +		words = xfer->len / 4;

This should be a switch statement; a safety check for invalid values
wouldn't go amiss either.

--vKFfOv5t3oGVpiF+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpU/tQACgkQJNaLcl1U
h9DFTQf9FAgzVFX1w6D/dFOUsfcbtbkQWrmWZAAXV30Wxyl+hJnCp6TGnp1rrP72
NOUfah+YjrtFhAkisxiXRA575kQGklojE6w2PogHjMbijtDy6rVEtg9G6r0rHcGb
B8wwjgjQFEyO3bmvIW9YoN/pZ8fG56PLCceOxikuknTpISt5opzaSkNtbRHk2BpT
EHtuDGm/YpFiGMZjaiTvHJv7c3wmvU/tp0Qi/9IfuyVZHlvYid7yVWYNY/73nd82
ZZ+cGzCPhOCLXzXGP19EhdIj7PliJxX9Ea7x7I6DLj0hZGIIPQINOIFfIiVm9aZS
l2fBEjcng/1kSV92bSzFaZMWd+l1eQ==
=hNKz
-----END PGP SIGNATURE-----

--vKFfOv5t3oGVpiF+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
