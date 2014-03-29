From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: mpc52xx: Convert to use bits_per_word_mask
Date: Sat, 29 Mar 2014 10:16:07 +0000
Message-ID: <20140329101607.GG21628@sirena.org.uk>
References: <1396021074.13764.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396021074.13764.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2014 at 11:37:54PM +0800, Axel Lin wrote:
> This controller only supports 8-bit word length.
> Set bits_per_word_mask so spi core will reject transfers that attempt to use
> an unsupported bits_per_word value.
> Also remove the duplicate code to test spi->mode, it is done by spi core.

Applied, thanks.

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNp1jAAoJELSic+t+oim9Oq4QAIVPHWD7J8+Hg7AEHAygMCer
EwBF/N3B80vHw2LyQe/DN+em1rJgrkvbCAnH6JKrNLmSba1SWBth8pzFLyLkel8x
pzjAINeM/nTL5ve/xz2IiRf2ouHpgHqPNs8tZlJrzTpdBDc/MApI4AdCfygIWkGl
/1vUdN/mVM5y1lFhHyHZ1Js9oon+blILbBLxH+KkxGhUf2xyR71vT4UthlrnqonA
GlWPdzroFDScmSpFRx7ihV1Xpvm0B1pSsQOlGWG66XfZXLz62x65lmgxr9yfF4n8
BmJK33Mv+kz7ABwvrHwcwdI35U20OA1UbN9ElCUA30AFEEstEtLFligoVjjaCXvl
wiM4XhECMLwb7FYOao9xjU7oQ39e5iTmu/vk3MNXZpJZU5ZZmYymwVmfzIvOaQ/Q
VcVpB2V52PI8k6HuvWl24eSp54LCQnTbQxqT2yQJmbJfvE8sZxn9YeI+mzfUdnPs
OYUDJVG7UPZ0vbYMFbhw9GthPZXR0Vdnhfokegj9VsJpksPVuiqIxDfIevoV5JDY
X4vG44dNj9KlDW9Q90/ynV8Dqq+X+EVocAExS1JDLBzd43AUrs/FSYL37byOwcxA
HL/jNASSRUMgz3itWFQNOAUiUmsdhTiXQXh7SS2bzcoAdXi+PJmR1lg6l9kwTtTx
NNkFQURu4jaji3Tgw99L
=dAPh
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
