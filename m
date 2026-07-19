Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE3200110;
	Sun, 19 Jul 2026 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784444002; cv=none; b=YW2WE6CXoMqs86y71NF+MZXG2To4xQcDC/WTNckRF4gMYv/GBgjPaVZDVKTYFdgHqyHbqGSskZaKyMxR6chos0ZtR/Yrs72Y9b26bi8R7pCqV3eBqvO2tjttQhlaLZYP0Qdj78cz/CBETjrFfn9dsveEg/GSZE2/gKof91Ml2mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784444002; c=relaxed/simple;
	bh=ndwp0zmBjpClm2en1OhP35YztdcQh6LJTbc+kT4RccM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inQpHs7XmG+/VeS6rVMYBfUTDyxcVo126BglBLTezfrVA8gSdjrgrWfSmPKg92Vwo5XahxcBlGLcRl1xCRIf2vZV5oit4XRIxzm7W9ASm9rPtm9Tn1vceu5ijWhlojAxQlaD+zRp67ctsQRcyqayp+eNadyuRrA/9hSE58alG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFvUDkXZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFvUDkXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C021F00A3E;
	Sun, 19 Jul 2026 06:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784444001;
	bh=H9bU0jaGp9KqUqIiVsAPXWevijefHkMwfYOWuKZZ/qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BFvUDkXZBui/cw+F7d16legvLReHOuiM77oYX2JJe4qZye9IrdJjSyUsIti1UdghQ
	 h9Qbk4lKb06Mw6ncUyz780q6Ovfet7KpZtUiKUKtDZDERoYoHf7wH6UI/4HX1SItcl
	 PZvM0Idbhn+1kmxCVpIYi93qH7aOt1ci3KXG12uJfuvS+N8frzCOc7/12CgJA/5uFF
	 XHpgxS2NFLJjjMaOVl6X+XwbEL8hTBfSNpyh2s0A3qsKFrMk2jbT5lXwNqmWyJ9Dyh
	 FF4RK98Bi6k+lTomQChZG1UpGK6/dm0qc6D94O3UgHc3CjfmlqnVfEcZklm8gXP4qV
	 RUi103cjNhpEw==
Date: Sun, 19 Jul 2026 08:53:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	pratyush@kernel.org, mwalle@kernel.org, takahiro.kuwano@infineon.com, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, praneeth@ti.com, u-kumar1@ti.com, a-dutta@ti.com, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 01/17] spi: dt-bindings: add
 spi-max-post-config-frequency-hz property
Message-ID: <20260719-camouflaged-unyielding-sawfish-b6fd09@quoll>
References: <20260717185116.2065505-1-s-k6@ti.com>
 <20260717185116.2065505-2-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717185116.2065505-2-s-k6@ti.com>

On Sat, Jul 18, 2026 at 12:21:00AM +0530, Santhosh Kumar K wrote:
> Add spi-max-post-config-frequency-hz, a generic property for SPI
> peripherals that operate at two distinct clock rates: a conservative
> rate always reachable without controller configuration, and a higher
> rate achievable only after controller-side configuration.
> 
> When both properties are present, spi-max-frequency gives the
> conservative pre-configuration rate and spi-max-post-config-frequency-hz
> gives the higher post-configuration target.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml        | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 880a9f624566..12211f8c9f7d 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -45,6 +45,11 @@ properties:
>      description:
>        Maximum SPI clocking speed of the device in Hz.
>  
> +  spi-max-post-config-frequency-hz:
> +    description:
> +      Maximum SPI clock frequency in Hz achievable after controller-side
> +      configuration.

How did you implement my feedback?

Best regards,
Krzysztof

