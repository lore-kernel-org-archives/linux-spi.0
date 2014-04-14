From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: sirf: correct TXFIFO empty interrupt status bit
Date: Mon, 14 Apr 2014 21:02:08 +0100
Message-ID: <20140414200208.GT25182@sirena.org.uk>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
 <1397457001-5266-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wiiWofWi8Et/oezL"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397457001-5266-2-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wiiWofWi8Et/oezL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2014 at 02:29:57PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> the old code uses wrong marco - SIRFSOC_SPI_FIFO_FULL is not for
> FIFO interrupt status, it is for FIFO status. here in the ISR,
> SIRFSOC_SPI_TXFIFO_EMPTY is the right bit for SPI TXFIFO interrupt
> status.

Applied, thanks.

--wiiWofWi8Et/oezL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTD69AAoJELSic+t+oim9dd8QAJmx8sMUdTvHht5JpGntHeYY
hPmBcTlW1B44hBZeD3n6Vk10R1QVUoG8iYiS9lsBjwGPviKUC874Cj2DJwwb0dfU
XuUJ9JQ7fUIVXq5RsKZKrYNRBJauWsCFDJYfxprFf8kcKsaCnzn1UzMPIZuV99Tg
5Y/eDMjd2lEz+CMtB54mrU43enPCcMkIiWysjr4aVjpH4S2aKo8pVqjCOK/iTzXd
4NBbKKl/JwDsHfB5Jzrj7MEL84BLHnA3wm6klaQTvIHWOXRTQLCo2wbG2dpsDOK4
cIs3mzjhWPree2bwB3deQnrAYQSYp6V/AC1V1TVfvZ8yUnjDX9UAGs9OhlDUSA0F
Qdh9mXx5b+w9r2QCRP2J+BRX3zZPfx0RZOJ7s4sLVwUmDVEkLLsB/6FOkCWgvbyG
RWn2nXlpxX8vgSMcyCOIaguQGijRfaT7jt1ajjEZfnNBSv1QPEeosUT4Bvb0ho4Q
ofOkkmCTpaR+VqmyTHtmx9qb8y5u/ktA5nDEqP8XTfNhel7OLc0dHZ0p/fjx9sP6
f2ogrmqL6sONAMdBTZiak+PbTKKrAex3KximmlHD+Mg6IfR8IQLAlEmZzpFfwEtY
dM1ROW1gz1YZaxnil0T4UYSh8Uythd6UpL2z3BdCs9ttaGXMP69fpruzdKume67q
fn0+P1rfm6r5RXmP3ZOJ
=0Spc
-----END PGP SIGNATURE-----

--wiiWofWi8Et/oezL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
