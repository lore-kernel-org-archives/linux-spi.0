Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75168457E73;
	Fri,  9 Oct 2026 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541088; cv=none; b=u8cPul5hRa0nGT1dkUPL+jpjeOJtSvu+hXe9foNGuYKaTV5q/whEBHh3WRXpBaJ5LMqk/1BfSgGNY9gqJtZRZGbMtAtf7BkbGz0x3+aKNIoPF1aowXJ9L5yfR6/TVonYoh3ALA5pszoTFKe4iHx6RWSBbKN6VUhIkq2u+UNWDkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541088; c=relaxed/simple;
	bh=+DNKmuouHw3F2sUn7rERptXulQELLgYCH592z3UCDWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erJhTaC72LtU990G8ZeBMmOTS69eCKyEfoaVgBAt8jRfl/7gAqS1MLDwtkOdB509Bgud8vVSy+F0tvx7PgUGkEr/Z1sKfElRHNS6fUbCkjwi4HTzP13EX8mzWp8+9ZIm8899Pg43j5DXSqYxaMIwdbcEPVOSvBCQ9y8Dgik459c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIDk5/IU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIDk5/IU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE501F000FF;
	Fri,  9 Oct 2026 10:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791541087;
	bh=2IK08WvoWJC1h6DlgEI7ITQrkIpsRhrwFymhPxbueT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MIDk5/IU6tP3YARpKWHfyeeG7ABschktkAyCEp43D1TgmMbNhOnbWuBEzKUe9lWMR
	 /CeFpSIl8ufe90s/Wj6YSXA790NYrCVsD/XaiFPrAXIUoy5zv077JDbwfOGfBHnyE/
	 sYHwIJ6/3zjaaO/jmSOCGbNfKnCqX4PMK8LZEGaoxVzmJ0SWiD3f9xAnAAu3gdQZsl
	 rP020XSgCfBZJozzUCXHBjZlzD9pHyfe1LVKQZcyQU+wwfTu4KrSPWEs2Tv7/4Jpv5
	 hsvQXwOCt7ynkBKCapGo5icvAj5mPENhu6iEZFYuyLRzhlSD6Chd9NXO7gQtP/ABb1
	 3FJyzVLyxAj7A==
Date: Fri, 9 Oct 2026 12:18:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tim Kuo <Tim.Kuo@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Steven Liu <Steven.Liu@mediatek.com>, 
	Sky Huang <Skylake.Huang@mediatek.com>, Sam Shih <Sam.Shih@mediatek.com>
Subject: Re: [PATCH v3 1/2] spi: dt-bindings: mediatek,spi-mt65xx: add
 MT7987/MT7989 compatibles
Message-ID: <20261009-tricky-fine-aardwolf-cca31a@quoll>
References: <20261008085332.802898-1-Tim.Kuo@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261008085332.802898-1-Tim.Kuo@mediatek.com>

On Thu, Oct 08, 2026 at 04:53:31PM +0800, Tim Kuo wrote:
> The MT7987 and MT7989 SPI IPs are IPM designs, so they keep
> "mediatek,spi-ipm" as their fallback compatible, but they widen the tick
> delay field of SPI_CMD_REG and therefore need compatibles of their own.
> 
> Signed-off-by: Tim Kuo <Tim.Kuo@mediatek.com>
> ---
> v2: Add mt7987 and mt7989 real device compatible
> v3:
>  - Drop "mediatek,spi-ipm-v59" 
>  - Move compatible of mt7987 and mt7989 to group of spi-ipm fallback
> 
>  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> index 3bf3eb1f8728..63b23928c734 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> @@ -35,8 +35,10 @@ properties:
>            - enum:
>                - mediatek,mt7981-spi-ipm
>                - mediatek,mt7986-spi-ipm
> +              - mediatek,mt7987-spi
>                - mediatek,mt7988-spi-quad
>                - mediatek,mt7988-spi-single
> +              - mediatek,mt7989-spi
>                - mediatek,mt8188-spi-ipm
>            - const: mediatek,spi-ipm

Nope. How is this a specific compatible?

Look at git or even read the REST of this file.

Best regards,
Krzysztof

