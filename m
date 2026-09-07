Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5351FCC9;
	Mon,  7 Sep 2026 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788803751; cv=none; b=qbUD4E0pSDaE+MkRIcMOafNMxipv58JrKoJ9vkrFM9F99mxmmcHlQCjXeCK2KSbQdsW1sgiOxtpxLZgAXGIG3hsol/GdwhXXx/njJLHPab+WqXHSBwLFIhA6IMdgnyo4z/fA2ZbzSPykEvqTk7CfUGNCP0dzXVCmiL/mSZ3Pd3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788803751; c=relaxed/simple;
	bh=zFwZ3aTuoG6l+JlOvi4Rn1XMOdYQDYfEgriG4skJbTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAIjgo7L7suQD9sNIJenVLdKwU+Lcno5TKaikMzx07N15aO2PcBX+VJjF4O8tjZibtMiItT4bvGV1VttSzrEWc7oKQsrvi0fgLt9akppOogDDj/tjSjJotbP2Hi1Jb1N9Lx7C4IV2A9tHBY2XxvDAyGVuD3qWHAefkx7uX3WvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cK493fxy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cK493fxy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C281F00A3A;
	Mon,  7 Sep 2026 17:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788803750;
	bh=zFwZ3aTuoG6l+JlOvi4Rn1XMOdYQDYfEgriG4skJbTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cK493fxywA8XFTOxG3eZ/rlNaeOOXkIUPItPfxPqTJOZf6Yb++DEBM6Ke1a0JXhHW
	 mlZCW7U/B8OI3MNwWomDSQSs6vkRejRnsgZxqcF9AodbQTFB49yce0ZzFbjLZPS+aU
	 GEpn68UHD4fOLIfqrE+ANtQ/0tBex3X7aQCizLghHidAOlPbAXfPXz51Qa+E8vg0FA
	 bFzMAoZbgv0OU221WIzvQETlxIr/AZ6AbrE4depKbKZa8pdf8wF57UVJ5AJpY9+OrS
	 /nczJxX5PGv4FaFrQKt3DeuKjZN3nOcezh3Wlabo4IggzELtwycocnVhhE38ATxMMX
	 L9xA66gjKdpCQ==
Date: Mon, 7 Sep 2026 18:55:43 +0100
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
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 07/10] dt-bindings: dma: snps,dw-axi-dmac: Add
 UltraRISC DP1000 compatible
Message-ID: <20260907-dash-valiant-80719d39c13d@spud>
References: <20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com>
 <20260907-ultrarisc-dts-v2-7-5eb4c97477c5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nfvFzp1kLlzNBImv"
Content-Disposition: inline
In-Reply-To: <20260907-ultrarisc-dts-v2-7-5eb4c97477c5@ultrarisc.com>

--nfvFzp1kLlzNBImv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--nfvFzp1kLlzNBImv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCap76nwAKCRB4tDGHoIJi
0hjzAQD4g7slfKh4B+IH2bYyZuLbUUWCwQd+pppRBZeItD+R5QD+NNBkXVmmVTny
IKYWMhJEYSx8VRzVDMtzOvfad+AyXgk=
=dsHn
-----END PGP SIGNATURE-----

--nfvFzp1kLlzNBImv--
