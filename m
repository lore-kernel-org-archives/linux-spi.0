From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi: bitbang: Replace spinlock by mutex when calling
 chipselect
Date: Fri, 14 Aug 2015 20:19:20 +0100
Message-ID: <20150814191920.GK10748@sirena.org.uk>
References: <CANMq1KB2zxPPCbxh4K-REUgp-83s=MPcGRjz-p1fK1PQMzyLdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m699nQIRt8EJjqXo"
Cc: Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANMq1KB2zxPPCbxh4K-REUgp-83s=MPcGRjz-p1fK1PQMzyLdw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--m699nQIRt8EJjqXo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2015 at 06:24:05PM +0800, Nicolas Boichat wrote:

> Anyway, the "safer" way to fix this would be to keep the
> prepare/unprepare functions, busy variable, and just protect it with a
> mutex instead of a spinlock...

OK, that seems reasonable.

--m699nQIRt8EJjqXo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzj83AAoJECTWi3JdVIfQWuUH/19SfPqefeJoOALciub7mK2U
r23lPEHb1/6LVTG3s4dCMe0plCO8fob2XZKnAOHDbo289jCCZAy8Sa8a3S99fa6L
6rphlxrPXRKPD//6b2crahJWRvFer4gFt2+HZsdg/NNBu97ugkcUkORArVKKXNDu
R4e6JGyPLgRaxOxHt62XkQjvzqtSmiSCsxxxadCkUu/wzy4TCPM/YTnhaW6SzGJh
bSPo++svP+f9S3lQKVAVSwHoAphRn96JjTUvSGcW2r4CHDQQG3rki5tXlFHiHJIw
j1x+45g5IPHmj/3hfVLc6RjCOGknNq1wpiicXsY9BWU8dwHLXbUf0N3X0M6YzQ8=
=Wqn0
-----END PGP SIGNATURE-----

--m699nQIRt8EJjqXo--
