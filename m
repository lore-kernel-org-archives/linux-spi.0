From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/12] spi: rspi: Fix leaking of unused DMA descriptors
Date: Wed, 6 Aug 2014 21:11:43 +0100
Message-ID: <20140806201143.GN17528@sirena.org.uk>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
 <1407329949-5695-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpRpggDAsniQQBL1"
Cc: Simon Horman <horms@verge.net.au>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	dmaengine@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1407329949-5695-2-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--IpRpggDAsniQQBL1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 06, 2014 at 02:58:58PM +0200, Geert Uytterhoeven wrote:
> If dmaengine_prep_slave_sg() or dmaengine_submit() fail, we may leak
> unused DMA descriptors.

Applied, thanks.

--IpRpggDAsniQQBL1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT4ov8AAoJELSic+t+oim9mz0P/32Dfudbmijut52ZHC6O9Afp
LKlaXRRmKmYHRaYsMN+yjI+0bCSuXLqtAJ2XQ8fmIvIl9Hw7mNSELOc9BPdTIm9Z
BRt52qwvBmBVp25YK4JTFX4hZtNokGTs4srruELFBWvHQqDSRUIuslc2SUSOgQb2
iK1TsY/2zszJq1ZjIqoi21q76ZKp29Pr+w78tIvorOAbU0pas78S7bIOHy7Gj7sn
NbzAfx1hEhM4I3eNF68lNqgSvfEmQceCaisiDzBTEzMtKl1yvsBiI61bxZ9P0/CC
vMZBNOJkRFUI40nCWZJh4xS8hW66GHntpe5Kt/HC66pvuqNwSRZoP/rm2Qqxpfdy
riJ6LiQMkMQFtMh0IJ0oDn8xe4QSytn3JZzXLQuse1Gn5fHIHt3bXcn4UKxmf2yc
p3aih41IsvoTQk0Dx+VJczQXyR+tud7GSHcFuODI2d48ZZ74gQ+H+DO0/3SaeQma
NhkQFNT0nwpegwyDouxnWbyk4hfrDzEMbPVoM2kvIboMreuLKhsg2fCWnrZBmUZM
ctpn/VvMv2GkcwPQispoaMSTfKGA73MYMXzH5mWBn4uiUNpyXsyFWoj41+x/+DI0
FBpy5e39he/WRZCqgZINb/q1BnPVW79vfe5nPSznCXsKnUV3sOywQZP7gU4sO8Mb
TTkk6OAd5FXjrzESOrpp
=rEOB
-----END PGP SIGNATURE-----

--IpRpggDAsniQQBL1--
