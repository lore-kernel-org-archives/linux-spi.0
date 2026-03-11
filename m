Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EA33644C1;
	Wed, 11 Mar 2026 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209364; cv=none; b=bs8bB9rRsXeeIka9/wvKdTCNdKmolN7beIPnrinin2U2dK2KPUpA1+/Yukpqf+ae41u6jyItkQen2kjEKv7A4iR/9SikI4+g0gLbXfTSSTxz2fyBYTpMiLKcMKs5OJnq3xIOk4gdXpbTxYDMeG8hLsTGPBXCKV2h1zqW2XKm0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209364; c=relaxed/simple;
	bh=NCpaP4S5EWWShh4y1c0yl/2Oq1KwijpKLQzgL16A1CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arsGZ7W3LkHjZA2B3lI1obgFZMy4bupcPPKdG7X8Q7J476eou1oZ/aVPDrjrE5U5S8tYWMPsJGL6sHwKNGpN1aHFjUNjjizcUwX33XdtvD3JReyuCwSBU6BwChFy4wwsDqhTXsk4lAIFOipLIvQAbrQ9Ck4PUhxTk3gdvYVXjMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqeDGkST; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqeDGkST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECF7C4CEF7;
	Wed, 11 Mar 2026 06:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773209364;
	bh=NCpaP4S5EWWShh4y1c0yl/2Oq1KwijpKLQzgL16A1CQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YqeDGkSTUiahSsx1wq+pBJdBr4NKKDQDTos02v3jd0PIpnve3ZMNueZuFX1isLkXw
	 WiZsJ1hwmSTqSy1avqVJyfAUps9ADRkfRbPMeUiuj1aslQekPGNPkbGDpWO2yUpKtJ
	 KdOHdw+sHxc69P/QXbFeToPaHukjSDvaRuC+fgoEUQiLnddYqArvgc/CYvRUTiqKyf
	 KZZ2lJ3igLUWxfH+Hd5PMPDVOuhtxhk6cTy/+PzwX82JF3ieDmNl0ZKv9jGriUvWL6
	 4AyWraUA+4uDii6Um4L7YgMeg4tD+Ke8LBprkGfrmBG8Qh7pOYYzKFmfp+AM1KjslB
	 yqpoc8gCrWIbw==
Message-ID: <8bfdcc26-a640-47ba-81ff-ba8e8aa0ae9d@kernel.org>
Date: Wed, 11 Mar 2026 07:09:18 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: dt-bindings: mediatek,spi-mtk-nor: Add clock
 bindings for mt8189
To: Meiker Gao <ot_meiker.gao@mediatek.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bayi Cheng <bayi.cheng@mediatek.com>, Chuanhong Guo <gch981213@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
References: <20260311053335.785292-1-ot_meiker.gao@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260311053335.785292-1-ot_meiker.gao@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2026 06:33, Meiker Gao wrote:
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
> (cherry picked from commit c3180d35e52b5213764a89403e71f9a34d7bb842)

Clean your patches before sending them.

> ---
>  .../bindings/spi/mediatek,spi-mtk-nor.yaml    | 45 ++++++++++++++-----
>  1 file changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> index a453996c13f2..bd6f43a0c399 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> @@ -17,9 +17,6 @@ description: |
>    for devices other than SPI NOR flash due to limited transfer
>    capability of this controller.
>  
> -allOf:
> -  - $ref: /schemas/spi/spi-controller.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -27,6 +24,7 @@ properties:
>            - mediatek,mt8173-nor
>            - mediatek,mt8186-nor
>            - mediatek,mt8192-nor
> +          - mediatek,mt8189-nor
>        - items:
>            - enum:
>                - mediatek,mt2701-nor
> @@ -39,6 +37,7 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt8188-nor
> +              - mediatek,mt8189-nor
>            - const: mediatek,mt8186-nor
>  
>    reg:
> @@ -56,14 +55,8 @@ properties:
>                       design, so this is optional.
>        - description: clock used for controller axi slave bus.
>                       this depends on hardware design, so it is optional.
> -
> -  clock-names:

You cannot remove properties.

> -    minItems: 2
> -    items:
> -      - const: spi
> -      - const: sf
> -      - const: axi
> -      - const: axi_s
> +      - description: clock used for controller axi_f, axi_h, and
> +                     axi_p to support the new platform.
>  
>  required:
>    - compatible
> @@ -71,6 +64,34 @@ required:
>    - clocks
>    - clock-names
>  
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8189-nor
> +    then:
> +      properties:
> +        clocks:

minItems

> +          maxItems: 5
> +        clock-names:
> +          items:
> +            - const: spi
> +            - const: sf
> +            - const: axi_f

That's just axi, no? Thus keep the list in top-level.

> +            - const: axi_h

And that's axi_s

> +            - const: axi_p

And what does p stand for? Do you understand these are names of clock
inputs, not names of clocks?


> +    else:
> +      properties:
> +        clocks:

Missing minItems

> +          maxItems: 4
> +        clock-names:
> +          items:
> +            - const: spi
> +            - const: sf
> +            - const: axi

And that's ABI change, NAK.


Best regards,
Krzysztof
