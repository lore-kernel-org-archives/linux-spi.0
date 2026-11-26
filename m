Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693463;
	b=AslB5gi4qTexrtnG88vyLAdagKgjjoz2tyc0c+9XysXuA3PwmDmgk1caVnVBLJbIq85x
	 Hr2rbXSaoYejBhbGnmpBm3Y9heNs6FtiWJvyIc8yBWys0R0Rf/lkQrIiNGihnnNWO4jRu
	 AYBMxvCnKBTAWU+VEdAxzaN6BqVgaJof13lwaW5IqNqzULWg8HNEPQrT977AbDEJgz1EF
	 iaTO/3Uu8S0BECIAOdMbRzIUefNHoUS+9eUS0aokkjuJnCXPuMDDF4qk+QBQ/CbxnulvW
	 sSIV8MI0QN4mpYFlpW/SphyAImD/wvZJ/DQ44UyYFeDM6uO6HNroMOyjk53eAtbwaKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693463;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=GPBJLsJh7gQ+qJXgr4h2BZwP0qjmmcfqj8Qsq6esC70=;
	b=roAxDNJCbBTt8clH9u/TQrjtsxjI2vnLOUgRFB513CJa7b3E99ZSlA0xU4Vz/tSFPap4
	 1W/NymA1slCMVpvG9u1lUKSayuV9gzEg8SHtT3ZtwZ/S17W7jaJCWsaTjVuM2y8z17Bok
	 Ja+PKiV3Ccoxyan4LlKka7+T23VD84fMyg1ZKclN5rkCj8wMYcmE/x2v6Isx2LmODyt76
	 ejn+aE7xHQBSYM7cx24ZNavG8UA8KCW7RmzHblJNhtkD3zKu78Nz0C0AC9dtAJmreRul7
	 PZbbJSA7Z29bTYAh5ksI/17UpfLnttBQ0Erg+SUMzXPdrNG0G5b+U/0up+nPWGckTlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5KR91DZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FB5606A31C;
	Thu, 26 Nov 2026 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5KR91DZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60BF1F000C6;
	Thu, 26 Nov 2026 11:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693462;
	bh=GPBJLsJh7gQ+qJXgr4h2BZwP0qjmmcfqj8Qsq6esC70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I5KR91DZ584LXSWHTtNd251Xc4KwiWYJ4AJRKVkJ1r0D3SY+CrS6hjK0ZdPxO5jcv
	 zAp9f0i9i1SS6WnX2UkCWgy5XqFkqWskW3j87+iGXSBDb+wi+llCR1rYKEjuIWV4PP
	 z61qtaLQefh0EyX7acLiYvq74cDIP+qycIP1IJMsHBh4Y30MYrHlmuxMbIE5UsJhN7
	 OKeGpvBVZBngzFO5O5QA4O3UjAq0DhLMCG0Dy21gA0PbqV7gMwsjkZX9jBijwXU1XI
	 +PkoElwyIKWl6JtcrzS0G6ZQ9OjM5Ylpoji0CCYNHI1Fi389eDBo8gi7PDPAxQdqDf
	 wbFqknnn+UOSw==
Date: Thu, 26 Nov 2026 11:44:17 +0000
From: Mark Brown <broonie@kernel.org>
To: iasnezhkov@gmail.com
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	flora.fu@mediatek.com, amergnat@baylibre.com,
	leilk.liu@mediatek.com, me@adomerle.pw, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: spi: mediatek,spi-mt65xx: Add
 compatible for MT6789
Message-ID: <f42a3782-35d4-4bb1-8c72-0dc56b8e0642@sirena.org.uk>
References: <20261126000711.16163-1-iasnezhkov@gmail.com>
 <20261126000711.16163-4-iasnezhkov@gmail.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C66k9UD0zapb3tpO"
Content-Disposition: inline
In-Reply-To: <20261126000711.16163-4-iasnezhkov@gmail.com>
X-Cookie: Sank heaven for leetle curls.


--C66k9UD0zapb3tpO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 12:07:14AM +0000, Ilia Snezhkov via B4 Relay wrote:
> From: Arseniy Velikanov <me@adomerle.pw>
>=20
> Add the SPI controller compatible for the MediaTek MT6789 SoC with
> mediatek,mt6893-spi as its fallback compatible, addressing v1 review
> feedback that MT6789 SPI is programming-model compatible with MT6893
> without requiring a driver change.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--C66k9UD0zapb3tpO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsIG5AACgkQJNaLcl1U
h9DVLgf9ESvlliyKURSSkiS05SjNzqq0K0AUAZ+Lw1hNyfPT1cQbMLU6KGxATUFk
aRW2i5ZdLBxZ/ZI75fPxOZpHGGX6yvY45i7bo8L66kHm5zk32j3zZGOJm6XT+O+H
k0sxzD0y3YOiSmF0ba7Nb0WTwNX9lS70ws5v4f6/CmrESq3U51r/vpEQfv3e25gb
sj4XZo7W9B2Bf2Bh48BLMfMZoWvHbw1k81oEw2pv7JY17v+s8zklfaL5ot4N3nwH
7XIuIpNiVMRb0gdHLWBCYavSy2+pM/KPRkgtzgcNXhHx8TUxTvzhyLevA9HY3Lky
LRlR90pFAqH7HtnmRnaTkE42bnRqRg==
=FF7l
-----END PGP SIGNATURE-----

--C66k9UD0zapb3tpO--
