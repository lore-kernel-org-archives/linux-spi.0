From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Add a sysfs interface to instantiate devices
Date: Wed, 27 Dec 2017 10:31:15 +0000
Message-ID: <20171227103115.GP1827@finisterre>
References: <20171221200309.17967-1-kyle.roeschley@ni.com>
 <1513890342.26695.4.camel@impinj.com>
 <20171222155603.GM1827@finisterre>
 <20171222171108.GA31574@senary>
 <CAMuHMdVmNv8Pji0pGGS8L0Q0Rcp8FjCW3Y8NSMdGU3OHjJTNhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mejza3ZMMA5Za1mX"
Cc: Kyle Roeschley <kyle.roeschley@ni.com>,
        Trent Piepho <tpiepho@impinj.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVmNv8Pji0pGGS8L0Q0Rcp8FjCW3Y8NSMdGU3OHjJTNhw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--mejza3ZMMA5Za1mX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 23, 2017 at 09:58:51AM +0100, Geert Uytterhoeven wrote:

> >> > > + struct spi_board_info bi = {
> >> > > +         .modalias = "spidev",

> I would make it a little bit more generic and extract the modalias from the
> string written.

Right, that'd be much better.

--mejza3ZMMA5Za1mX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpDdnIACgkQJNaLcl1U
h9BM3gf+NhwkWbl4DVnbXIRVCGmY0JN+xizLta4WOtJzQ/0YjPeJsKwh753co2GE
7GwXcQvmQKN4P+UXCoBFX2SI53/JX0odlewfpzXnsceBGKTsfFdiVGBmVu5eAuAG
AXar8JrLfhy2U2sBVP1mMsp3Muz2PjFZTwBilgaK+68mcr490Mv/qUJifIzZtkD/
L2ya+eOgjYxCsUafuiq9TPv+EVXXiFiPB91Uh39+Rp+lDlVTKigiQr5cbX/91dpg
AsYJLc+XKCa6Ry2HVVDpOfnRcnr/AI5GPdxRiRqw4eJhnEO3fNmXX/q3KhoKSJYZ
ZVKw5tqRCRTVC3vB4UZo0xyVWKY9Jw==
=jCvF
-----END PGP SIGNATURE-----

--mejza3ZMMA5Za1mX--
