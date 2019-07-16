From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] dt-bindings: Ensure child nodes are of type 'object'
Date: Tue, 16 Jul 2019 09:19:33 +0200
Message-ID: <20190716091933.39db956e@xps13>
References: <20190715230457.3901-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-spi@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190715230457.3901-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Rob,

Rob Herring <robh@kernel.org> wrote on Mon, 15 Jul 2019 17:04:57 -0600:

> Properties which are child node definitions need to have an explict
> type. Otherwise, a matching (DT) property can silently match when an
> error is desired. Fix this up tree-wide. Once this is fixed, the
> meta-schema will enforce this on any child node definitions.
> 
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack. I will take this via the DT tree.
> 
> Rob
> 
>  .../devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml       | 1 +
>  .../devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml      | 1 +
>  Documentation/devicetree/bindings/mtd/nand-controller.yaml     | 1 +
>  .../devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml          | 3 +++
>  .../devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml       | 1 +
>  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml       | 1 +
>  6 files changed, 8 insertions(+)
> 

[...]

> diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> index 199ba5ac2a06..d261b7096c69 100644
> --- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> +++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> @@ -40,6 +40,7 @@ properties:
>  
>  patternProperties:
>    "^nand@[a-f0-9]$":
> +    type: object
>      properties:
>        reg:
>          description:

For the mtd .yaml:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
