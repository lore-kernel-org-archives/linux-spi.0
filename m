From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] spi: meson-axg: add a linear clock divider support
Date: Fri, 4 May 2018 08:16:04 +0900
Message-ID: <20180503231604.GD13402@sirena.org.uk>
References: <20180503213645.20694-1-yixun.lan@amlogic.com>
 <20180503213645.20694-4-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Cc: Sunny Luo <sunny.luo@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-spi@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Yixun Lan <yixun.lan@amlogic.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180503213645.20694-4-yixun.lan@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 09:36:44PM +0000, Yixun Lan wrote:
> From: Sunny Luo <sunny.luo@amlogic.com>
>=20
> The SPICC controller in Meson-AXG SoC is capable of using
> a linear clock divider to reach a much fine tuned range of clocks,
> while the old controller only use a power of two clock divider,
> result at a more coarse clock range.
>=20
> Also convert the clock registeration into Common Clock Framework.

This would be better split into two patches - one adding the new linear
clock divider and the other one doing the CCF conversion.  Splitting
things out like that makes them much easier to review as each change is
only doing one thing.

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrrmDQACgkQJNaLcl1U
h9CV8wf/c7YMCGTuS+T4MV8e2xZibjN4BIJGs2dGOW9o4vu/Mehk82SJ0h2gbNFu
UhlnojgCn3fw5hCx7B3TaV6pkOnTD2T840zqLFiSIfXuhknlT537boO4xxn/pRwA
AY/wPmS093AixMpFGcbtS385tNpU6S+UIR0oXOGPZ+tm4S+ghvr8lVCRWaKKmeoc
spDwkXVuAHDPftg1O7uBa7ieZ/4Kg5ksQvXBL0Hp8OshAYJIZlpfz6zhrioqHzmo
bbOdAdR8vflr8GUGv5f1NpCoKPOVoaOc9+B4UcXUYYQfxLKjVLJZJqtCiwEADZAs
drP1ih0KRGzM9WClDdbvmH/ceNm7Hw==
=iR+3
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
