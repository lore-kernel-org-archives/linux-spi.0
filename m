From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: meson: Select REGMAP_MMIO
Date: Thu, 27 Nov 2014 11:00:25 +0000
Message-ID: <20141127110025.GG7712@sirena.org.uk>
References: <1417043268-17563-1-git-send-email-b.galvani@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G0xbash/Z2FAVN3O"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jim Davis <jim.epost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417043268-17563-1-git-send-email-b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--G0xbash/Z2FAVN3O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 27, 2014 at 12:07:48AM +0100, Beniamino Galvani wrote:
> The Meson SPIFC driver uses regmap mmio functions and so it must
> select REGMAP_MMIO to avoid the following build error:

Applied, thanks.

--G0xbash/Z2FAVN3O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdwRIAAoJECTWi3JdVIfQDZ8H/2PxoN88ZL+jJmJsl1q8rUbG
Sss454llCba3mQAlvJ52JDTakf1CsqEPCctj1aauQXWyPsl0HeNcglW1V7DrzBoQ
Sr5+bm50g1U88GyuBDFcDqTMjPC5p9MGlDaQt/Kj/1Cr9h/1c76XA11h4p6ilLBZ
bCRR/Vau40ByJRGUs3XJA24octq7rQY9JKmmSc2zuikETq6lnHysLXNk7DcH0NGH
P4wFVp2lVrgLU000ZPO+1Ro5v7/DOQ6yf0iVMEKzHLkkzODyAU4RcSYExPgzxlNq
djU2qeSVKFczzR+H25R1ZlPt0q7Lsk3Ce2wCC4eZ/k8BAEsGmvJsAKRRg7W5BBs=
=psFe
-----END PGP SIGNATURE-----

--G0xbash/Z2FAVN3O--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
