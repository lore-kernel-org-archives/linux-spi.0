Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704694137BC;
	Mon, 24 Aug 2026 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591236; cv=none; b=IIGf3enqo5akv2igvfkcplKS0hZ8bkVjyJ3iRhR/ulvMQbJGFUHY9XyUSU4KaRqWNVh5x+vMCZWqfS/vRjRLfqIid3lZfN1hJvmUQHZAWkq2/Bn/+PvnC8so7jZUqBg0MkqzsqN/D/MmshW4nEGtIW3taAa0nioqinl5qRc95HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591236; c=relaxed/simple;
	bh=MMXLxj6l9m9aVfmKoNsruLV9NIaNZdeX3U02TYk7stM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBwiPK/RFoYtMPQSVpQ8lujDDnnDBS2Zf2294QueV1IEQw6VCO7L/B0AK2BVf7VOctnxl2BenLGDOsZzXQ+gLhu6NjMxPt+Pi6noIwiZsGQqdNKJORAsy39MX0qSeNr0HGYBQ0U5iENA0TTePnfH0f7MwYS5o2hMXeBUrTKwOaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TT47Bvny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TT47Bvny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC361F000E9;
	Mon, 24 Aug 2026 17:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591235;
	bh=MMXLxj6l9m9aVfmKoNsruLV9NIaNZdeX3U02TYk7stM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TT47BvnyiuYe1DkXIwhnimIyDLJVmVloCdmFb94HUpIuAhnzflwBIWQWdSXfcVETd
	 UNSevj+ciCNoLKZL0GSSAMPQLZ2dTbmKuIQm5OsEAgewDqD+c+yJWYfAK/ZIiNnhc4
	 TFTXJi7wWVgBkmW3vLTa2QBr1Xk+496IkleGVYMrjWm8rj7hIYTTOOd7DRN5IgWzBq
	 S70DzEmw8kP9CrX07u99G6GEdWqdLGLDYYbb8TcKjxC1EBrlckDFmflGiT69/h20HG
	 vPwJnyuikWywcmDFWf8yR050jNuEf5Kw9CR5WNrjcPTTeB4BrBpmrhSnKK4S43FAgM
	 FZJaSlr6AdY1Q==
Date: Mon, 24 Aug 2026 18:07:07 +0100
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
Subject: Re: [PATCH 06/12] spi: dt-bindings: snps,dw-apb-ssi: Add compatible
 for UltraRISC DP1000 SoC
Message-ID: <20260824-paycheck-luridness-6de48a00a262@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-6-61ab7aebe9e5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MTTZHrZBlz9/orUf"
Content-Disposition: inline
In-Reply-To: <20260824-ultrarisc-dts-v1-6-61ab7aebe9e5@ultrarisc.com>

--MTTZHrZBlz9/orUf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--MTTZHrZBlz9/orUf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaox6OgAKCRB4tDGHoIJi
0nCpAQDM2nG7nEb5NpeKUA33Zz4XAoDHlfujQ1cvl1x6OZ51uwD+Jyb97LwqJX3y
yuJJv9nbbHMTj2TvxKz/ix14mM6+dws=
=LDwq
-----END PGP SIGNATURE-----

--MTTZHrZBlz9/orUf--
