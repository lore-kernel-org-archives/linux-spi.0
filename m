Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2673453A50;
	Mon, 24 Aug 2026 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591400; cv=none; b=YGZBiTn4CS0XEkQzEpDZTyffz/ivdcy7NAHwC8J4eEwmiDaG/GNDtATuw/DvhK5BY7dvYUkpQM5X7u5ev3hnmINl4rWjjYOXWffZ8+BL6mpHgFFlRR7OJayJSuEkNyYmn9QJqaLikMReD79mxPZWZyNaNvo3HdmNZMVOSJB5vB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591400; c=relaxed/simple;
	bh=FgChfMGiLK32deSNrFItn2zmIlLtFV0wAcS3/9wz4s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqk0UV0/79oHIHexBFtNtGkqDMcAdoMVvq5rUkFlkpZR5n517W3iwAXQ9qnVZkBHds6bWXgm/YwB/YrxsPa6+QL9CqTgr7SFcjZt9eYMTPtg7/k71zOqpYA7RIjXMf49EBYEUEENxnju3Y0O0id97rD4I2EpobKuzV6yKAf2fTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBE4zd6g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBE4zd6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B490A1F00A3A;
	Mon, 24 Aug 2026 17:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591396;
	bh=FwmTQgduIcESVM14ioF4YCJ2FYEmLMqGqgTSkuep9b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KBE4zd6god5alO0ShtW7GkVbW2bSx08dA6sgkajjGqtJDJMdqBhppvL3/AAmYh7uY
	 aFqnh+QUazqvPsdVBAswvmlh4AyFhXUQ1AkzPgJlHGXmWbjpaatrszxSdcp9sKwEDp
	 N+jVv8V3zL1ZHJXvRUN2XjSNBEPkjHvdb4GhnFBpS8i81zAKYZfkHZe17rNg3afUr8
	 4eGiNf62laEB6aBRCozDokoSUqPCZnZbHHxDbkOEjZZuHEcJTjlmFqoskco0VFmqLC
	 PHhqx1p837AmjA7rcv9u5A+ATtHL99hRHdLtx0hgtrXvN1xLsES/yoJ/71YCAY8cNZ
	 /0DZei7eWWKSw==
Date: Mon, 24 Aug 2026 18:09:48 +0100
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
Subject: Re: [PATCH 08/12] dt-bindings: net: snps,dwmac: Add compatible for
 UltraRISC DP1000 SoC
Message-ID: <20260824-bride-food-052b313e4b76@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-8-61ab7aebe9e5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="67g/wgnDkPTAfNY1"
Content-Disposition: inline
In-Reply-To: <20260824-ultrarisc-dts-v1-8-61ab7aebe9e5@ultrarisc.com>

--67g/wgnDkPTAfNY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 01:54:21PM +0800, Jia Wang via B4 Relay wrote:
> From: Jia Wang <wangjia@ultrarisc.com>
>=20
> Add the SoC-specific compatible string for the UltraRISC DP1000 GMAC
> controller to the DesignWare MAC binding.
>=20
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

The dts may not be right, but I am also a bit concerned here.

This binding permits 100s of combinations of properties, of which only
a very limited set can be correct for your device. Just adding the
compatible permits all of this variation.

Please add some restrictions.

pw-bot: changes-requested

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index 2449311c6d28..2ed4564ae99d 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -119,6 +119,7 @@ properties:
>          - starfive,jh7110-dwmac
>          - tesla,fsd-ethqos
>          - thead,th1520-gmac
> +        - ultrarisc,dp1000-gmac
> =20
>    reg:
>      minItems: 1
>=20
> --=20
> 2.34.1
>=20
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--67g/wgnDkPTAfNY1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaox63AAKCRB4tDGHoIJi
0nLRAQDinWB+XfM2/QTXUk4Ody64yC5jV6BrjL3lw7bW3tgNPAEA9v9bujPOE9gS
y6K7xdapP5bKe9eVLZuBpEH8dYS52wQ=
=xtCe
-----END PGP SIGNATURE-----

--67g/wgnDkPTAfNY1--
