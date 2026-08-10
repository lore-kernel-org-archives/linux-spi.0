Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1E3C1D54;
	Mon, 10 Aug 2026 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364749; cv=none; b=WoLmUEpsqIlo+7zhskPBlZ1E+WPRymJ4UVhuDqzOSKAkjOgvd3N38fRfSuDJKXSr4eMzKBuTNfTt0bfOmVP/sItaz5q06UFZERjRBwUUmax96zjEFQpi3e028706UuPNdhHJaUsloDL+z1aPUL8N2Q955ZCEE6Qp3m9wd3a9Zdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364749; c=relaxed/simple;
	bh=+SGImHe1Sw1NGnkTVFXM+So9uxRP3NcboX61zAirfxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZckXFiPyeSVVq6IlPv1/2La4xn02TdLcT5sHHYTb+L4cLhKKz/88bue1h80cmUs9I1FwLnr6ghNB+rGhiGSk+Lbtvdz7TEJu91jexe1QymMJj5JAIMRdRxYgADVjfjdVQYLDudB4H5oQKpzLAeHHBEy6BziQfp0vufsaaswhNQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/u+uhRx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/u+uhRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098A51F000E9;
	Mon, 10 Aug 2026 12:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786364747;
	bh=+SGImHe1Sw1NGnkTVFXM+So9uxRP3NcboX61zAirfxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K/u+uhRxvNI6p2boOssYbjp+/nH43F8F8t0UIF5iGR9wL06ro1o/QV6i7cwzLYWXb
	 Pi3soYXJryou8hrDzvLHYNMkcj7rzLuTXlQ9JoT0oiJHo8wkqI98GpirYZNhd7s5Cx
	 Ht/Ep9cU3vEKIKHISvP09W6hHJ/09y6wJ/KP8NIVn6ZPi5DzgFKagDMTua+reTpiH0
	 0BEmtUY2u3X4DBboIB5bk3zdXYno58L8E+BeXVdvSfOX91zzJuxsts1RXCdcMJWWM9
	 gmCiHKtALyOKNNo7eKzC6nS72vSUef8QwbJCfUvL62NveUVvG684HweT4AEO690+3V
	 ZxmGHmg0LCDyA==
Date: Mon, 10 Aug 2026 13:25:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Vladislav Leonov <vlad@zlab.su>
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Simon Glass <sjg@chromium.org>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 17/25] dt-bindings: spi: rockchip: Add RV1106 compatible
Message-ID: <6c480623-9195-42de-9a13-fa97c6fb4253@sirena.org.uk>
References: <20260810121121.210040-1-vlad@zlab.su>
 <20260810121121.210040-18-vlad@zlab.su>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3a58eJ5RGHjnM4Jx"
Content-Disposition: inline
In-Reply-To: <20260810121121.210040-18-vlad@zlab.su>
X-Cookie: Polymer physicists are into chains.


--3a58eJ5RGHjnM4Jx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 10, 2026 at 03:11:08PM +0300, Vladislav Leonov wrote:
> The RV1106 SPI controller is compatible with the one found on RK3066,
> so add the "rockchip,rv1106-spi" compatible to the list of variants
> that fall back to "rockchip,rk3066-spi".

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--3a58eJ5RGHjnM4Jx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp5w0UACgkQJNaLcl1U
h9C3iAf+NyRB4/H6HfbMVMgbmtfWJwDWkx4+mQlRg/QJJsB16UQDVfnStvgWXjeZ
/r8fT4ETbJdneMjvNxT2SjWrRzgrMbFs64lV6V30hUEhYBA16MTyZcR9rEpDuBcC
a74jE2a6oFU7P2sMbK78pizMBvXPcBA1W28Q1W+VP3MEW1t5YqJZQobyxLKTzBWe
nEgj28jHHaugDRkNmvlOVAONvkLbdAhwVJc5sN/TzcDkiWRw0zeMlY35Ymotj4YW
oNIdLGYK/NiY3BbwEmNb041SPj+g08kmUu5DMWoIq2idRgDB1ndPIOZZekYjffF3
VQty06MYLBilknfvEaAmvHCGV5dU5A==
=2zwJ
-----END PGP SIGNATURE-----

--3a58eJ5RGHjnM4Jx--
