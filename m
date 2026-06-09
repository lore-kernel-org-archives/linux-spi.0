Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1145F2F1FC9;
	Tue,  9 Jun 2026 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989409; cv=none; b=teMma4b2dnM2mIexWGbBxFLjQ31gsz66lIigGDUujPL2HNxTZbFVKVSf8e5KsX6ib5z3ShX0tU5nJQcrQPRlXN344wpxiYloltAei14AIz62RyTWEQ56cfSeQOIbHgvYYVGb+/eOI1o/PeaU5sid26XUIaIVdN6Ea1Pi+z3rbTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989409; c=relaxed/simple;
	bh=N04XSFfusuTaHsNFuqoRh/L/mSiQOzUOqoOnUZS5LG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqckUJU0qMtKepT3d1Vp/sIDU4WuuYSQQyYVbLUMniT85dtDnzWX9bPyDC7njRTMxGdQrQ0Et8BMkbD07exxzaJOC8phR+pikpRp09o/tQPT5QK5Ic9JShSjyLLXNSXntWRiVPdgNa/3NsYHVLbghwS9T/A9vFFueJVyzIUydPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7QO27FR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7QO27FR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEF21F00893;
	Tue,  9 Jun 2026 07:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780989407;
	bh=m+KYGZ93ysAEFhs7M5BXdkdm6DTM61sC1UfDRdKiois=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z7QO27FRIpcJ24ft+sWDzgKUTcoa1pgWP/jk9ZHVAy8Gvy8mC4uJClcJTRrnH982n
	 8AcJQ2RiqPDWSDLyZ435L8T5HSFZKd72aXCFrs7Vk3CJ6Jc5u8IzbRNNW/XzrxXAzi
	 GFRMlhMlZa55bivA5ht3O1j7KCqDjTVc67ce6rrRC1NoM/eecxpv8NeyVjnZbvHEbu
	 Oo7pKUIah5EePRFtOgCdTc+HsuyVngIKxhUZfL3zpfeHX3V1IGwoDU5WbcJxZCMCgD
	 lTH3t1Jl7Bp7uiJxZm3rRe5OBXnsypvOXzsl3my/xRkv9w0GQ031aHngVF0epaInoh
	 bIZiopGYuNz/Q==
Date: Tue, 9 Jun 2026 09:16:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: andrew@codeconstruct.com.au, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, openbmc@lists.ozlabs.org, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com, yuenn@google.com, 
	benjaminfair@google.com
Subject: Re: [PATCH v2 2/2] spi: dt-bindings: nuvoton,npcm-fiu: Convert to DT
 schema
Message-ID: <20260609-rebel-advanced-dragonfly-efdafe@quoll>
References: <20260608175418.1936892-1-tmaimon77@gmail.com>
 <20260608175418.1936892-3-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608175418.1936892-3-tmaimon77@gmail.com>

On Mon, Jun 08, 2026 at 08:54:18PM +0300, Tomer Maimon wrote:
> Convert the Nuvoton NPCM FIU binding to DT schema format.

You should explain here why second 'reg' is optional. It wasn't in
original binding, so you made a change to the binding during conversion.


...

> -
> diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.yaml b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.yaml
> new file mode 100644
> index 000000000000..0f95def01910
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.yaml

Filename: nuvoton,npcm750-fiu.yaml

> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/nuvoton,npcm-fiu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM Flash Interface Unit (FIU) SPI Controller
> +
> +maintainers:
> +  - Tomer Maimon <tmaimon77@gmail.com>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +description: |
> +  NPCM FIU supports single, dual and quad communication interface.
> +
> +  The NPCM7XX supports three FIU modules:
> +    FIU0 and FIUx support two chip selects
> +    FIU3 supports four chip selects.
> +
> +  The NPCM8XX supports four FIU modules:
> +    FIU0 and FIUx support two chip selects
> +    FIU1 and FIU3 support four chip selects.
> +
> +  Alias convention:
> +    The '/aliases' node should define:
> +      For NPCM7xx:  fiu0=&fiu0; fiu1=&fiu3; fiu2=&fiux;
> +      For NPCM8xx:  fiu0=&fiu0; fiu1=&fiu3; fiu2=&fiux; fiu3=&fiu1;
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm750-fiu # Poleg NPCM7XX
> +      - nuvoton,npcm845-fiu # Arbel NPCM8XX
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: FIU registers
> +      - description: Memory-mapped flash contents (optional)
> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: control
> +      - const: memory
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - enum:
> +          - clk_spi0
> +          - clk_spi1
> +          - clk_spi3
> +          - clk_spix

This wasn't in the original binding. Nothing explains why it was added.

> +
> +  nuvoton,spix-mode:
> +    type: boolean
> +    description: Enable SPIX mode for an expansion bus to an ASIC or CPLD.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
> +    spi@fb000000 {
> +        compatible = "nuvoton,npcm750-fiu";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        reg = <0xfb000000 0x1000>, <0x80000000 0x10000000>;
> +        reg-names = "control", "memory";

reg and reg-names follow compatible.


Best regards,
Krzysztof

