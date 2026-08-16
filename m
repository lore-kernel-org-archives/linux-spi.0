Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4005620125F
	for <linux-spi@vger.kernel.org>; Sun, 16 Aug 2026 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901978; cv=none; b=Ecv7iAHwso+pB+TXBHHMobwHwRX3SrUzIq6oyMB3V4L82XpDM1NuLvuD5v9HgubbKxXtdjLuVWLmHWH3XQ2f75CJb/NU0VtCC8IdgM6qEJpRSfbmxmYZl+yzuimXTkTKeI4VLsnSgJu2OEJxai/0CCkRMMorK6uSoGQJ9m7sPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901978; c=relaxed/simple;
	bh=gDfQWijFmFP5WqDqiSwNSHeEXEBOWPRLSLbAfCIOYcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTu3Ju3OZcDLvqgJ3HSVHIpP6NJhW1zMC3jPCrJpeHlOC7/uTkAKta42pSfB9RaUclDPLLq0scPALpHWPXKNX5Hyy+Lb+v+n5graJ7UJDOBE7RwOJpXzTuGZW+19f2wkP2Z8RLV5zMKwPOhnfBw+5VwW6LYabwTz3og0DfvhoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vc30zhGu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc30zhGu"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1994650a91.3
        for <linux-spi@vger.kernel.org>; Sun, 16 Aug 2026 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786901977; x=1787506777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rVqYn/Ux/g4Ywrq/aBKi13oyKDJDmOzkdViG+3ve29Q=;
        b=Vc30zhGupxljKQS0N4nwfAQoL0/a2ZVrl13qJa4aRVqFec8RzIrxCBaPLhvtgbovNU
         GiElv9EpphD/CBsM5ZuBIHUWOqCq7PbYf0JzPBEF4e0J3Nl8wFeBC2nQmVrCe985vtub
         q47O4SaRdfD+DiZUeEIc3/MZkcmm+wRDoW6Dg05DLcSc/pP1L02xhSxTs9Jj5gOf7yCS
         pk8TqXrGJ+6WK/jTkphPDQW4zW3ozcc7GQLA0SRsjzj1o2VlLbRZoPFXUt3JJCRbyXSS
         QMF/LWlt+h4CFw7/0qEkb2XNL2a4RqpBap7cSOLtcJUfo11hH3Qk1cPkOR+vfAYmLKGo
         CQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786901977; x=1787506777;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rVqYn/Ux/g4Ywrq/aBKi13oyKDJDmOzkdViG+3ve29Q=;
        b=ofWEMGgJ+myXRzC1b45g0NBlz9OwJroyzjHC4lHu9F6/fSKde8joOIX62Q5VGqtEZA
         g9UweKSBAfzorkKdgzW81xUuDlPNWfHI/smnYsEPYpq7Z1JCDSLx8QMqvguNHZVjQua5
         6cIFmWmT9NvUqdkmAMOfBwC8XJ41ELBeZcFjwQlVeQmlgPA5JC96/myF6+fFcdJE6af4
         2DV+snbz+dk3g7/6QcnExNrsZLaxWX2T5pOux5KSvDxhKajLANLNVvNfY5z6FBb/7pE5
         kfMkeE4xejcJ+aidDUCBpT0bBMTeEFy0Rwqu5E5YpBT8D5fLqPRrNqvTpGzjKe1CagON
         FNeQ==
X-Gm-Message-State: AOJu0Yyx9RXyp1GonqDqzy0VJHqMgTl2qc26wKKxyy8uo+CuOmEBJ+2r
	q9YAsuxxB5IkoaFpG+iogo4PB0IRAKHd1K3Vso10E0MzmoYFKcYx125Q
X-Gm-Gg: AR+sD11P81h7YPOWyxKCQd2WEghCRbLRTYs7RH6k06yxc2DtZeVBn4xGgXqxJzuAivZ
	uNio7A1XRgIjpR1/9dthiDpBJD+4wuA1Syu8c0S1ketf4zrJwDtOATZFj94lQVt2pAnoaydoyku
	mZjyf4nUUpNX8B1gHDsaN1MyetPhywnXh62cNtzcX6CNgvFxKp+g6i2Wwrq/hW3YgbYyeSVRgNQ
	OKWTLl3AeGGF0lfgRGzQPRG4LJJe1ujuKkbWxtmJQDt6l5UbDqROTDK9a0Z9cAbFhPQhVShL4Y0
	9U4nzsJPkLjYZHcwkeRvxeO1v0wirryOzHIwOYC8DKSz6PNCtCgHIlUssBCQqKKBIPtMkv34mB3
	1jnJJ0b0pwOLx+LeGKR4UuCEJepRZx7KW7tSH2QDbc0ruBs1b4XjQEJNqeY/AgDwFizkqnk9v5E
	emqae2rYVTn27u1ppBWoEzlQ+TECDOwuR4LFYTVX4HxM1vj1YF5zkyaKMnaw8h27L8Fz5NE91nQ
	VKorzdao/coPyXbsmPtu8etrsx9gjrHjsF0XGk=
X-Received: by 2002:a17:90b:3d48:b0:381:528a:808c with SMTP id 98e67ed59e1d1-3933b8939dfmr21383173a91.12.1786901976477;
        Sun, 16 Aug 2026 10:39:36 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:e503:403c:f88f:3e17:55ae? ([2406:7400:56:e503:403c:f88f:3e17:55ae])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c5747sm31311985c88.5.2026.08.16.10.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 10:39:36 -0700 (PDT)
Message-ID: <ed2d4520-f09c-4be2-9c0b-5c6636e74653@gmail.com>
Date: Sun, 16 Aug 2026 23:09:21 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: spi: ti,davinci-spi: convert to DT
 schema
To: Bhargav Joshi <j.bhargav.u@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 m-chawdhry@ti.com, daniel.baluta@gmail.com, simona.toaca@nxp.com
References: <20260816-ti-davinci-spi-v2-0-6c6f5171422b@gmail.com>
 <20260816-ti-davinci-spi-v2-2-6c6f5171422b@gmail.com>
Content-Language: en-US
From: Dhruva G <goledhruva@gmail.com>
In-Reply-To: <20260816-ti-davinci-spi-v2-2-6c6f5171422b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bhargav,

On 16-08-2026 03:53, Bhargav Joshi wrote:
> Convert the TI DaVinci/Keystone SPI controller binding from text format
> to DT schema.
> 
> Changes during the conversion:
> - Create a separate ti,davinci-spi-peripheral-props.yaml schema to
>   properly define the ti,spi-wdelay peripheral property.
> - Add missing dmas and dma-names properties.
> - Add constraints to ti,spi-wdelay based on the 6-bit width
>   of the SPIFMTn.WDELAY hardware register field.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  .../devicetree/bindings/spi/spi-davinci.txt        | 100 ----------------->  .../bindings/spi/spi-peripheral-props.yaml         |   1 +
>  .../spi/ti,davinci-spi-peripheral-props.yaml       |  25 +++++
>  .../devicetree/bindings/spi/ti,davinci-spi.yaml    | 118 +++++++++++++++++++++
>  4 files changed, 144 insertions(+), 100 deletions(-)
> 
[..snip..]
> diff --git a/Documentation/devicetree/bindings/spi/ti,davinci-spi.yaml b/Documentation/devicetree/bindings/spi/ti,davinci-spi.yaml
> new file mode 100644
> index 000000000000..b685082de721
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/ti,davinci-spi.yaml
> @@ -0,0 +1,118 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/ti,davinci-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI DaVinci/Keystone SPI Controller
> +
> +maintainers:
> +  - Bartosz Golaszewski <brgl@kernel.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - ti,da830-spi
> +          - ti,keystone-spi
> +          - ti,dm6441-spi
> +      - items:
> +          - const: ti,keystone-spi
> +          - const: ti,dm6441-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +    description:
> +      Should contain a phandle to a PM domain provider node
> +      and an args specifier containing the SPI device id
> +      value.
> +
> +  num-cs:
> +    minimum: 1
> +    default: 1
> +    description:
> +      Number of chip selects supported by the controller. This
> +      includes both internal and GPIO chip selects.
> +
> +  ti,davinci-spi-intr-line:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description:
> +      Interrupt line used to connect the SPI IP to the interrupt
> +      controller within the SoC.  The SPI peripheral can route its
> +      interrupt output to one of two lines (INT0 or INT1). Set
> +      this based on the SoC-specific wiring to the interrupt
> +      controller.
> +
> +  dmas:
> +    items:
> +      - description: RX DMA channel
> +      - description: TX DMA channel
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - ti,davinci-spi-intr-line

The old text binding lists #address-cells, #size-cells, and num-cs as required properties,
but the converted schema omits all three from the required list, was that intentional?

spi-controller.yaml defines these properties but does not require them, so this silently relaxes
the binding and permits controller nodes without the SPI bus cell declarations.

num-cs was also required by the old binding. It should remain required to preserve the existing binding,
or else the commit message should explain why making it optional and relying on the driver's default of one
is intentional.

> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          const: ti,keystone-spi
> +    then:
> +      required:
> +        - power-domains
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi@20bf0000 {
> +        compatible = "ti,keystone-spi","ti,dm6441-spi";

One minor nit: please add a space after the comma:

compatible = "ti,keystone-spi", "ti,dm6441-spi";

> +        reg = <0x20bf0000 0x1000>;
> +        num-cs = <4>;
> +        ti,davinci-spi-intr-line = <0>;
> +        interrupts = <338>;
> +        clocks = <&clkspi>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flash@0 {
> +            compatible = "jedec,spi-nor";
> +            spi-max-frequency = <25000000>;
> +            reg = <0>;
> +            ti,spi-wdelay = <8>;
> +        };
> +    };
> +
> +  - |
> +    spi@41000 {
> +        compatible = "ti,da830-spi";
> +        reg = <0x41000 0x1000>;
> +        num-cs = <6>;
> +        ti,davinci-spi-intr-line = <1>;
> +        interrupts = <20>;
> +        dmas = <&edma0 14 0>, <&edma0 15 0>;
> +        dma-names = "rx", "tx";
> +        clocks = <&psc0 4>;
> +        power-domains = <&psc0 4>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +    };
> 

