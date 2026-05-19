Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2A394474;
	Tue, 19 May 2026 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180749; cv=none; b=MuoDxWFQ/jIu2Y42aG1B0EpkZfrI9nffEaxcKUDUUFC6hKekTlKEgWddamYbc1fwTNRh8QEk0Nrosp4uStfKo9ShcN9dOhz1q/h6yGUfD74cFSw4MXfBwQJ82/9AA1ir4R1r7cZfK20J9/l4iVraumHBW2+Jpt8k9a1aOfEiGvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180749; c=relaxed/simple;
	bh=+HfGak7yHuL/XgYwB0Bq0zu3smcoi8dm7pRi4GjPR8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1C+In+OAHIJ14aMCedjtig0wRbhrgHUa6uCEDgNxRWeBQYOCoSvJPYaMn14ZFTqBo+WCw8Ym2TwkHv0mc/BB9v7JMIUIgpnUMIM1gkcX8jKxZBJglSCkDQkzADQRdcxy2N44DN1FoaAxnp1vjxOO53+NSrYYs6GkZQSAZVDkJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2CO19Ew; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2CO19Ew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2447C2BCB3;
	Tue, 19 May 2026 08:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779180749;
	bh=+HfGak7yHuL/XgYwB0Bq0zu3smcoi8dm7pRi4GjPR8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2CO19EwhBh9ujMggPV1riiBBdFi0ZpZd4G6bSZiquF4m7Yj7ba1rTdZ/21o2nT/r
	 mJUiJ2WVwaPjXjzPknmGinP2N5r+wa2t1EgcUyR6Ie2W8KIIkTAQdFngJxYhnxyzsY
	 EI11iIQHMp8QNKwddp8rwcNP2xiH2BVlB90fu0fMcxA2SwjIxXikODspgdzf7nlZfY
	 6RjdTGEoLu8EEPIzvYOTgurM+twW40ejwhCnRxv+SVv7ar4pl9RbCxpPM1/KTyZf5u
	 x1LznxrbbM63VSdPi4kVrqOtXiRBwclF/rjYiEM6G7iFmSBghs1OBCHR/Tii6oW0g2
	 Rwr0GnJXuxc9A==
Date: Tue, 19 May 2026 09:52:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Zhengyu He <hezhy472013@gmail.com>
Cc: Han Xu <han.xu@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Cody Kang <cody.kang.hk@outlook.com>
Subject: Re: [PATCH 1/3] spi: dt-bindings: fsl-qspi: support SpacemiT K3
Message-ID: <c7833af4-eab0-4651-821a-68c53b9a62fc@sirena.org.uk>
References: <20260519-k3-pico-itx-qspi-v1-v1-0-c32afeeaf741@gmail.com>
 <20260519-k3-pico-itx-qspi-v1-v1-1-c32afeeaf741@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8SblKUXhOngtSLCU"
Content-Disposition: inline
In-Reply-To: <20260519-k3-pico-itx-qspi-v1-v1-1-c32afeeaf741@gmail.com>
X-Cookie: Huh?


--8SblKUXhOngtSLCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 02:15:55PM +0800, Zhengyu He wrote:
> Add the SpacemiT K3 QSPI compatible to the fsl-qspi binding.
>=20
> K3 has its own SoC integration, so board DTs should describe it
> with a K3-specific compatible instead of reusing the K1 string.
>=20
> Signed-off-by: Zhengyu He <hezhy472013@gmail.com>
> Signed-off-by: Cody Kang <cody.kang.hk@outlook.com>
> ---

The signoff of whoever is sending the patch should be last in the list
of signoffs, each signoff is certifying the ones before.

--8SblKUXhOngtSLCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoMJMUACgkQJNaLcl1U
h9ChuQf+PprmNVxKDo7Qo1X+Me5eypSTZ1LJGD9uf589k2G4Z5l1SAIJ6UvdSCTC
uNghM/uNx0j6KPxpgPYumiVC5kSiMpFCq3AAalBE+TyuIrQkSbUCsOFuE+2wyJfo
vD6hBOUXU3r48JRY2YaZAnO51xdP8IpFTx09WpnWmsw9fgehpOGjumEgc7aK34VQ
MMDyRi2ex/gRHqFw4dPhJt+LTtC1DAPUUMLNFH5f/uUiDlN9mE93qE3q99m1XLWz
D7tTorYqemjTVt6XBmuodAeO0ubJFSEcPTp3QPdkRIfdCaYsCr04/+AcvT4DEHq0
sDa6//E+EXqeM3SX6Aul9vW6hvlX1w==
=VJUZ
-----END PGP SIGNATURE-----

--8SblKUXhOngtSLCU--
