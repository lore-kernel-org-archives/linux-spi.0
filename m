From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH 1/4] pinctrl: mcp23s08: IRQ behavior for open-drain
 interrupts
Date: Mon, 29 Jan 2018 09:06:33 +0800
Message-ID: <621e8caf-3591-9748-dcdd-7ae8f7222e80@electromag.com.au>
References: <cover.1516997103.git.jan.kundrat@cesnet.cz>
 <9e78a4a697c8d4d3028ea8780bd925471b49af3c.1516997103.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-spi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: =?UTF-8?Q?Jan_Kundr=c3=a1t?= <jan.kundrat@cesnet.cz>,
        linux-gpio@vger.kernel.org
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <9e78a4a697c8d4d3028ea8780bd925471b49af3c.1516997103.git.jan.kundrat@cesnet.cz>
Content-Language: en-AU
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

G'day Jan,

On 25/01/2018 23:08, Jan Kundrát wrote:
> The hardware supports three different IRQ modes:
> - open drain, i.e., an active-low output which requires an external
>    pull-up and supports IRQ line sharing,
> - active low, with push-pull output,
> - active high, with push-pull output.
> 
> My understanding of electronics is limited, but it is "wrong" to connect
> different push-pull outpus together. It could sort-of work if the
> chips/board actually have some resistors there, but it's an ugly thing
> to do.
> 
> In the past, this driver did not touch the ODR bit (for open-drain)
> operation. During power-on-reset, it is set to zero. Unless some
> platform code actually set this bit to one, this means that the code
> never supported open drain operation.
> 
> This change makes this handling explicit. If you want sharing of the IRQ
> line, then use the microchip,irq-open-drain mode and add an external
> pull-up.
> 
> There's some risk here. If, e.g., the bootloader sets the ODR bit for
> some reason, the HW shares the IRQ lines, and nobody changes the DT,
> then your HW will suddenly use push-pull driver for the IRQ line. If
> there is any other chip on the same lane, the HW might suffer (my chip
> survived this when I "tested" this by accident with no bootloader code
> to set the ODR bit).
> 
> Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
> ---
>   .../bindings/pinctrl/pinctrl-mcp23s08.txt          |  4 ++
>   drivers/pinctrl/pinctrl-mcp23s08.c                 | 82 +++++++++++++++-------
>   2 files changed, 61 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt
> index 9c451c20dda4..92aa91027c68 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt
> @@ -58,6 +58,10 @@ Optional device specific properties:
>           On devices with only one interrupt output this property is useless.
>   - microchip,irq-active-high: Sets the INTPOL flag in the IOCON register. This
>           configures the IRQ output polarity as active high.
> +- microchip,irq-open-drain: Sets the ODR flag in the IOCON register. This
> +        configures the IRQ output as active low open-drain and allows sharing
> +	of the IRQ line among several chips. Note that irq-active-high and
> +	irq-open-drain are mutually exclusive.

I submitted a patch for this in November, But haven't followed up on the last review as yet.
See: https://patchwork.ozlabs.org/cover/839923/

I used exactly the same dt in my first propsal. But you'll see form the discussions that series
This needs to be the standard 'drive-open-drain' flag

Patch 2/5 has been reviewed by Sebastian acked Rob.


>   
>   Example I2C (with interrupt):
>   gpiom1: gpio@20 {
> diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
> index c017860619d6..186101c575e3 100644
> --- a/drivers/pinctrl/pinctrl-mcp23s08.c
> +++ b/drivers/pinctrl/pinctrl-mcp23s08.c
> @@ -54,9 +54,15 @@
>   
>   struct mcp23s08;
>   
> +enum mcp23s08_irq_regime {
> +	MCP_IRQ_PULL_LOW,
> +	MCP_IRQ_PUSH_UP,
> +	MCP_IRQ_OPEN_DRAIN
> +};
> +
>   struct mcp23s08 {
>   	u8			addr;
> -	bool			irq_active_high;
> +	enum mcp23s08_irq_regime	irq_regime;
>   	bool			reg_shift;
>   
>   	u16			irq_rise;
> @@ -625,10 +631,17 @@ static int mcp23s08_irq_setup(struct mcp23s08 *mcp)
>   	int err;
>   	unsigned long irqflags = IRQF_ONESHOT | IRQF_SHARED;
>   
> -	if (mcp->irq_active_high)
> -		irqflags |= IRQF_TRIGGER_HIGH;
> -	else
> +	switch (mcp->irq_regime) {
> +	case MCP_IRQ_PULL_LOW:
>   		irqflags |= IRQF_TRIGGER_LOW;
> +		break;
> +	case MCP_IRQ_PUSH_UP:
> +		irqflags |= IRQF_TRIGGER_HIGH;
> +		break;
> +	case MCP_IRQ_OPEN_DRAIN:
> +		irqflags |= IRQF_TRIGGER_LOW | IRQF_SHARED;
> +		break;
> +	}
The original code does the same thing.
open drain is active-low.
Sharing can also be achieved by AND / OR gates with push-pull drivers.
So no need to treat that differently.

I'm trying to get ride f this bit of code as it should be needed.
see 1/5 of my series.

>   
>   	err = devm_request_threaded_irq(chip->parent, mcp->irq, NULL,
>   					mcp23s08_irq,
> @@ -780,7 +793,7 @@ static int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
>   
>   	mcp->dev = dev;
>   	mcp->addr = addr;
> -	mcp->irq_active_high = false;
> +	mcp->irq_regime = MCP_IRQ_PULL_LOW;
>   
>   	mcp->chip.direction_input = mcp23s08_direction_input;
>   	mcp->chip.get = mcp23s08_get;
> @@ -866,33 +879,52 @@ static int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
>   	mcp->irq_controller =
>   		device_property_read_bool(dev, "interrupt-controller");
>   	if (mcp->irq && mcp->irq_controller) {
> -		mcp->irq_active_high =
> -			device_property_read_bool(dev,
> -					      "microchip,irq-active-high");
> +		bool irq_active_high = device_property_read_bool(dev,
> +						"microchip,irq-active-high");
> +		bool irq_open_drain = device_property_read_bool(dev,
> +						"microchip,irq-open-drain");
> +		if (irq_active_high && irq_open_drain) {
> +			dev_err(dev, "microchip,irq-open-drain and "
> +				"microchip,irq-active-high are mutually exclusive\n");
> +			ret = -EINVAL;
> +			goto fail;
> +		} else if (irq_active_high) {
> +			mcp->irq_regime = MCP_IRQ_PUSH_UP;
> +		} else if (irq_open_drain) {
> +			mcp->irq_regime = MCP_IRQ_OPEN_DRAIN;
> +		}
>   
>   		mirror = device_property_read_bool(dev, "microchip,irq-mirror");
>   	}
>   
> -	if ((status & IOCON_SEQOP) || !(status & IOCON_HAEN) || mirror ||
> -	     mcp->irq_active_high) {
> -		/* mcp23s17 has IOCON twice, make sure they are in sync */
> -		status &= ~(IOCON_SEQOP | (IOCON_SEQOP << 8));
> -		status |= IOCON_HAEN | (IOCON_HAEN << 8);
> -		if (mcp->irq_active_high)
> -			status |= IOCON_INTPOL | (IOCON_INTPOL << 8);
> -		else
> -			status &= ~(IOCON_INTPOL | (IOCON_INTPOL << 8));
> +	/* mcp23s17 has IOCON twice, make sure they are in sync */
> +	status &= ~(IOCON_SEQOP | (IOCON_SEQOP << 8));
> +	status |= IOCON_HAEN | (IOCON_HAEN << 8);
>   
> -		if (mirror)
> -			status |= IOCON_MIRROR | (IOCON_MIRROR << 8);
> +	switch (mcp->irq_regime) {
> +	case MCP_IRQ_PUSH_UP:
> +		status |= IOCON_INTPOL | (IOCON_INTPOL << 8);
> +		status &= ~(IOCON_ODR | (IOCON_ODR << 8));
> +		break;
> +	case MCP_IRQ_PULL_LOW:
> +		status &= ~(IOCON_INTPOL | (IOCON_INTPOL << 8));
> +		status &= ~(IOCON_ODR | (IOCON_ODR << 8));
> +		break;
> +	case MCP_IRQ_OPEN_DRAIN:
> +		/* ODR overrides INTPOL */
> +		status |= IOCON_ODR | (IOCON_ODR << 8);
> +		break;
> +	}
>   
> -		if (type == MCP_TYPE_S18 || type == MCP_TYPE_018)
> -			status |= IOCON_INTCC | (IOCON_INTCC << 8);
> +	if (mirror)
> +		status |= IOCON_MIRROR | (IOCON_MIRROR << 8);
>   
> -		ret = mcp_write(mcp, MCP_IOCON, status);
> -		if (ret < 0)
> -			goto fail;
> -	}
> +	if (type == MCP_TYPE_S18 || type == MCP_TYPE_018)
> +		status |= IOCON_INTCC | (IOCON_INTCC << 8);
> +
> +	ret = mcp_write(mcp, MCP_IOCON, status);
> +	if (ret < 0)
> +		goto fail;
>   
>   	ret = devm_gpiochip_add_data(dev, &mcp->chip, mcp);
>   	if (ret < 0)
> 


-- 
Regards
Phil Reid
