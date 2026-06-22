Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480C83793B8;
	Mon, 22 Jun 2026 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119874; cv=none; b=HZ0Ty1qUy6Sr9DqTdNPmJp36V6V9EvqaIxVogv1KRR88gBFQesFCZ+QCQ19/WfiEeMEsJvFrf+ttVkpSwN0NoDVcLWl6qUvQ7N05OTL80Pi2Q9btjEJuo4w3UgE3BW//XOO9rla+/azd38Pin3G3ZCLtwMiJor/y7NqIrH25kvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119874; c=relaxed/simple;
	bh=CFW9CQabn5S96U0a/L6dO/zOrFz9X7QPd9GDacA/uMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaQ65Gvkd7oPz9GS1vMAyofSeQOZ3iDr8U7+pjiHTQaOtaDg2TMGwvCb4+zyQwMpljywpD0BrzIPthkPpV7ICutoU/tyA9a4UmuQrNrF51EMfQWzcc7lbXjr91ysBTKBQukhxj1VyPMjErmo+KaWPboNEP3IfPQql5P98/JaWic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/YCPKRa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/YCPKRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A861F000E9;
	Mon, 22 Jun 2026 09:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782119870;
	bh=75WkuDbFDwK34b3F1MyX5oE8FFFopksL8cNu00Zpxfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R/YCPKRa+xIx11buTQlPiQBzl7DId8G1PzPC7UL7S64waj7Db1cVNTC7Hi9J6NufN
	 tfLNQCkOk2+Yiwd2g7Kff+K3jd/9vIIonnHKSRVleviBvCPzKyfkesEkNeFagjkK10
	 VlNe10Saz2+IaCtgnSOTLjhnDLM9E2bqqpZs1N7Z9/CUXGJSIqMZTeJOlwKDh8eVRI
	 bwmzkNag9rTvKXB25wYsQELubrYvUKmZdOS7adccZYlpk5Ep0/qklu0bh21fg3c0up
	 WhIZL2LfHchOLmyINMWA5XipKHmj7QesrgbmeSf7nuYM03VPyvZiizBRh/80FJLrwA
	 9ms6gjyj3DJYg==
Date: Mon, 22 Jun 2026 11:17:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	pratyush@kernel.org, mwalle@kernel.org, takahiro.kuwano@infineon.com, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, praneeth@ti.com, u-kumar1@ti.com, a-dutta@ti.com
Subject: Re: [PATCH v4 02/16] spi: dt-bindings: add spi-phy-pattern-partition
 property
Message-ID: <20260622-jasmine-mandrill-of-emphasis-eebb4c@quoll>
References: <20260618073725.84733-1-s-k6@ti.com>
 <20260618073725.84733-3-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618073725.84733-3-s-k6@ti.com>

On Thu, Jun 18, 2026 at 01:07:11PM +0530, Santhosh Kumar K wrote:
> Add spi-phy-pattern-partition, a per-device phandle property on the
> flash sub-node that allows the DT author to directly reference the
> partition holding the PHY tuning pattern. Used to locate the pattern
> data during PHY tuning when the device cannot load the pattern
> dynamically.
> 
> "Read PHY tuning" works by reading a known data pattern from the device
> repeatedly while sweeping controller delay parameters until the
> capture window is stable. For SPI NAND, the driver loads the pattern
> into the page cache once using write-to-cache opcodes, then reads it
> during the sweep. SPI NOR devices have no equivalent opcode, so the
> pattern must be pre-programmed in a dedicated flash partition. One
> partition per device is required to keep the procedure unambiguous
> when multiple devices share a bus.
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  .../bindings/spi/cdns,qspi-nor.yaml           | 19 +++++++++++++++++++
>  .../bindings/spi/spi-peripheral-props.yaml    |  7 +++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index 891f578b5ac4..c6f1b1d1251d 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -204,10 +204,29 @@ examples:
>          flash@0 {
>              compatible = "jedec,spi-nor";
>              reg = <0x0>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;

This is neither needed, nor correct.

>              cdns,read-delay = <4>;
>              cdns,tshsl-ns = <60>;
>              cdns,tsd2d-ns = <60>;
>              cdns,tchsh-ns = <60>;
>              cdns,tslch-ns = <60>;
> +            spi-phy-pattern-partition = <&phy_pattern>;
> +
> +            partitions {
> +                compatible = "fixed-partitions";
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +
> +                partition@0 {
> +                    label = "data";
> +                    reg = <0x0 0x3fc0000>;
> +                };
> +
> +                phy_pattern: partition@3fc0000 {
> +                    label = "phy-pattern";
> +                    reg = <0x3fc0000 0x40000>;
> +                };
> +            };
>          };
>      };
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index ece86f65930f..38708f8197f9 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -123,6 +123,13 @@ properties:
>      description:
>        Delay, in microseconds, after a write transfer.
>  
> +  spi-phy-pattern-partition:

Is this specific to SPI-based MTD/NAND or rather broader - specific to
MTD/NAND memories, regardless of interface? Feels like the second, thus
maybe should be placed into the NAND bindings.

If the first, then in below description:

s/PHY/SPI PHY/ to be clear that this is about SPI, not the memory
itself.


> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the flash partition holding the pre-programmed PHY tuning
> +      pattern. Used when the device cannot load the pattern dynamically during
> +      PHY tuning.

Best regards,
Krzysztof

