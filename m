Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5A361DC0;
	Mon, 22 Jun 2026 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119680; cv=none; b=Ci2FMFcTayhe2aEkukNg+4XYRRQQ6WUWqzmxBdcV6Y6JDNi9u+ImICFWXYgIPA1X4KnpwFP2SixZ/6ETe3Vyo+uhcIca2FmMQ0M2I1GwhxjvOawh0dVKfpjCPuBeDk6n3XyAS69SNFmlrRKU0r5/HySmhahCXecFkMPWmLzMggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119680; c=relaxed/simple;
	bh=2pVwy/1h1GAAFYzRmoQJVVE+VVgB9anTCVBuWVtTSPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjLbzEqrDT4ds3Ae2temmuvMncjNv/HcJdoD0VV669iaDG4UWtwwl7EMH9wNvZoHTLwIMCFzNbWFKttC++faYhQeEgQOfj9C0Laph3wkPpQw6xQOSZuUr1c+Gn9XkxeWOSDdLFzTpDPyr0yfDQ+ffb5Ww+j9tAdkk5+skgvAH+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7H8jPlz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7H8jPlz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E3F1F000E9;
	Mon, 22 Jun 2026 09:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782119676;
	bh=gxPlx+0hNm6aq+bA+rW2kkCALODHubAvdQ5zTQrGHtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S7H8jPlzMEuFHwKZdTYZ0Q34p8rpZscCuA+6n4V16hNndGzm+diMkeGUtcAhmTft2
	 11y8v94ytAB5e4dM1QaCcEXSaeiqwAj8s+SslOyPbABSHOA8TjO5oSbAxEUsB0jLpC
	 HjtTXJNCRGJtt2fDsaIhAyGrDFpVZ++gdvc4bGNI2iSyoPVPxVVCg6QmNIerKDNPrp
	 v9A8uK9cHcFaqBnyvjAAsEm+o7exjrIsVXHjOI+cS8aTu+sq3UJLlgTL4ufh/PXy8V
	 jlJ2mZgBvvfrWqcy2X9/tNjbwrJecyjNc5TuxhzTzR0polik2+SW31IceRjiR0iqLI
	 xU7cB3lvVDCZQ==
Date: Mon, 22 Jun 2026 11:14:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	pratyush@kernel.org, mwalle@kernel.org, takahiro.kuwano@infineon.com, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, praneeth@ti.com, u-kumar1@ti.com, a-dutta@ti.com
Subject: Re: [PATCH v4 01/16] spi: dt-bindings: add
 spi-max-post-config-frequency property
Message-ID: <20260622-private-curly-fennec-7e1ad0@quoll>
References: <20260618073725.84733-1-s-k6@ti.com>
 <20260618073725.84733-2-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618073725.84733-2-s-k6@ti.com>

On Thu, Jun 18, 2026 at 01:07:10PM +0530, Santhosh Kumar K wrote:
> Add spi-max-post-config-frequency, a generic uint32 property for SPI
> peripherals that support two distinct clock rates: a conservative rate
> always reachable without controller configuration, and a higher rate
> reachable only after controller-side configuration such as PHY tuning.
> 
> When both properties are present, spi-max-frequency gives the
> conservative pre-configuration rate and spi-max-post-config-frequency
> gives the higher post-configuration target.
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 880a9f624566..ece86f65930f 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -45,6 +45,12 @@ properties:
>      description:
>        Maximum SPI clocking speed of the device in Hz.
>  
> +  spi-max-post-config-frequency:

-hz
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

and you need maxItems: 1.

Now, please take time and think if this should not be an array instead
(maxItems: ...) to cover other possible cases, e.g. different tuning
levels? IOW, having single spi-max-frequency turned out to be
insufficient. You address that insufficiency with one more frequency,
but what if this is going to be insufficient next month as well?

I don't know, answer is rather for domain experts.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Maximum SPI clock frequency in Hz achievable post controller-side
> +      configuration.

Best regards,
Krzysztof

