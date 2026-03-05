Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE5C376465;
	Thu,  5 Mar 2026 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700427; cv=none; b=U2AHB+F4V3uYvbWvU9yBzhOhMlZMu2r6tKYHnIVXDFIf5ayhp3b6yZn9SYvmYYtFL9D8DzTD6Przlkx4a2nZnxvLZ9XltWYWJLS8+XiRJ2Wdx44wNO0GHKHukUejsfJ07QV4ufFjgZZCpfobPubdSSKfdn1e3cIwzvEOeBuhwhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700427; c=relaxed/simple;
	bh=gsMJJgM+sLQv9rst3VO6I/wn5nnKEdijZ7APePySFCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1kJqGiPczSGW9xNyQ4IZRfKtOKiUsNjnYQ5THNX4xjGiD3JnR0+uyfraokQKTP9htsx+ehT/bh8t5vWzLN6VdudJs3K+Jr1tP54KZoJNIlOMR3LAWF+t0svJa+5EJHmCmBq5K/oC8Rm4yIT/bBTi9ne9/+sp6ovrYLrGLpyNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ct5SFawG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct5SFawG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CD4C116C6;
	Thu,  5 Mar 2026 08:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772700426;
	bh=gsMJJgM+sLQv9rst3VO6I/wn5nnKEdijZ7APePySFCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ct5SFawGnA/+5V2qUS3BhhIEvFOJJLJ3BxGblhVFI1uw3uV/pfGxqY2MWnQ7Ay4q3
	 ODRaryMaSmOBl9rJe3yUTKHGWiucwTdwyDJzmR0M341bxqDyNHzl40JfHZA2yTt/gI
	 YyV5QMAJOFKsggf5gO74TxD8eJmH8ntaW4LYi7/7vaQLFyoJq2gfgU3UlPp7Kq/OY8
	 qEfdRtOGudInbsKoHZOeiUw7Yaw8hCtw0OY3NaqcpdBRu9tCIRKSdBnf+/Um5peutI
	 nNeaz+U/TJYde3ViIhck6TdnyhNjVY74ku3hZHqT4pFcNRrX6yvPlIICkRmU+aAZS4
	 uZeket75KD0FQ==
Date: Thu, 5 Mar 2026 09:47:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Meiker Gao <ot_meiker.gao@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bayi Cheng <bayi.cheng@mediatek.com>, 
	Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Project_Global_Chrome_Upstream_Group@mediatek.com, 
	sirius.wang@mediatek.com, vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
Subject: Re: [PATCH] spi: dt-bindings: mediatek,spi-mtk-nor: Add clock
 bindings for mt8189
Message-ID: <20260305-inquisitive-spider-of-glamour-28b9db@quoll>
References: <20260305022740.2334033-1-ot_meiker.gao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305022740.2334033-1-ot_meiker.gao@mediatek.com>

On Thu, Mar 05, 2026 at 10:27:36AM +0800, Meiker Gao wrote:
> Update mediatek,spi-mtk-nor.yaml to add conditional clock and
> clock-names bindings for the mt8189-nor platform. The mt8189-nor
> controller requires five specific clocks and corresponding clock-names
> ("spi", "sf", "axi_f", "axi_h", "axi_p"). This change enforces these
> requirements in the device tree binding schema.
> 
> For other platforms, the minimum number of clocks and clock-names
> remains unchanged. The patch also adds an example for mt8189-nor,
> illustrating the new clock configuration.
> 
> This update ensures correct hardware description and validation for
> mt8189-nor, improving compatibility and reducing configuration errors.
> 
> Signed-off-by: Meiker Gao <ot_meiker.gao@mediatek.com>
> 
> ---

Not tested so limited review.

>  .../bindings/spi/mediatek,spi-mtk-nor.yaml    | 78 ++++++++++++++++---
>  1 file changed, 68 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> index a453996c13f2..7e551f2cb52c 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> @@ -17,8 +17,6 @@ description: |
>    for devices other than SPI NOR flash due to limited transfer
>    capability of this controller.
>  
> -allOf:
> -  - $ref: /schemas/spi/spi-controller.yaml#
>  
>  properties:
>    compatible:
> @@ -39,6 +37,7 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt8188-nor
> +              - mediatek,mt8189-nor
>            - const: mediatek,mt8186-nor
>  
>    reg:
> @@ -56,14 +55,12 @@ properties:
>                       design, so this is optional.
>        - description: clock used for controller axi slave bus.
>                       this depends on hardware design, so it is optional.
> -
> -  clock-names:
> -    minItems: 2
> -    items:
> -      - const: spi
> -      - const: sf
> -      - const: axi
> -      - const: axi_s
> +      - description: clock used for controller axi fast bus (axi_f).
> +                     Required for new platforms, such as mt8189.
> +      - description: clock used for controller axi high-speed bus (axi_h).
> +                     Required for new platforms, such as mt8189.
> +      - description: clock used for controller axi peripheral bus (axi_p).
> +                     Required for new platforms, such as mt8189.

No, I don't understand why you remove names. This is not expected.
Please also read writing schema and writing bindings docs explaining how
to organize properties with variable lengths. There is plenty of
examples to follow.

>  
>  required:
>    - compatible
> @@ -71,6 +68,42 @@ required:
>    - clocks
>    - clock-names
>  
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8189-nor
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 5
> +          maxItems: 5


> +        clock-names:
> +          minItems: 5
> +          maxItems: 5

Pointess. Drop.

> +          items:
> +            - const: spi
> +            - const: sf
> +            - const: axi_f
> +            - const: axi_h
> +            - const: axi_p
> +    else:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2

ABI change without explanation. Don't mix multiple changes into one
commit.

> +        clock-names:
> +          minItems: 2
> +          maxItems: 2
> +          items:
> +            - const: spi
> +            - const: sf
> +            - const: axi
> +            - const: axi_s

Plain wrong. So either 2 or 4.

> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -97,3 +130,28 @@ examples:
>          };
>        };
>      };
> +
> +  - |
> +    #include <dt-bindings/clock/mt8189-clk.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      nor_flash: spi@1100d000 {

No, drop entire example.

Best regards,
Krzysztof

