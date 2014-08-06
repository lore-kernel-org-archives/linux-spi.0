From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/12] spi: rspi: Configure DMA slave bus width to 8 bit
Date: Wed, 6 Aug 2014 21:26:45 +0100
Message-ID: <20140806202645.GS17528@sirena.org.uk>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
 <1407329949-5695-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80rbuoCJiz4t6Ni8"
Cc: Simon Horman <horms@verge.net.au>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	dmaengine@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1407329949-5695-5-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--80rbuoCJiz4t6Ni8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 06, 2014 at 02:59:01PM +0200, Geert Uytterhoeven wrote:
> The new Renesas R-Car Gen2 DMA Controller driver (rcar-dmac) requires
> explicit configuration of the DMA slave bus width.
> Hardcode the DMA transfer size to 1 byte for both directions, as that's
> the only supported configuration (16-bit DMA support was removed in
> commit 9c5de2c1754c2bb3c69c4d7bf0d0edc0a61d8232 ("spi: rspi: Remove
> unused 16-bit DMA support")).

Applied, thanks.

--80rbuoCJiz4t6Ni8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT4o+CAAoJELSic+t+oim9+bkP/j3HVCDndd28Vikuz/xDirtw
CN9mRA6K1A3ftaSszTgwlBMGVq3E2wXs1ioeUGWTMz9hLR368BW1uLXRI0Horm3e
0gki7io4lQoaCm/RKd4y7/MxrnQbPr+Z1Xd0clN9CdRqs5h8uuaLvSQPK4vMvdtw
2GW4D3Nohq6XaqdW92dhVnld9NKtK1BvXgEsYC/wL7nb5VNwajY54juOMx3Dkjro
Uv9pF8VK5/2le8ObEyoXB9u5m162v2UMzmx48HeI5gTxKgvymWCdv0nCnRxQ+/MR
QjPZaUxU8jFYexYXjx4rCc5bH3XzWHlOzItzwNBnEsrI6Bpo8v1sDVV0PtzhWkCh
ElbmpIGufw2nRLGctHD81vszQcIiXbXu0gjzROwRee6A4GMcxwh++MsShVE5rH30
fJb8xiBoyzkGGeCj6AmW2YXlf/rt7Z+kTZsf9ogTP2XV+4lD7nLjpVUfhSZjd/Tm
+bMPEMovo9qFLhDRo9jM1QJxuIIRySg4342jtIk6KtYXsjXWuTQwhF0T7yXj0ELL
/W7n3+09PiqSSBxmdbJhIQt1Iqc6BXx8arpbZZsHOitDfbqchtAQJqgTCXqNquvW
iNluDJQSmB3tz0qdH6bE5uIx1O/zx9itj1GJBXmSgQgdWGG1l3elpB3zk5r9ioIY
5A0mEUj5/IT61wBBTpRN
=5Fpi
-----END PGP SIGNATURE-----

--80rbuoCJiz4t6Ni8--
