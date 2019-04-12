From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/4] spi: Split spi message into max_dma_len size chunks
Date: Fri, 12 Apr 2019 12:09:34 +0100
Message-ID: <20190412110934.GH6909@sirena.org.uk>
References: <20190412102206.GG6909@sirena.org.uk>
 <20190412094721.GE6909@sirena.org.uk>
 <20190412105448.6xamxj2wtuu3yxvt@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0923091739=="
Cc: stefan.wahren@i2se.com, dri-devel@lists.freedesktop.org,
 linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 meghana.madhyastha@gmail.com, kernel@martin.sperl.org
To: Lukas Wunner <lukas@wunner.de>
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190412105448.6xamxj2wtuu3yxvt@wunner.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
List-Id: linux-spi.vger.kernel.org


--===============0923091739==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 12:54:48PM +0200, Lukas Wunner wrote:
> On Fri, Apr 12, 2019 at 10:47:21AM +0100, Mark Brown wrote:

> > I *think* we managed to fix all the architectures to at least stub out
> > the DMA interfaces, it's such a pointless thing to have conditional -
> > it really only makes a difference for build coverage.

> My point was that the call to spi_split_transfers_maxsize() shouldn't
> be called on non-DMA-capable platforms in the first place (because it's
> DMA-specific).

It's not a DMA specific problem - there can be SPI controller
limitations on transfer sizes too.

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywce4ACgkQJNaLcl1U
h9CcoAf+JKL58I7Tsq7TSNJAn3j+AmmcIRR/qQPlz5yhdnT8zZQFZwWlwLi5p/qI
z65hSK/J/T/9xahGWm3M7XX2OC5CMpsoSlphsaNE3mJwzVWV95NoISrWxcZiHAEm
b71f/SDviD42vVEWer1/Reup7As9b5wjkFxrxNoozpHlSTrXaPULgx+kjY509k+O
B0gLlm2FRHZC6QdGxoT89qFpOOO/kt8dRJhRCir/xa+jPrfts4iiVeWfZaEa7b0I
c3j6A7OxbwvE4jtIA2lAH3AFGz10AOGNfh/sGMVlTc2ad/Hb+ipPVdNduyWmM8hq
8mzTZjVf6nMvlaOsN+3Z6axhdVPfoQ==
=UtLi
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--

--===============0923091739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0923091739==--
