From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/4] spi: Split spi message into max_dma_len size chunks
Date: Fri, 12 Apr 2019 12:28:14 +0100
Message-ID: <20190412112814.GI6909@sirena.org.uk>
References: <20190412102206.GG6909@sirena.org.uk>
 <20190412094721.GE6909@sirena.org.uk>
 <20190412105448.6xamxj2wtuu3yxvt@wunner.de>
 <20190412110934.GH6909@sirena.org.uk>
 <20190412111615.25iogtr6qwc5zbx7@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1862167558=="
Cc: stefan.wahren@i2se.com, dri-devel@lists.freedesktop.org,
 linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 meghana.madhyastha@gmail.com, kernel@martin.sperl.org
To: Lukas Wunner <lukas@wunner.de>
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190412111615.25iogtr6qwc5zbx7@wunner.de>
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


--===============1862167558==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Content-Disposition: inline


--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 01:16:15PM +0200, Lukas Wunner wrote:
> On Fri, Apr 12, 2019 at 12:09:34PM +0100, Mark Brown wrote:
> > On Fri, Apr 12, 2019 at 12:54:48PM +0200, Lukas Wunner wrote:

> > > My point was that the call to spi_split_transfers_maxsize() shouldn't
> > > be called on non-DMA-capable platforms in the first place (because it's
> > > DMA-specific).

> > It's not a DMA specific problem - there can be SPI controller
> > limitations on transfer sizes too.

> The call does pass in ctlr->max_dma_len though, so is clearly motivated
> by a DMA limitation.

Yeah, that bit is but we can have other limitations.

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywdk0ACgkQJNaLcl1U
h9Dl2ggAgETjOOFupX5Ylc82DOndgkiHcdAPthzAigd1VGRct1+hsSfgSqlUtoNo
LW04O4lv+4dat8AN8hyLgzNxLZrcPedZmgE+YmDOM0tw5f5j4f0MWUU9Zt6x2il1
Cq7HKQtQOpt/3xqICfSvt2slfYl/UxMgDLGNkqd1HHTMcCr4s8STeCZUczTqLKC0
Z/fGk3jrnsa7OWslYYLSeSFHt/WjMUWulwst+B8fZSVE8sFfsTD+zj57myQh6H1C
1qBOCsa1+QQu40TYvK0TT5OwuviFxwu4HYqPuasi0dBOxBNx81V9msAHfH9wIv08
cGzoybrExDYN4t4rAQioixchUtAiKA==
=8Tv4
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--

--===============1862167558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1862167558==--
