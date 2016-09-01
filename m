From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/23] spi: fsl-espi: factor out filling the local buffer
Date: Thu, 1 Sep 2016 21:18:29 +0100
Message-ID: <20160901201829.GS5967@sirena.org.uk>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
 <41a045ab-2629-658f-cccd-23f7182a4bc2@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WVXkb2QE2eH0aWe4"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41a045ab-2629-658f-cccd-23f7182a4bc2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--WVXkb2QE2eH0aWe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 25, 2016 at 06:46:26AM +0200, Heiner Kallweit wrote:

> +		if (t->tx_buf) {
> +			memcpy(buf, t->tx_buf, t->len);
> +			if (!t->rx_buf)
> +				tx_only += t->len;
> +		} else
> +			memset(buf, 0, t->len);

Coding style, { } on both or neither side of the if.

> -	memset(mspi->local_buf, 0, SPCOM_TRANLEN_MAX);
> -

This optimization wasn't mentioned in the changelog...

--WVXkb2QE2eH0aWe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXyI0UAAoJECTWi3JdVIfQmZQIAIGgt9icVu6iYMeHyNITLXwq
eMlerLOEiS+xBIQh28mmo/cUdSFF6G2e6A3oQSb+oAyFOjSwhwW2gWBqSaPIr5fN
4uSf7KjXuFGnDFuD63TrLfFCi/EufVEngNcTKBq5F6cOVd8Urcwj6ptjO3rM8Gie
THazvC3YYq0BYquHn6nfoLXM9Msf9knNK2VSdrM2arvCRg8UqIekadNadqa6MW9k
t2r/bhXhTOpUeP9oNvcXVvD/ngFh08d54g7ElHpvUmba6Efc+LDpU+Q+UIagObOh
2hFPlRGVxS/I9xsExPzjFFkxJTWNcIUv2jCwGSVb3Hye05poqm3cUJSa5vtxuYk=
=oAYa
-----END PGP SIGNATURE-----

--WVXkb2QE2eH0aWe4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
