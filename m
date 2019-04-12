From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/4] spi: Split spi message into max_dma_len size chunks
Date: Fri, 12 Apr 2019 11:22:07 +0100
Message-ID: <20190412102206.GG6909@sirena.org.uk>
References: <20190411164235.49771-1-noralf@tronnes.org>
 <20190411164235.49771-3-noralf@tronnes.org>
 <20190411181836.t2vuutqhjglsxsaz@wunner.de>
 <98571639-840a-494c-9e41-29ff89a22a8e@tronnes.org>
 <20190412094721.GE6909@sirena.org.uk>
 <B40B4313-3965-42D9-9228-92E275A7D2AA@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1867558378=="
Cc: Stefan Wahren <stefan.wahren@i2se.com>, dri-devel@lists.freedesktop.org,
 linux-spi <linux-spi@vger.kernel.org>,
 linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
 meghana.madhyastha@gmail.com
To: kernel@martin.sperl.org
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <B40B4313-3965-42D9-9228-92E275A7D2AA@martin.sperl.org>
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


--===============1867558378==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 12:03:35PM +0200, kernel@martin.sperl.org wrote:
> > On 12.04.2019, at 11:47, Mark Brown <broonie@kernel.org> wrote:

> >> In a previous version of this I suggested to Meghana to put this in the
> >> driver, but Mark wanted it in the core.

> > If we want to do this at a lower level the DMA code could hide this
> > limitation from the upper layers; presumably the SPI driver isn't the
> > only thing that might run into this.

> For clarification:
> There is a register of the SPI controller where you have to configure the
> number of bytes that it will request via DMA (primarily support transfers
> that are not a multiple of 4 - the data is transferred by DMA as words).
> So it is not really related to the general DMA implementation but to the
> DMA (request) support of the SPI controller.

Ah, I see.  That's unfortunate :/

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywZs4ACgkQJNaLcl1U
h9B/PQf/RSTE5q9iKH4n63hVRffjLEbGYFvapmk+unzydgHkjPokTJT890QulO5i
ShuaPXy+rGMZ0kXjIXGFNVgefkwBHmoYKanS8XIpUcRoiGOGaWOhqtJwuTn4peTw
ZsD1vplBImTTkbvsM+g4zEltWXZN/wuIzrd4E3cPMqC4oPCsrzaAnBG6fXpj44M/
aQu3nvLOV4A8w9BMEqEXKHRcFf032JR1FXAfURdol7Hv2+7rem9sRBDJpDbWYhip
TiNJsOfJW60pIy8a6+37DTaKFD1f0EQxWyxPHx/2c7ZT4QCaqTXfVXEI+ZDLLsAt
snjY4FjAWfqrusFuWZkNyRNIRl31fQ==
=Pkgq
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--

--===============1867558378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1867558378==--
