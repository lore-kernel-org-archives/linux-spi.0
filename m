Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C702857CC;
	Sat, 28 Feb 2026 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276904; cv=none; b=Ebpckw5qXTkCKAa7jSfg6AWDnR+2p5gYOX/XoatDT0rJN416rHHT2lVdjw9uYA9Xig3T/BW9mhK+D4xZos1DnV5Y+tv2BqYEb0Akw2SvkCSeeg9Vk2eSwqUJ09st9r471UyR+A+Llb/X7G2WxvH6zxb3GHcP1fMglLja8yQdd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276904; c=relaxed/simple;
	bh=4eFm3+ZhAflcr0B/p2fB4fUvTsRfI8pwZ4uxvPYQN1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj1H5ykgVB3ESXYdUZttTQJqho9HlXbQZtGf7KymGizDf1QA5hANk6XbgDptaesjK3VRbJ6oKpUMlR5mODUpn35l8KCzfr5tu7a9GqDJwLwIO6ihAuIvQM1N0Q2FncnFyXKTjmMiRh7FCdrGBWkVwYYuohJIUJpIalpiXsXkM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0FDuV1i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0FDuV1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563BCC116D0;
	Sat, 28 Feb 2026 11:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772276903;
	bh=4eFm3+ZhAflcr0B/p2fB4fUvTsRfI8pwZ4uxvPYQN1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0FDuV1iw3VCDtvEZ2b9wIT3qceXjfYvFTLme9GSLFqWi4B1O8dtMWI8INRZYX7Js
	 SRs6HT2D+v6dzoRczH3JkAVHFdNU696A3OfSI467XJUPsL9zl7ndITjj3P1UePhefD
	 PhQf3H0FMIqA/CEOH0XBoHc+zirPd2D/D4jT8iWSW8x19v3EIRISTM/4cfQqOKYERF
	 an7jWPuSkpnesbbQh7Z4ljNj6LxmqQxmjXhnS5wCmJmsTFI8ne2OysiHhoQ2y2f+Bh
	 mn0Tw8SrWk+yjwtPDcH/oPqCM3wBxeEka2Fzvj8P5rT6/dS42gy1ctDAsPDENx+3vy
	 V33sOTjhN9cug==
Date: Sat, 28 Feb 2026 12:08:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>, linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI
 for newer SoCs
Message-ID: <20260228-ultra-hyena-of-ecstasy-fdb006@quoll>
References: <20260227175157.2339758-1-wens@kernel.org>
 <20260227175157.2339758-2-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260227175157.2339758-2-wens@kernel.org>

On Sat, Feb 28, 2026 at 01:51:53AM +0800, Chen-Yu Tsai wrote:
>  maintainers:
>    - Chen-Yu Tsai <wens@csie.org>
>    - Maxime Ripard <mripard@kernel.org>
> @@ -82,11 +79,35 @@ patternProperties:
>  
>        spi-rx-bus-width:
>          items:
> -          - const: 1
> +          enum: [0, 1, 2, 4]
>  
>        spi-tx-bus-width:
>          items:
> -          - const: 1
> +          enum: [0, 1, 2, 4]
> +
> +allOf:

Please place the allOf after required: block.

> +  - $ref: spi-controller.yaml
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - allwinner,sun50i-r329-spi
> +                - allwinner,sun55i-a523-spi
> +    then:
> +      patternProperties:
> +        "^.*@[0-9a-f]+":
> +          type: object

type is not needed here, already defined in top-level.

With these two changes:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

