From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 2/3] spi: spi-fsl-dspi: Change the way of increasing
 spi_message->actual_length
Date: Thu, 21 May 2015 21:55:49 +0100
Message-ID: <20150521205549.GJ21577@sirena.org.uk>
References: <1431511921-19548-1-git-send-email-haikun.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XkdrZ7OMnakiJ6dL"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431511921-19548-1-git-send-email-haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XkdrZ7OMnakiJ6dL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 06:12:01PM +0800, Haikun Wang wrote:
> In current driver, we increase actual_length in the following way:
> message->actual_length += dspi_xxx_transfer()

This doesn't apply against current code, please check and resend.

--XkdrZ7OMnakiJ6dL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXkZUAAoJECTWi3JdVIfQx3YH/0ib/tZ1FEZRICvLzY6o4350
YSiF7CRq1zBPZDXU9aRrpZEXsd4FB0GmgiPnbRSWI43U+guK2ZvA2VReQWYSDLu+
xriIWnNbO+6YLAVJJGHxHHfd+UhWaAKMLMA0jbkY1Boxf8tZ8RaUPBDj9tTzzPFT
JwAIDDX+ojhKnNrBtGXDDQRKlYt66/h6KbfdzYIw+ulNXWyl5Zw+CdMxID45m2IZ
/NpzYJxK6tt5JNkzL7xAQ8SUuVknQTl08sJegclGIVjzMls/llB0rwk/gy92deVK
sNaSmBJmHUPO6wSMnIGPjxX/vgHKWcKY4aTQV1RpLAyVtAeJdN0GAdc91OC4Th4=
=zWji
-----END PGP SIGNATURE-----

--XkdrZ7OMnakiJ6dL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
