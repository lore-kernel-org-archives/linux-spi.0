Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E659449480B;
	Thu, 15 Oct 2026 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056948; cv=none; b=WnYh9mQ2gmvGe8XHLDCyAl2eElMgGyN/W3izb4NJwBQhld/JPLBKGgMZpCt3XqG8YSKc9ftUEG5bijG5qGQKTkqPMIs1GDD8cmaPwdTJepw9FVnXb+cwF4rfTtvU4sF3F9OD2Q2SVoDJngzusqW+Z891xqZTPlPaG4+711W6HBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056948; c=relaxed/simple;
	bh=twdsE4SaXQwyayEh8kJl1LBVea5GOJqNrnFlEPHlBN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6L+MUIMsgcDqn3n2/7zmbW7LQioxyY8sYy2MOlRGTaPNv5fJXNg6cGBFH9EhoFfH9sHaBKD2KBQ9GdhEzXgZkHuCUDEsCQmYa0mDBBpPp5D+nLUb29WMTEHr08hmJ94VHTbWTl4mS/JpKDpjcSH5LXSW156YXAtQaqO6IagnGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdZWmYvw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdZWmYvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804001F000C4;
	Thu, 15 Oct 2026 09:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792056947;
	bh=5+I/3X+irMuzq/3rgZ8Cj+WqCOlwwkdDBCPYtiBzJmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LdZWmYvwFv1u17wMa2tZYnb0BYEDsvSPOHar6lj6RIcNgNU//Z2nDtOMxKC93t2Es
	 Yi2OIEnZ8AcvRCC0ufFGbQZekKtAa0ckUjxnNLp+fI3vjr/6mbFSCpzp7xjpbA8jB1
	 +H4snZkgp8yxmr4WHyS9mlqLQORO4TWT2K1dYJEBoysFm4ThQUyDUDdzuN/Mm02QZX
	 cLfsTFbH3pcNa3EmJSK+T5jQGJnuhzGKvhNzNsWEdFvBfSiuk98reiZfWs7x/wajU3
	 cu7+TV/jnMocNhoid/tfIXiiuy4LZOSOT6Cw+HlJqzNbXSOs9Py3eI6RngMsLaL45V
	 m0kvLulgP2IUg==
Date: Thu, 15 Oct 2026 11:35:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de, 
	stefandoesinger@gmail.com, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/24] dt-bindings: spi: Add ZTE ZX family SPI flash
 controller binding
Message-ID: <20261015-khaki-gibbon-of-persistence-a552df@quoll>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
 <20261014072109.1759502-20-ghahramani.navid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014072109.1759502-20-ghahramani.navid@gmail.com>

On Wed, Oct 14, 2026 at 08:20:59AM +0100, Navid Ghahremani wrote:
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - zte,zx29-qspi
> +      - zte,zx279128s-spifc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: work clock, the source of the SPI clock
> +      - description: register (APB) clock
> +
> +  clock-names:
> +    items:
> +      - const: wclk
> +      - const: pclk

Where are all other properties your driver is using? DMAs? Resets and
whatnot?

Did you actually test your DTS against bindings?

Best regards,
Krzysztof

