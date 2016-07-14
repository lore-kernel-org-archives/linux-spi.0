From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFCv1 0/1] Update struct spi_transfer to specify 8x bit
 transfers
Date: Thu, 14 Jul 2016 14:30:53 +0100
Message-ID: <20160714133053.GL9976@sirena.org.uk>
References: <1468438477-18883-1-git-send-email-girishm@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pz0BBB9QxoYXlT+x"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1468438477-18883-1-git-send-email-girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Pz0BBB9QxoYXlT+x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 13, 2016 at 01:34:36PM -0600, Girish Mahadevan wrote:
> We=E2=80=99re working on a driver for a Quad SPI controller [using up to =
4 data lines] which can use dual-data-sampling to implement 8-bit transfers=
=2E To allow a slave driver to specify the 8-bit transfer we'd like to make=
 this change to the spi_transfer data structure. We are still working on th=
e driver we will send an RFC for the driver patches separately once it is r=
eady.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--Pz0BBB9QxoYXlT+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXh5QKAAoJECTWi3JdVIfQq9EH/054epe5EsPUYjaFZ2EajmOs
h76Zd4FfKEfiZdqagx+nGPLrHss+IJdy3SduwOJBuSosPqo1izH09ujHdX543hCd
xlZ8IpGfamixx1iUbDR3/OaagOWlr8O4kOoGE5q5rnCIvgqbChRuPD+t1veAcgIK
ysTmSgIsX9ZdMkHY7orDyuYO/f/bgzEXLNmB6xsan6bNNJk2MudFZFJfzi2rNVWk
PB0d7LJ7JssiGOnIcpcWvD4aJ4uI+GWuzYm/vZC9aatnXYOm1kt83F7jq9WHDmjX
CD8N9SSmk9xw6OIcu9jrqlPwQFRVWyu/arFD/FySkmHjgNQH7zTpKHu06UClOTU=
=Ew+w
-----END PGP SIGNATURE-----

--Pz0BBB9QxoYXlT+x--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
