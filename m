Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795875919;
	b=mnKQHFCKrQqdaqUhjUEoHTPJa36SNwlc+Gk1NMBrJQMN8RNFnbLpLqv5K++VCdAllXzJ
	 AG+xT5+T61Pa7T5Vs3BvxL8vZD9HqVYsHcRgpNdtYkiUNmnAAs6YtKG0B62MimRmkPMXb
	 HbDfK1N5AP6IVxrkaSunns0VMRWW7oHDfPM1JXc6HKl3fLBC5wlY+tdEkuUlM6RyB6Xko
	 k6/+7WZdI98Y1/kk7I20gdurGatQrY5p5/oktzGczEsFDTLABDe5RZDwB7kn9EKZyveF1
	 FK/m9qucGsTzwpHykueOuR0l1PRDlXa5CJnbEFPQ4SyeNlUhebA6aTD9iKcPhJjXzmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875919;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=l/x9oNCSaYQ0fFo4ifv7WcmGtt7Q6tbfnPKrA7iq6qw=;
	b=nlCEBRqWlV8uSfhBzXVQvtufuU3ik8/L+JPQAuTbYhzL8WG1iB+QF0Gm9c2LYLI5ZbUr
	 dVzcXxE1Q1i+7+OoHLDjdeeKiSIEDZ4crHYLr9gOsFLqhT3q4SfyCtovecvZJgMdNU4QE
	 vw/KLvFz/stFcDSu/p7C9SzIzc3fZnQBx5n+A6KKJwQZywZvH4akPyNSQx+u3j2QED0gG
	 Rwe62vyQmpu6BPjjoSq9OtkfCjKi3EimEG4w3glvyAFxuroqcmaBUUUBrBSz6Hjh11nSY
	 LjjJBUHrtODq597SmIu9I8QW1BlxCoVXJ9FRoCp+jbHWnG3/yOlxRPg2xaWhZ2aM8Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LItuOnU2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CB2606A31C;
	Sat, 28 Nov 2026 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LItuOnU2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C0E1F000C1;
	Sat, 28 Nov 2026 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795875918;
	bh=l/x9oNCSaYQ0fFo4ifv7WcmGtt7Q6tbfnPKrA7iq6qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LItuOnU2oUvls841zaj/BO/k/B5OcyAVHfvri3ObuXh+WSwdcpGCfv5lGz0Rj5MYb
	 R6+qho0AsiRjll511xnmAtooDqesEAO4X9KJaScmNIRdFd9QTJbdX+2d37lNAxL46Q
	 Tz8mu1c01HsfsC8K1P8JzfABDt2OY6x3F4L3JnVVeUItgk28M+r2hGJA6n8E5Mn1kw
	 sE0FV8S0dBogZBr6lAey8W9l4Kvkqc04Bneze7vGI4fRgJyKeB0MSZ1fdPk7XqlduS
	 ZBV9cOlvs+hwUeKT0+yx8/b5x0bFpi/UHbAXjar4STF7fkXxSRlBpCt2VYPPH15sd0
	 OgWLEI5JLeALw==
Date: Sat, 28 Nov 2026 14:25:12 +0000
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
Subject: Re: [PATCH 1/6] dt-bindings: spi: mediatek,spi-mt65xx: Add MT8189
Message-ID: <fdf1327b-0a79-4dbf-81ba-f4da0dc6dd2b@sirena.org.uk>
References: <20261128141443.13065-1-sinha.aryan03@gmail.com>
 <20261128141443.13065-2-sinha.aryan03@gmail.com>
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
	protocol="application/pgp-signature"; boundary="+8aFEQ7wAC57vafI"
Content-Disposition: inline
In-Reply-To: <20261128141443.13065-2-sinha.aryan03@gmail.com>
X-Cookie: I'm a Lisp variable -- bind me!


--+8aFEQ7wAC57vafI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 28, 2026 at 07:44:25PM +0530, Aryan Sinha wrote:
> The SPI controllers on MT8189 use the same IPM design as MT6991, so add
> the MT8189 compatible with mediatek,mt6991-spi as the fallback, the same
> way MT8196 does.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--+8aFEQ7wAC57vafI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsK5EgACgkQJNaLcl1U
h9AX8Qf/e7espGUJCU23sN2ejhjOraYZoYRG5IEKfmroYjUkZaboYuyFOjz4rmMK
DYBRQpXresUYUlFYjj+s1IcSPQxDo57SRWkpyRSe6nPOK3mXpntPOx69B4G11oP0
c3ZJC3rv639N+y36pGtB/o2W/b2HYemnpn4G5GB7+jpn1VNPV061A6js1Ue/Mpdg
Qo4+UPCZa7W+IyzKM/4p1Z1S3Y0NeB8SUsjRbeaVD0aD3yu2zwE1YSUIzsXW9n0/
vRFQJ6xHt+bmWqCApAEKt6k+/C1wjbkSgO7Tf/z54tcqTJbdAvbO3eZV+7PZHb1o
1kOgnJ8sqN0oA6GXLDItXITnSvIqJg==
=POvc
-----END PGP SIGNATURE-----

--+8aFEQ7wAC57vafI--
