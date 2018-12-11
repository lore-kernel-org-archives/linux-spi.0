From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: lpspi: Improve the stability of lpspi data
 transmission
Date: Tue, 11 Dec 2018 14:29:19 +0000
Message-ID: <20181211142919.GI6686@sirena.org.uk>
References: <20181204062122.28745-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181204062122.28745-1-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 04, 2018 at 06:22:15AM +0000, Clark Wang wrote:
> Use SR_TDF to judge if need to send data, and SR_FCF is to judge if
> transmission end and to replace the waiting after transmission end.
> This waiting has no actual meaning, for module will set the FCF
> flag at the real end.

This doesn't apply against current code, please check and resend.

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPyb4ACgkQJNaLcl1U
h9CHXAf9FzW3QYoHquCa9xNOaHc8+L8/4d8c8CsaMHI/hjWw2TNzTKR15YFgmJZf
68l/M19BJNklr7pLcp+Vp0C39N5GM8FXxZXrOJqRQ7c8Vxp5tBajb4oxNaoag9xc
Gc7nq55WTK4zyp3A2d4K7aATEuo4eEYCaZGKbIFgowKstKYAJ6JMGFWrUTi7DoPx
KN+odSPJxxRB0HqLmNYRLsPB5S07e4cI7cVd8Kr79YvIbwJgMsmqFEzSpY40x1//
+la+hkQ09O39H0MCZkBnt17T1PWJLwj/vozapy6ElTnoVEMs+0aLMpt5zwtY21O2
2ZtYP2FphHoJT1vnvKkz7IEBKkojag==
=iClv
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--
