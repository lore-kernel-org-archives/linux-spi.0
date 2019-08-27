From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 5/5] ARM: dts: ls1021a-tsn: Use the DSPI controller in
 poll mode
Date: Tue, 27 Aug 2019 19:31:54 +0100
Message-ID: <20190827183154.GI23391@sirena.co.uk>
References: <20190822211514.19288-1-olteanv@gmail.com>
 <20190822211514.19288-6-olteanv@gmail.com>
 <CA+h21hqWGDCfTg813W1WaXFnRsMdE30WnaXw5TJvpkSp0-w5JA@mail.gmail.com>
 <20190827180502.GF23391@sirena.co.uk>
 <CA+h21hr3qmTG1LyWsEp+hZZW2NJFtg9Dh1k6SXVDd+A_YSQjjw@mail.gmail.com>
 <20190827181318.GG23391@sirena.co.uk>
 <CA+h21hqMVdsUjBdtiHKtKGpyvuaOf25tc4h-GdDEBQqa3EB7tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gIORF5nGxIt+AP0s"
Cc: linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hqMVdsUjBdtiHKtKGpyvuaOf25tc4h-GdDEBQqa3EB7tw@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--gIORF5nGxIt+AP0s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2019 at 09:16:39PM +0300, Vladimir Oltean wrote:

> I can't seem to find any situation where it performs worse. Hence my
> question on whether it's a better idea to condition this behavior on a
> Kconfig option rather than a DT blob which may or may not be in sync.

If it's unconditionally worse then it shouldn't even be a Kconfig
option, just make the driver just never use the interrupt.

--gIORF5nGxIt+AP0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1ldxkACgkQJNaLcl1U
h9ARswf6A+M4PLUEgqtq4LS9LU7LpH/qbPKXT1byjJNJOzZJhiaNOdOfiQUXTpHH
bipXfDjoA+Bq5QZyp0VX6qO8heo7sSdZzmNKx3wnydsKCGck5e3Ste7Yru5PY2sn
r9pdyH1nFG5BSfaxxx4fDzBArcNXJM0fo2lVxpwk4tNuviBMKON55SrJ8maV1Krm
1Tut3wZxZC7UtS5GQE6TDTGpSRSKjEMLNodsZYLRcbh+FimChm5jEHHegB4hLv4b
o9+IhSlpp+NHkSCoYN2kQmEEi03g95O4mbHSqonF3mpmM4qXQuGsM8brK+UoRgpe
koyv59Xv//Wv79iCrMHH3tiK8FCRKg==
=OKu8
-----END PGP SIGNATURE-----

--gIORF5nGxIt+AP0s--
