Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7FB2F1FDE;
	Mon, 24 Aug 2026 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591011; cv=none; b=A0aI2wcrdT2BnsX3wSh/jQNY7SkMb+wmrnser1bwqMbK4uS1qmJ0lJqFu6MZkMC1NhKsQvRiFcDfokIBxJXiiIp3RPAHEOfJJSmSbKCBSXLmF3kjlJtQYxs6EMfosbdmttS12o96rY9px8NjCQIC8BqhulSDefMEtAUAjPWEMdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591011; c=relaxed/simple;
	bh=G4ende/eoSLGEho90gxNQm7ra22ei4NzAi2Oc7rX2x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuoodR9+iTy03quc2GdHa++I0/USyJFgr9/AjJSOdZeAQPctBYqU2/k4U/7eoKyNRqJiY9KP1/KXTaqS75TVrK4+mC7VQIwHPQyFdtqy/Cw7m8IijinnyPpIOx6kX/bxOuTRqRTzfPseWqSTKVP7ZkohPaoK1dYumFBAQDMqYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIn+NgEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIn+NgEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6531F000E9;
	Mon, 24 Aug 2026 17:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591009;
	bh=G4ende/eoSLGEho90gxNQm7ra22ei4NzAi2Oc7rX2x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HIn+NgEcO83a9spf+othD0fuBD3XjMlfQgyM9ZIOebuVND7H5z/Gh90cF7efDB804
	 aHxQqdro97ffwBzQbLphOCZgK5GCDC8bycOjQBsrb0SzRU5fe9bOUN9aSqGnJaCucf
	 zxzM+iXZ/r2K+y6x1F4LUOZNkH9OYQ90EuQvWdq2+wPnpC0/Xt/4PUUGL8722O4sMD
	 vfKyAA05V1ayM5xKrXQY57ob21Uzz9G90FMSUo6ImjpVEA/45kfxtXUxGU96TvAMCY
	 4LaLcnQwlw1DrLeFp7uT934SW6R6jHxxJfS7rpKuSSZIXY3WAKaird/Gtb5q8Xz4E/
	 j109idqLdbusA==
Date: Mon, 24 Aug 2026 18:03:21 +0100
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
Subject: Re: [PATCH 09/12] dt-bindings: dma: snps,dw-axi-dmac: Add UltraRISC
 DP1000 compatible
Message-ID: <20260824-moneywise-magician-50d8e6ff79ea@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-9-61ab7aebe9e5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HuDlyXuePX1vv+S/"
Content-Disposition: inline
In-Reply-To: <20260824-ultrarisc-dts-v1-9-61ab7aebe9e5@ultrarisc.com>

--HuDlyXuePX1vv+S/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--HuDlyXuePX1vv+S/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaox5WQAKCRB4tDGHoIJi
0mE6AQDxuqES34FDVU9rYRaZnYR8X63SNXH55rWUuKWbhDaWHAD9HBoKTNBmlCl2
Zg8qGGAo2ZCE7MhOGmxFmInhTHKYPQ0=
=vmBp
-----END PGP SIGNATURE-----

--HuDlyXuePX1vv+S/--
