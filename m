Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8770943C045;
	Mon, 24 Aug 2026 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591511; cv=none; b=fkjRpGWvtVF5ldH+Zdkh04nG6WMLCfkwEr0sMZ/ocuzGncL+6JVWlEtognKkHbIeJ1u38WJEEpMUUUipkmzcuGWFGu20XGWLQHAn6CUv4vtuY23ny3C7AyE+wmw34oMAYyvqF7I8cleSb9IeFrXQd2z09HG770B6RO5vFMH0br0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591511; c=relaxed/simple;
	bh=QmBjA/7Pt1CAISLRFjIkOWVfg1UkXdlPJNuR6XK+ZI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYNiLGp278hbKInJw4ltJOVz9YINwEIEWl0bvKD97AUvLlALeDF4e8SeK03cWFrP7iP3QSSofyyWFPC29VwbWMPrm7W0jx67ZTuWeyayhvrrV9oycvW9i55N1Gpw8I7fpezj0jSUCzVQxA++w05H1NQIKKwoKLWNoHhDQOMrjhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5WLLDoi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5WLLDoi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEC31F000E9;
	Mon, 24 Aug 2026 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591510;
	bh=QmBjA/7Pt1CAISLRFjIkOWVfg1UkXdlPJNuR6XK+ZI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H5WLLDoiYxZpZevTMBEtekNp/E4YQuVXOvH7GIKxU5Cd60LI+LGLd9OF1+0mQwGNs
	 80ZStiLwXTcIh3HDiR2Jp4auVgov60TK9aCuuYqBY9fqHkaT/uQb8ddA3ndkpjSQms
	 zEU3Fk/7++L95b0BdXucGakOCQA4q0pyVhzDzWBwe2y/g5qZxx6r/zW2trwnWlzMZu
	 Z7sbfePhudhjELMTp4wbt346JNJOlifhKAnYc4oC1Kqp1CmMGO9Xq87Dl2TxFSWyk2
	 AwDJpXJd8CQn4i0sHuXGB+R0R3z/MBc8cI8qN+GdSASZpyiFFtZxGqlMKSGWnoAR1b
	 WbHRkNv3PvJzA==
Date: Mon, 24 Aug 2026 18:11:42 +0100
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
Message-ID: <20260824-throat-arguably-779a75446a81@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-9-61ab7aebe9e5@ultrarisc.com>
 <20260824-moneywise-magician-50d8e6ff79ea@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fyl9wjdcdHZIWmh8"
Content-Disposition: inline
In-Reply-To: <20260824-moneywise-magician-50d8e6ff79ea@spud>

--fyl9wjdcdHZIWmh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2026 at 06:03:21PM +0100, Conor Dooley wrote:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable

Actually no, please add constraints for your device.

--fyl9wjdcdHZIWmh8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaox7TgAKCRB4tDGHoIJi
0hYUAPwO50AResC409Y4PYuHIKXlDGt3GpoNlAXU3Da35Ms8BgD+P1vtliOEQ7EQ
J4IiOM+kQiLdUSwMHFqSCHhxwvBtQgs=
=owuq
-----END PGP SIGNATURE-----

--fyl9wjdcdHZIWmh8--
