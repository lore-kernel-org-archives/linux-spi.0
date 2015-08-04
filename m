From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] spi: s3c24xx: Convert spinlock to mutex
Date: Tue, 4 Aug 2015 12:00:41 +0100
Message-ID: <20150804110040.GJ20873@sirena.org.uk>
References: <1438668598-6678-1-git-send-email-drinkcat@chromium.org>
 <1438668598-6678-3-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0jdOO2+ODOkP2/E4"
Cc: Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438668598-6678-3-git-send-email-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--0jdOO2+ODOkP2/E4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 04, 2015 at 02:09:58PM +0800, Nicolas Boichat wrote:
> bitbang->lock is now a mutex: replace spinlock function calls
> by mutex functions.

This would need to be combined with the first patch, individual patches
shouldn't break the build.

--0jdOO2+ODOkP2/E4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwJtYAAoJECTWi3JdVIfQC8kH/2iNlibPE9skwDYxz5SJFihv
LkqReZIo75iqJB3+321ZtzMMyd0Xq7iDUc6OHoYKc54ZyBFd23wNVE2VuSeWqOqm
mGGApPru/FtDv2SCYUw2aUjL4zekVKEk0pjMTvy+n5BrVyCY/7jAw6M3jfi82WB3
BKr8jA6ZYOT7vRRYOyEH52GEgp1ywNi/BzIeOSzqd4gMVvurusxNLDz7cbZ0oCC4
bwkxKQCbIeweLzNgc93+U1PhwIj+mCQTKt6+0qERPS80LixKiEkJOamV8QhsdXqY
iziz9I0AOJTBeTDcsIGKssSG1oPo8tQPDIoQ/Xr5f5DNinv1c/jofpIX/uPiiYY=
=VyIA
-----END PGP SIGNATURE-----

--0jdOO2+ODOkP2/E4--
