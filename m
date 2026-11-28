Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795876801;
	b=sD1baqk2s9qj8MVNgFleEPfmIJh+W/uEpk2yAnTr0aRo92s0RmDrkxJaoz6KMKy116M1
	 FWtoFoJtj24l98fm2AHpD7SIFj2NNaFSs4nCOmuRe3i7tfwtvSa5Xm/JEyp3zm86Hlcgw
	 tutariSXt6XqhWy0P9LVRqCyHvdxFR1JlNhz02GgaZaxEMJNuLdolRVd9GzwyaOr3bAik
	 IPAM5Mk83nXKHFaoaQDg1Tb+mHm77mKHPQdPxGJCM3kAsQCxHAXRoDHlmXkSh0yrw3fvS
	 bNiG9uEjusVeB9nmmHz+26u5s4/U4VM3S+RkVXGotiwKifgKb+K7jdmpcPFdS3EQJPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795876801;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=CqRWFQU4HAOohXLgQtCLu/UPaRloWyOWXgxDIeawiJA=;
	b=giNPOQhPXtizowdTl8ywWO/igrUSOArsHd52a9PaA5y0mJu1w3Rm9gLTb2s9wKXftAe7
	 JxlJXnePtpZ0lC08qYlqSSWYcJxQwbgX0lA6ZKu/QktbaMHbDjbGcKX5SPBOYdt3Qo/Uz
	 tbXChdJs6qqrPskvhl+2Ho+Itey+Wc/xYSBdgbNsYZGpe55Y8eJrCWYc3/U4EHDEdL6Cu
	 Qftj/peHY/AThzwPg9dfu8G+ev+xPmZwnRhxZmz+1DBM+4+j8QTvTdbKVhwEIEmAVQbIJ
	 hi8ytl4+SFtukQ5Rs3xmgTBjxP286PEf+rvAndV8h7jKs6H0lcv3j9FqVmeUsARtzpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baM8f1mr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C1606A31F;
	Sat, 28 Nov 2026 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baM8f1mr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5B41F00893;
	Sat, 28 Nov 2026 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795876801;
	bh=CqRWFQU4HAOohXLgQtCLu/UPaRloWyOWXgxDIeawiJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=baM8f1mres9uO12OFtOaFlb3HfysDztOwr+6e4+HBes09OTmAg0wFd64Z3M6l/C5R
	 aXLfcLuuSy/3VX0ad+w6/SR6tyw+mq3NhgaYu02a/002VbNkbf1ZSWf63VXLqXGtVY
	 plAt18yjJoNH8rFP7RaMLPf0fDU7Er1/ROhJ9aOVbaZ5tYAKwC46ct7zq847c4W/Jb
	 rz0vcU6riiew1UWOPlZWbUM8h9ETslnQDqm7BGLyOKSTfxH5OTA5cZF6Ls4YIlY/Gu
	 3iroaaKXmQmg3ekcFa2+s5d7Q8XeXwWfzn0AYhYdimTE5LoE7JGk5yiSdNHemBPZny
	 7G1ltZUF1h6OQ==
Date: Sat, 28 Nov 2026 14:39:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Aryan Sinha <sinha.aryan03@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Leilk Liu <leilk.liu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6]  arm64: dts: mediatek: Add MT8189 Skywalker based
 Tarkin Chromebook
Message-ID: <9ec63a02-b5bc-4053-a57e-73fd8d290531@sirena.org.uk>
References: <20261128141443.13065-1-sinha.aryan03@gmail.com>
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
	protocol="application/pgp-signature"; boundary="V8m+wOKX6nK14KkC"
Content-Disposition: inline
In-Reply-To: <20261128141443.13065-1-sinha.aryan03@gmail.com>
X-Cookie: /earth: file system full.


--V8m+wOKX6nK14KkC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 28, 2026 at 07:44:24PM +0530, Aryan Sinha wrote:
> This series adds initial support for Tarkin, an ASUS Chromebook (CM1405,
> CM1406) on Google's MT8189 (Kompanio 540) Skywalker platform.

This doesn't apply against current code, please check and resend.

--V8m+wOKX6nK14KkC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsK57oACgkQJNaLcl1U
h9Dh8wgAhupAOzs6+deFwZFiqJq70oQELcg4aIForI/rMIZH8rAKG4Dga+Ea4E34
0VRBwb5ocmyZrm20NFpj+4WjKnejGQVNlDoCixTEI+3+Ay9ZnCxSKgA4d5BGv/EZ
c/1ybKEPiq+ejX1RaOGgTgjbvETFt3q5k9qQiSceNQvq3NtTo/1XB/3D3RU/etGP
SSrcIiqDJL0gpv7rDNB9/iIdwp+25Z1vSvS36HUs98UdERooKnZBuAhq7hH8J4yO
ZNsl/20kqqu6JkV2NYAcM2Wq90EwfmF0TPl0UZrV89zNBb804LVnyBjeiZnm210n
kk3dT9sF3dTgvd1SNrL315i7zRfP0g==
=qnep
-----END PGP SIGNATURE-----

--V8m+wOKX6nK14KkC--
