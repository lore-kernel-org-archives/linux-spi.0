From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH spi/for-next] spi: sh-msiof: Add R-Car Gen 2 and 3
 fallback bindings
Date: Wed, 14 Dec 2016 17:38:11 +0000
Message-ID: <20161214173811.iporb5qqulmndvg3@sirena.org.uk>
References: <1481536175-17238-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sgpdmudl7gbvkuhn"
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1481536175-17238-1-git-send-email-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--sgpdmudl7gbvkuhn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 12, 2016 at 10:49:35AM +0100, Simon Horman wrote:

> +	{ .compatible = "renesas,sh-msiof",        .data = &sh_data }, // Deprecated

C++ style comment here, please send a followup fixing this.

--sgpdmudl7gbvkuhn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhRg4IACgkQJNaLcl1U
h9BE5Af2IxQr1UZETSwENwVf2BDEj/59k7G5Ym5ITsWdwXmycvgDb+CjeaCxZ2Rk
bB4Fw1ufqCOnpXXX44EDCtVrytc5Wq2RnSTTjmOD9pmmiYPPXGiOs/0KUNNDXRkL
W6ZjfMYabeSKO6+sSatYfWROEYeve//VxRVPCIU7HxfjQ+inxFVXjqau4GMjQv5r
5B2JAUhPwdPgu0cRx9eJjbiRcYMwbUIKG56SPikPEMOiTR6BmROZ07s+ShUHa22l
Mi2RjdErBb40qSswMZpshIZjj4N4MFzHkSx4aRQG3Sya8aLPprkUROAmgIVIAIBk
Chx6WBzYGoPngGr43ULTm0aP42Rf
=E/cR
-----END PGP SIGNATURE-----

--sgpdmudl7gbvkuhn--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
