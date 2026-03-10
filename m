Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AE7349B15;
	Tue, 10 Mar 2026 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171731; cv=none; b=Z7y8KN10W1itYvvjqi94167TBYhHbNCj6Vh0QzLjSa3hioEPwVJx+r22byZrW3wacJcVgShfAtkJ0WmL+LvtKNDIMEBEr/CQ1KeTvuhOr2rJa72vh61892I/d99eNr+5s2IzJnvKEVI3J12pe1x70vLD0vckNBHCloFPmmyjhaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171731; c=relaxed/simple;
	bh=CigGH6JiI8W8KJKapguNODR/msvRj40XB6BkvqNHkKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tn66Gm3H4gaeyM8TbWnxgoccEDXzWJj84EXfiHu/CKXLcFyLHFe2a6ZmpKX8avKV8IoLfaSpBgD33SPXPvESs1LoS0Nr1AvZ4jRtnfIaRuxtC3cLPgVqqW74XiWsK6b9mTCL671YqxCuzcaXHqBQFdSApGnfhMxOuU6i4lwHAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijjLGhNy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijjLGhNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8618BC19423;
	Tue, 10 Mar 2026 19:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773171730;
	bh=CigGH6JiI8W8KJKapguNODR/msvRj40XB6BkvqNHkKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijjLGhNyEcPEqHKDIl15varq8Q2E/Oh5l/VOD4WQfcGfEnglkEaSWsMijccA1v4Vz
	 ijAb08LXcTM/VrneSBWQ0aq0RRFMPul1NWf4gfhA9gy5SRBAAO0sv86SVNmoEy/Ufl
	 7RNTEEUMcr8ATsO8A9PeYQJh3oXquoIFXlfAtci4Y7SU79MDWBcbmVtCzpXU+4kJ/D
	 WRV9OSYmWfkngIimkKyJ0eJ9qYEx9+TjQHkyM0qp39daqquH5NYgpZ5CY/Sgz6yPPA
	 mCnjhn0dEftZu5YrRgmbQoD8b22TzdpLUHsq7qTrSBBmGAxAAoRSLUkBgCdFcROJ2u
	 fQsJOmXW8uIqg==
Date: Tue, 10 Mar 2026 19:42:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64: allwinner: sun55i-t527: avaota-a1: Add SPI
 NAND
Message-ID: <f3ed7b81-4e43-4baa-8a56-b18fa7f56436@sirena.org.uk>
References: <20260302153559.3199783-1-wens@kernel.org>
 <177317166704.379398.1719490251066452420.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HEq4wRQDZZFl5gi9"
Content-Disposition: inline
In-Reply-To: <177317166704.379398.1719490251066452420.b4-ty@kernel.org>
X-Cookie: A fool and his honey are soon parted.


--HEq4wRQDZZFl5gi9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2026 at 03:41:07AM +0800, Chen-Yu Tsai wrote:

> [1/3] spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI for newer SoCs
>       commit: e2f93f45d38f7b6dacb44203cfc7bb5d7e287b8e

I'd have expected to take this one?

--HEq4wRQDZZFl5gi9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmwdA0ACgkQJNaLcl1U
h9Byhwf/S7pGaDNtUJP08GdwI+ftl6eicg2ff8c5/ZBis8+eTVl0rPWoSjWzjq/H
uZg96h/gr+O4QYPKgmVeZqDWt93mDNpveN4bpD6OmVBxRjRiKBP2Sn+KiCiPe2bU
F0cwm6KO5LxJq756b5K9s+HoGXMsLf2GMq5P4CSuukLsJP73bqc8Ca/1DmbdGWVk
jk+txsG9vQ8Lu/iwu+bF7TrlCu62jlOWQ7Ea2EDgYfMRM8mA5ugtLfd1cHOu78BQ
Dsjubd4TjVIpg4s3DrPdmvWPP0I0//BJ09R+037oh4UzIR2XiO3OgNMo/LNQvgb5
0OPd5Of1BySEEHkcXaQpLIfhthE5ZA==
=U8r6
-----END PGP SIGNATURE-----

--HEq4wRQDZZFl5gi9--
