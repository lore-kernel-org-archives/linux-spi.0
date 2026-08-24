Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E110146D2D2;
	Mon, 24 Aug 2026 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590984; cv=none; b=ZgkzkCl7QbtUlw+8A0j3zxs/cpqTirXqvYmsf82GEuof65crNotHP3QtxpLsZuKOHzMzhesLufAXt7pcRs6i0SwhTeX+ebbQvmwiGyZFcyGn+YpFVTmDNPE3UpzugxFuJIeVf4//iWOTidPUnIG5k1ncum6+H94fSLQYoKSg/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590984; c=relaxed/simple;
	bh=Sn3NQoSJzme6L36GWmLFTgLStTVci8FzNomPEM0B8kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPNsdpiLb1AQE/RXKne2J8ChJPJWWbf0omoZ8MwX92QH2xnRkXEb2azpe2vpZnZSOGWXWu703MgedDS2NuyII/I/NaZ4WrGinlyr9rnDAQaE0upbaOXmtLWZ1sWmpIGe71cm/Fjvp9PsaJip3SV0EqTZozjG8QX89SmXYOkiMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNgdcvcI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNgdcvcI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EACA1F00A3F;
	Mon, 24 Aug 2026 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590982;
	bh=Sn3NQoSJzme6L36GWmLFTgLStTVci8FzNomPEM0B8kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gNgdcvcIx8a+a5bYeU8B+fnCWUfUncnAfuZiekiUAceIeDGDCFrW3N6hWSGkZJal8
	 N7zzKfe3co6R2YMKW38IE/yyX1yUx0RNgAbKV9H5gf2vUSPQsvPlXiuHNFqd/rdoCv
	 jOQV8xOUfI8Py+cHAniffUfVAQZrDWaqoEqFxCYf7TWJXgBJdIP4ejXV3sVKu2svob
	 poU8QxyvF4VQzWLEjlsY1mWNXUrzXI3P9ryT7y0zE8wOc2AzGgwDmBeYxc/P/l5e+R
	 rf6SeUUFaMMh2kcrsgmnUpHe8t/zCQeOjp5aabgxkGivsHn/PehKN/Ip/sNw0SRnv8
	 lUmjVHFv2mjgQ==
Date: Mon, 24 Aug 2026 18:02:54 +0100
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
Subject: Re: [PATCH 03/12] dt-bindings: riscv: cpus: Add UltraRISC CP100
 compatible
Message-ID: <20260824-retry-line-91ca75e4697b@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-3-61ab7aebe9e5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZxiAF7oUeylrgdrp"
Content-Disposition: inline
In-Reply-To: <20260824-ultrarisc-dts-v1-3-61ab7aebe9e5@ultrarisc.com>

--ZxiAF7oUeylrgdrp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ZxiAF7oUeylrgdrp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaox5PgAKCRB4tDGHoIJi
0sDrAP9XKwIBEaR3MpxaxdfbOGBHs01AvWxiZMtJrBwMXqdaIAEAipE1uMvHlsAh
TWL/wBRbELQlrVyX37Va7BNMl5rYxAM=
=EULM
-----END PGP SIGNATURE-----

--ZxiAF7oUeylrgdrp--
