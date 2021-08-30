Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F964C4320E
	for <linux-spi@archiver.kernel.org>; Mon, 30 Aug 2021 23:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F49260FE6
	for <linux-spi@archiver.kernel.org>; Mon, 30 Aug 2021 23:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhH3XTs (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 30 Aug 2021 19:19:48 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57257 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhH3XTr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Aug 2021 19:19:47 -0400
Received: (Authenticated sender: contact@artur-rojek.eu)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPA id 4E2AE60003;
        Mon, 30 Aug 2021 23:18:50 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 31 Aug 2021 01:18:50 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Pavel Nadein <pavelnadein@gmail.com>
Cc:     Pavel Nadein <pasha-net@narod.ru>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [5.16][PATCH 1/3] dt-bindings: spi: Document Ingenic SPI
 controller bindings
In-Reply-To: <20210830230139.21476-2-contact@artur-rojek.eu>
References: <20210830230139.21476-1-contact@artur-rojek.eu>
 <20210830230139.21476-2-contact@artur-rojek.eu>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <8332277ee8ad4ffff16457f5282c3fc6@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2021-08-31 01:01, Artur Rojek wrote:
> From: Paul Cercueil <paul@crapouillou.net>
> 
> Add a documentation file to describe the Device Tree bindings for the
> SPI controller found in Ingenic SoCs.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Woops, forgot to add my --signoff for this patch:

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>

Cheers,
Artur
> ---
>  .../devicetree/bindings/spi/ingenic,spi.yaml  | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 
> Documentation/devicetree/bindings/spi/ingenic,spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/ingenic,spi.yaml
> b/Documentation/devicetree/bindings/spi/ingenic,spi.yaml
> new file mode 100644
> index 000000000000..cf56cc484b19
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/ingenic,spi.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/ingenic,spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ingenic SoCs SPI controller devicetree bindings
> +
> +maintainers:
> +  - Artur Rojek <contact@artur-rojek.eu>
> +  - Paul Cercueil <paul@crapouillou.net>
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - ingenic,jz4750-spi
> +          - ingenic,jz4780-spi
> +      - items:
> +          - enum:
> +              - ingenic,jz4760-spi
> +              - ingenic,jz4770-spi
> +          - const: ingenic,jz4750-spi
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
> +  dmas:
> +    maxItems: 2
> +    minItems: 2
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
> +  - dmas
> +  - dma-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/jz4770-cgu.h>
> +    spi@10043000 {
> +      compatible = "ingenic,jz4770-spi", "ingenic,jz4750-spi";
> +      reg = <0x10043000 0x1c>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      interrupt-parent = <&intc>;
> +      interrupts = <8>;
> +
> +      clocks = <&cgu JZ4770_CLK_SSI0>;
> +
> +      dmas = <&dmac1 23 0xffffffff>, <&dmac1 22 0xffffffff>;
> +      dma-names = "rx", "tx";
> +    };
