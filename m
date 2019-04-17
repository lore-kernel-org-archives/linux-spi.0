From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: spi-mt65xx: add support for MT8516
Date: Wed, 17 Apr 2019 11:15:42 +0200
Message-ID: <c0801222-3e13-6d68-967e-dd76bdd01051@gmail.com>
References: <1555490836-13382-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        fparent@baylibre.com
To: Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555490836-13382-1-git-send-email-leilk.liu@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 17/04/2019 10:47, Leilk Liu wrote:
> Add binding documentation of spi-mt65xx for MT8516 SOC.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  .../devicetree/bindings/spi/spi-mt65xx.txt         |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> index 69c3567..c0f6c8e 100644
> --- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> @@ -10,6 +10,7 @@ Required properties:
>      - mediatek,mt8135-spi: for mt8135 platforms
>      - mediatek,mt8173-spi: for mt8173 platforms
>      - mediatek,mt8183-spi: for mt8183 platforms
> +    - "mediatek,mt8516-spi", "mediatek,mt2712-spi": for mt8516 platforms
>  
>  - #address-cells: should be 1.
>  
> 
