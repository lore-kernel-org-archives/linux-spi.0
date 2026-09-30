Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579BF489899;
	Wed, 30 Sep 2026 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764587; cv=none; b=W3JyD0IKo0b1v174Mq6gqLLWLchuGSI3z0wprSe/dHkPjcG2WFR0/R0dIEeu3E1I/V+G+FeWUEBUN+ECs60vgvqMe5Ki0OHEsiQmV6pQAjXHN7TVwZlzOa7pzGd9X3aG6RQAxUeqV0NtkcTVFpxbbjl/ZJeoXIvyNBxpMjJTsYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764587; c=relaxed/simple;
	bh=3OtIXL5oVq8AtCFy2KG/DlitJDAMuNKVop7LsnWuyAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djjBPCBqQXYwjPSSHf0KYI6gdt55Cf/35BaNZjUOLAowMo2LqOm8yIK1INrlqcD1ONEeMSdC1PUw7J3wiah7HS15Ptq8VVMM++xEX5TcyxQvowioWGX3OMj4rdUFZXSLoyKMDvbNPAA6hDzbqXiBp+Ltvkkse6fQ+lpq5FrOmR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n03GEu4b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n03GEu4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90B81F000FF;
	Wed, 30 Sep 2026 10:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764586;
	bh=5j0oeCmIiSAFwr9DL/KvkPyFQd1vbYiwHlWOIRKgumQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n03GEu4bOIgD2UGI/ubYv4FxvTAXp0uBEGM8XQl7E0SET+txuGqCVkbUUC1eWkn6J
	 /UZfSCYsrS4/mIayFcVFnE/YhLHGaGNk+4/hBUWaH4+EMiesGQzp4ehJAlMlBV0e6y
	 Y2WzNIDIjQyP1J/5ILOXeuFB4iofDm/DIgH7NW6SGf1nuLHzQAO8SImjXDHyVv/J5E
	 Ax8UQ5mKS/mVsr1HCjyeV05kr9Gx0a+k8r3z6qRn/0BqchOeMTMn/q8hZAJJXkD+jQ
	 ncauGOX/8/P0WOxIgf9HzZARkZq459NnEKU5S4qws359NDvcD4P2SHVF4jnjLRZUk0
	 FNaDpdzNaalRQ==
Date: Wed, 30 Sep 2026 12:36:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tim Kuo <Tim.Kuo@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Steven Liu <Steven.Liu@mediatek.com>, 
	Sky Huang <Skylake.Huang@mediatek.com>
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: add SPI IPM v59 compatible for
 mt7987 and mt7989
Message-ID: <20260930-enchanted-phenomenal-cassowary-80cdfb@quoll>
References: <20260929062516.416368-1-Tim.Kuo@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929062516.416368-1-Tim.Kuo@mediatek.com>

On Tue, Sep 29, 2026 at 02:25:15PM +0800, Tim Kuo wrote:
> MTK mt7987 and mt7989 SPI hardware has been updated to IPM v59 SPI IP and
> it differs from earlier IPM designs, most visibly in the tick delay field
> of SPI_CMD_REG, so it needs its own fallback compatible rather than reusing
> "mediatek,spi-ipm".
> 
> Signed-off-by: Tim Kuo <Tim.Kuo@mediatek.com>
> ---
> v2: Add mt7987 and mt7989 real device compatible
> 
>  .../devicetree/bindings/spi/mediatek,spi-mt65xx.yaml         | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> index 3bf3eb1f8728..d2c740572d85 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> @@ -39,6 +39,11 @@ properties:
>                - mediatek,mt7988-spi-single
>                - mediatek,mt8188-spi-ipm
>            - const: mediatek,spi-ipm
> +      - items:
> +          - enum:
> +              - mediatek,mt7987-spi
> +              - mediatek,mt7989-spi
> +          - const: mediatek,spi-ipm-v59

No, look at the binding and recent commits. This should be a specific
compatible. Git history easily tells you that.

Best regards,
Krzysztof

