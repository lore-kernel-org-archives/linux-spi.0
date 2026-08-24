Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3E4334D8;
	Mon, 24 Aug 2026 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591122; cv=none; b=KJGL53+66iexRQMHU/4sOOR4cXaPnECi0doOYqfQDuNUQTYxh5szw6/vvXuvMrhsyYEuaoL82OMdBrEhhmOPUfRPScHOFesLBaZLLupFWvlXCa/hkm/+WUramN1kZtOgb4vOwNS2/Jk7pkmPcUit4gn1cdkymok9BL0gzGjr7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591122; c=relaxed/simple;
	bh=V+HlwEGMztP9hq5Wdb99DLJ26ljUC88APb9lq0jwsnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiDJPpNw9Zu8THwgDmUz2KecHEIUs7GPD+rIMYMKBay14BhHt9IJrz/9SfCRcDkdRx2wqtjYvFgLIBdSt3baqGObu7fxqappe11Xym604nUVGbCAqTLXBuevShpPfGIhya5x24VgOIopendVQ6bacpBbGXMZIMvdsowuponFPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqixNsBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqixNsBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2391F000E9;
	Mon, 24 Aug 2026 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591120;
	bh=V+HlwEGMztP9hq5Wdb99DLJ26ljUC88APb9lq0jwsnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cqixNsBgUNffSQfBMYbRlWVQuvJsYhSuHkgZPafvzIYsqwc+wzKVJjZeJjMQgcVGW
	 VAIQgEITrVFLvyfkhu23BK4ZuASmU7a9eDYA0nYduGplOrgMq3/g4FcZfbcLOqeBym
	 wVjDGwAS8yNJ2Qq30kHzfgch+htWFbuT7/HYU/E9n0+FHcxaY+Ul9GgeMpysjsKemN
	 vtYf6eYtCjgEoKjejr2UZF95JHCiHgcs0nvK2cjhPUKO/L33fyMkVLFg0az9+q2zvI
	 Bu+Db0EC32vUVm1+O2r6HFqQTqc89JP52bwEtGhX/I1VaddasvyuxBym9znBoihloC
	 19VmhKRqAYSMg==
Date: Mon, 24 Aug 2026 18:05:12 +0100
From: Conor Dooley <conor@kernel.org>
To: wangjia@ultrarisc.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>, Mark Brown <broonie@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 05/12] dt-bindings: timer: Add UltraRISC DP1000 CLINT
Message-ID: <20260824-pellet-trailing-31f6e54eacd7@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-5-61ab7aebe9e5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="odfjFMtJIeHsFJs5"
Content-Disposition: inline
In-Reply-To: <20260824-ultrarisc-dts-v1-5-61ab7aebe9e5@ultrarisc.com>

--odfjFMtJIeHsFJs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--odfjFMtJIeHsFJs5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaox5yAAKCRB4tDGHoIJi
0vmZAQDxz+Re2YDaSHq+n+Jl18vTflYxCFxmy3VOXx5r8jXv0gEA8ZyEMy2fpXMo
88b25Q7ZyEjCcQToWcKoJJFmVtAp2As=
=sFIq
-----END PGP SIGNATURE-----

--odfjFMtJIeHsFJs5--
