From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH linux-next v2 0/1] improve imx spi performance
Date: Sun, 14 May 2017 19:06:08 +0900
Message-ID: <20170514100608.twzbopohbzidmunr@sirena.org.uk>
References: <1493634704-3545-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cd4xb2eaylfx6g2f"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1493634704-3545-1-git-send-email-jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cd4xb2eaylfx6g2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 01, 2017 at 03:31:43AM -0700, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org wrote:
> From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>=20
> previously burst length (BURST_LENGTH) is always set to equal
> to bits_per_word, causes a 10us gap between each word in transfer,
> which significantly affects performance.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--cd4xb2eaylfx6g2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkYLA8ACgkQJNaLcl1U
h9AatQf9G9Og4PNwcZyuLesVnT45yYsqi0VoAip2e7JrlwRS+NGN1iGFcObqNavn
1OlTfi2tnsma92XdOjS0p1IwB5hMSMrHkM5yC5VggVbTOtHq5a0J12aEJpLJtaAM
lYA1Q1YzJ4pBHF0M/7sdJE43avgCUSAg7xbZRwi85tpTCD3ZPSqJOGxkTpkC3UDW
223F9ieA5Sii0U/uETMy5AHmJkSAw012a0IEVyMO2uv6qIqvrEegCzjYMgXqF2Jt
SMXWfAZOA+mxQE6p57SC/s3MetVXcMMAzV8fhWCDTgc/lsyJJ3IgmKgfoWCydfP0
pUKUV8vi2ROq89uezE3wtcv2K8cefg==
=mDb8
-----END PGP SIGNATURE-----

--cd4xb2eaylfx6g2f--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
