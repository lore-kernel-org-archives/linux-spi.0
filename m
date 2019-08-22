From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH spi for-5.4 3/5] spi: spi-fsl-dspi: Use poll mode in case
 the platform IRQ is missing
Date: Thu, 22 Aug 2019 18:38:46 +0100
Message-ID: <20190822173846.GA24020@sirena.co.uk>
References: <20190818182600.3047-1-olteanv@gmail.com>
 <20190818182600.3047-4-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Cc: h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-spi@vger.kernel.org, netdev@vger.kernel.org
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190818182600.3047-4-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 18, 2019 at 09:25:58PM +0300, Vladimir Oltean wrote:
> On platforms like LS1021A which use TCFQ mode, an interrupt needs to be
> processed after each byte is TXed/RXed. I tried to make the DSPI
> implementation on this SoC operate in other, more efficient modes (EOQ,
> DMA) but it looks like it simply isn't possible.

This doesn't apply against current code (I guess due to your cleanup
series), please check and resend.

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1e0yYACgkQJNaLcl1U
h9AFmQf8D5Hb+Q/mrXvp1IGUl8mX3fimwGOyB0PKBjy55JhqF+9D9cP267sDeH4X
e9KOiLuQwASl9W/HRwOUAlw8kkq48mo3T20cdQ9BsoLAOf44RLf5WhKK+CQ+B+X0
BmFgdA2yIfAfBKTP0Gpse5Ow8Y3ueCuV+3yyyuDy7uXYvNlFQ2QkyWIq74AuRO6K
xK8mHj1M5dcg0YW/FGaRJ7zc4tI9UlOrlgqEx+0EgU6yM3Jxld36l+Rto5nUvr4v
V0ZoB+T4bbO/fw6mp6+x0wGqVYwsyZZ3jyfjJor+3XFDdz8bLT0bCBflgewThjzZ
2lRScmn82sShWw2HnkFfVv9mdSikTA==
=RUOQ
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
