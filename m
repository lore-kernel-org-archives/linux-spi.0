From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH resend 2/2] spi: sh-msiof: Add DMA support
Date: Mon, 30 Jun 2014 19:55:48 +0100
Message-ID: <20140630185548.GH23300@sirena.org.uk>
References: <1404123024-12004-1-git-send-email-geert+renesas@glider.be>
 <1404123024-12004-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DdFXZVhPRLAAj7qC"
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404123024-12004-3-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--DdFXZVhPRLAAj7qC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2014 at 12:10:24PM +0200, Geert Uytterhoeven wrote:
> Add DMA support to the MSIOF driver using platform data.
>=20
> As MSIOF DMA is limited to 32-bit words (requiring byte/wordswapping for
> smaller wordsizes), and the group length is limited to 256 words, DMA is
> performed on two fixed pages, allocated and mapped at driver initializati=
on
> time.

Applied, thanks.

--DdFXZVhPRLAAj7qC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTsbKxAAoJELSic+t+oim9c+UP/A0SxYbSUHbjhdAfuvF1fi51
Mn0QIavWHpF4OTnkS9R5ruf5ITATUjF6Zf+6u5MJxuCeziB+OuQdLBV7nghTeL9o
2ZzTU/rO5Ouw0tJCZTYxz4ic0LRzzEsh69fyKKo7SWg/Ia2Ka3ZHA2d2ef72qiQi
Oo16SGZRvYUl+FSHl1xHf2Vgp2V7qB2Wl/ykch5K+FFeuLm2N20xOFps/9p0qtNw
5TZ4gG7v+hu00/Dl7Uv9rtTPAXJxJrFyHHyO/KMStM/w239gwbWzU79OiB/Ki6LF
RTveHMkKR5tZsXZTSFBPLBLDPtPTRREYEEsCwmGyVTCgfRVRYC1fZcMBKCe5RscK
314qY4wfBgAn4eeG2+VmVmQEGauY0tS9H+v9SvCag1yopswg8SiqjQ3UmvtOlqg/
4aSEPXTNot0mPvGX7ytt2TspFu0ntVAslZrPjZDks5fCDn8m8dYnXEo3IxTReGjA
X6Ns6otUGcDoDzq4EJSTU564vEj9P2ST0c0jF/tJuj4I5pTHZJSRLnqvuqHpUH2R
YYdFAQfC5nqzG8bLuUZGa3KjYDUfrIjy4yJMORm9S6ecAmc8ElXgkjQz95kC+WuH
bkBSedQb2tgRf8bcYe30jCiw/88z30xDCLFXpXWS2kVECAMrBOSLA9Cx2SNYq64C
Qbf6RC/z3ii8OilVdQyU
=ku8o
-----END PGP SIGNATURE-----

--DdFXZVhPRLAAj7qC--
