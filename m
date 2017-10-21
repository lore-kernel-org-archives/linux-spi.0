From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] patch to spi-fsl-dspi.c to enable Coldfire mcf5441x
Date: Sat, 21 Oct 2017 11:22:40 +0100
Message-ID: <20171021102240.kwsjgmpjdom2np77@sirena.org.uk>
References: <ff0014ac-1d46-5014-4371-041ccdba1fa5@sysam.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xvetegghaofllxp4"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Greg Ungerer <gregungerer-ncau/BB9MAPvnOemgxGiVw@public.gmane.org>
To: Angelo Dureghello <angelo-BIYBQhTR83Y@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ff0014ac-1d46-5014-4371-041ccdba1fa5-BIYBQhTR83Y@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xvetegghaofllxp4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 13, 2017 at 02:08:54AM +0200, Angelo Dureghello wrote:

> i had the need to use the dspi module of Coldfire mcf5441x.
> I have seen the spi-fsl-dspi.c was already covering this
> CPU but was not selectable, and not working out of the box
> once enabled form Kconfig.

Please submit changes using the format covered in SubmittingPatches,
this allows things to be handled using tools and for review by e-mail.

--xvetegghaofllxp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnrH+8ACgkQJNaLcl1U
h9DCWAf/VVjw1xYIpN49fQWf1//HbuzweOUXA9JitAd9NjPWiMj3fPWAf4s/5JUl
2d5Z9pD7b69sowAIiuUuCTNB/SEBkqzkCOA5CbSe3ChPYeGPlLHFUHL/S3gyqc7J
A18w8IRmzrRkEJXcdCxxUFebcPMBKCnUfs8q07V6hDY8a+YdGvq06vuAXBpYlOEM
1+cMG5jivdW72GFTUE6aPoQjLY2s1rZDxqyR57kNdHOmWt7IRDVYkIqUlGm60a9K
CJYA8HsimvT9wxHSVXFIyJ4BcN7VGggmbOvHaqSbYF3Pklp53gtAZrvVLPcEey2f
dp82WxKkswzc/2qHfahH9ITSx9ahJQ==
=mcoP
-----END PGP SIGNATURE-----

--xvetegghaofllxp4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
