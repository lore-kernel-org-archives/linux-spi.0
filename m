From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 1/2] spi: img-spfi: Increase DMA burst size
Date: Wed, 24 Dec 2014 12:20:32 +0000
Message-ID: <20141224122032.GW17800@sirena.org.uk>
References: <1419276916-28433-1-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IjgjYm7ZLtdx4pCv"
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1419276916-28433-1-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--IjgjYm7ZLtdx4pCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 22, 2014 at 11:35:15AM -0800, Andrew Bresticker wrote:
> A 1-byte burst size is rather inefficient and has been shown to cause
> TX issues during testing.  Increase the DMA burst size to 4-bytes for
> both RX and TX DMA when using the 8-bit FIFO.

Applied both, thanks.

--IjgjYm7ZLtdx4pCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmq+PAAoJECTWi3JdVIfQ4zIH/3TaZkULbIsI2aobqE4g+wf2
Y3SRpHtwO42Ff/ZuHLudCQe6zRM1ol+WhtXm5Q9sbCJMIVJoNx+LGkYs1GQKU5Ln
TIdCCEhBem9NZtS0ygt95DTTM9n5LQvDKZJZuQ+9+wMytN/carhKt8dFQBlC9+Cx
lCkYPrG+1/nShpHBRtOnQdDYcZsTAlEb2vhwHoLViHTb4xjiN6OziIqSUFncun5g
7Y0Q3pxhbtWxJuQOcO7HbQeFJ95h0QrEK7rguS3hqaCHo575h4zV2M0LbwJsKulO
Mp70M6z7DH4FmKo9i6HdVYdoGGGo+98+MYz3vHvyrl7X19exB6J0m90xrihvNKE=
=ntnq
-----END PGP SIGNATURE-----

--IjgjYm7ZLtdx4pCv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
