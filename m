From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: Fix test unsigned var < 0
Date: Wed, 26 Mar 2014 16:51:45 +0000
Message-ID: <20140326165145.GD14287@sirena.org.uk>
References: <1395498809.16958.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Cc: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395498809.16958.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 22, 2014 at 10:33:29PM +0800, Axel Lin wrote:
> current_remaining_bytes is an unsigned long and cannot be below 0.

> -	if (xfer->bits_per_word > 8) {
> +
> +	if (xfer->bits_per_word > 8)
>  		as->current_remaining_bytes -= 2;
> -		if (as->current_remaining_bytes < 0)
> -			as->current_remaining_bytes = 0;
> -	} else {
> +	else
>  		as->current_remaining_bytes--;
> -	}

This removes an error check in the case that we set the remaining bytes
to -1.  The length validation the core does should ensure that never
happens but it seems wrong to just ignore that - we should at least note
in the changelog that the analysis has been done.

Are you sure that the best fix isn't to just use an int here?

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMwWeAAoJELSic+t+oim9ECwP/iMKEDIVtyzjQHLS9s5MRyBm
lCNFjuwfd0ASAjOuI3FAOSK5byZShnlTmjwAWJRWds8mgFnJRF86tRoPG5QHnE1f
zrmktu/8kyOTAHtFewa76kbQI3ovwoTfD3SV5r04ijT8c8gzxEnVzf+zaxhL+aTp
Gmo0pZsuxlPfKtO7b23HxYOzm+uW8zKJ02ty6FjEt4+tJ5H5i9ameZZGldfMXEnh
/w4dHFYzYTbZvVkWgXvndcDr5EZDkG4QPhpbLk0JjMhmKcea6jdW6CYlP3TFaiao
qyuFIbdzE/pmwT5fE9QBV5mWfk08L/YD1KsHZSVi18SqrkAsDV2fRTUXrlDfRJN9
Z0UsJNsKuhnkDjQnkc5OeioOoUBfvKfJIOejfIm+JanN4q9ggkyWoZUGteO141f3
KKrGHyGMRms1vMlIi7+g2LzI/pskIWGpui5UgHeV0LHCm0038nafEzjafjfXIcZ0
iq9en/JJEgScCJwL1Gv9NAxDOMMUGfYC6oz4RRoi/vCpII0nrVFFm95zd0qd5HyX
5vAh2iPUTOlq0O3nwdwCuUJ4lhe11D2fOqkZmvjsMskiaUbEw50IG8FWDoGwYt9s
ERzGBf7LCUmx5lnqmmTyiInOF6eCasUbFZXYV3Afj6NmJLUBJj+TdkBP19SEVQmY
k2N6eYHCLU2C662AEuFa
=DuFA
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
