From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: meson: Constify struct regmap_config
Date: Mon, 5 Jan 2015 20:11:41 +0000
Message-ID: <20150105201141.GK2634@sirena.org.uk>
References: <1420448821-9942-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45wMVEkw4XUbiYON"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420448821-9942-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--45wMVEkw4XUbiYON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2015 at 10:07:01AM +0100, Krzysztof Kozlowski wrote:
> The regmap_config struct may be const because it is not modified by the
> driver and regmap_init() accepts pointer to const.

Applied, thanks.

--45wMVEkw4XUbiYON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqu/8AAoJECTWi3JdVIfQVw8H/1QYQCphSwMTJFrYStcURBiH
p16kJAUTOCPSGOwFuP4VkRXqhlegjGkiOzHYsUh9sKb8SE83JJu2EBEwefLzsk2r
U4d0geYs1Tfv1rCcfxr5eWLsO2Qn6eBZPSUSmhbGiwTUf3adyPJBUzMSyC4YYrWI
zuuRJKd4vH5ktwf9SBSUENLdfgVq/816+nLMOx8GsPiODZ7I4VANYjX2aglylWPS
i4zzPsDJDibxbnCVGxQRzzIdvXoW+QX7HHI9VpaZ/9ejv9z7Muyex/Zsd+gOnitr
6vBxXCwnsQ3gpTZ0aOu+NuZBkOg8lrDhRduf/y9h06HP+yY4PUDsWFVuO0K/mUI=
=PoJS
-----END PGP SIGNATURE-----

--45wMVEkw4XUbiYON--
