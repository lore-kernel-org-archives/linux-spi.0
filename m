From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-dspi: Remove possible memory leak of 'chip'
Date: Mon, 2 Feb 2015 20:23:56 +0000
Message-ID: <20150202202356.GF21293@sirena.org.uk>
References: <1422722005-1616-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150131164648.GR6507@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lVtahNjrsivmdWUV"
Cc: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, stefan-XLVq0VzYD2Y@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150131164648.GR6507@mwanda>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lVtahNjrsivmdWUV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 31, 2015 at 07:46:48PM +0300, Dan Carpenter wrote:
> On Sat, Jan 31, 2015 at 10:03:25PM +0530, Bhuvanchandra DV wrote:
> > Move the check for spi->bits_per_word
> > before allocation, to avoid memory leak.

> > Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

> Normally, you would give me a Reported-by: tag.  Not a big deal either
> way.

It is a big deal - the Signed-off-by involves all the stuff in
SubmittingPatches which means that you really shouldn't add a signoff
for anyone who didn't supply one.  I've changed to a Reported-by and
applied, please be more careful with this in future Bhuvanchandra.

--lVtahNjrsivmdWUV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz9zbAAoJECTWi3JdVIfQkJoIAIAoEwhc812HI/ImeWiYekh3
y4HtTvDApd4VOBicEMxEYBkAeC+F90IxdhEp8TPZcNqXJ30T23C1ezR7mLpxwCmD
/Ba5YrrNRrsvfCqV260JF76NNmQpiRkZE+dQVNMK1XhG/LUPcKvH4SBACBSBdXyv
Ss/v+Jebe37SGjDfiDOAEJkFeZ6q09TcrGgaQkzrZFnS6+7+Tc0tgWtb5KB/MX7e
a+NSyca6FdhGReqCPWwcWDHjP5w7gC4A+qkk6KYuqhqIj1VtQ2m4IDI1oMZZxZ5m
AIwAMlOB14v2E78E3sETV5lvMDYrnZKHjhzs+9jcGTGbOpEApaqime0ROqDUmmo=
=q3U/
-----END PGP SIGNATURE-----

--lVtahNjrsivmdWUV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
