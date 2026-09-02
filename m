Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1513C3EF67D;
	Wed,  2 Sep 2026 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341325; cv=none; b=SN1GME9JSxwlLk1HKKDaipRPH2FIGQ53uZ99MsjnbHmsbSKz67g4DNXAM+6BGfRknq7WBUO8T7choh4uOnrxqxwYZf05m1SkTLaE4HRpZk2Hn1g1irZExVXT1/eX9HNVuz2J9zjSRtIT6IV//GQ1IoNC2+obClXIEsJvhiNGYPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341325; c=relaxed/simple;
	bh=pwZWNuJkBNnGXK8ZDBJHzH2oBaGrEgqMFO8CdQFM8iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jQUxgGr9BCGBgMyftVAVH6CFJtwmCYUJeXuBTUq9ywAA28jmMtPY3itAONYP9/t1V7kjsR/q4X7ErCqPbmZ2jvnvxMhW0973QDqm60S5YmMwYWyLxDNRuwQOZADQ3HaNtm+I0fbG40fOKjvtDu1q5mbw2hcwaVK9mZO3/A/3Euo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6Eqli8D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6Eqli8D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6B11F000E9;
	Wed,  2 Sep 2026 09:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788341324;
	bh=5qIIy5bATDjKKxhR1VjNGWxxM0HBUrBwTz21aaJz6+8=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=S6Eqli8DtHGR9DesjBg7K64KNGgaJr/6yv1FSd+/8bCZejYjxsmwEwh9mJF8cpOVj
	 56Ith8MbHMZ9fD6YfxgpvUnu+gZPSX0rxNDuFF7u7UGv8MyJ1Q0qXZ3ooTyXzYOOmd
	 /0dT+KE7F6jy/fUl4/sz8XY+/t5fGnfQqJcQ7GKtc//ag8EIrW1eSZ229lq2znD+4/
	 Df0Tcu8hu9C0gR3WcOBiAiLJPv9/3aLcsaY/P3QxnpE/4zvSrqDAUYQYhKzS29EM30
	 gS4pbN8jCwhoABfmZzL7hIjeTaH8f+04wUQWPClRE/f4kqR/G/yK5CMtmQIUxPAjLj
	 7KEfv/mSR7gpg==
Message-ID: <e7995f64-3210-455d-bc97-9f3b51099162@kernel.org>
Date: Wed, 2 Sep 2026 11:28:33 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpiolib: of: Only apply the SPI CS quirk to SPI buses
To: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-gpio@vger.kernel.org, broonie@kernel.org, linux-spi@vger.kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 linux-mtd@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260819155502.3934837-1-maciej.andrzejewski@m-works.net>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260819155502.3934837-1-maciej.andrzejewski@m-works.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2026 17:55, Maciej Andrzejewski ICEYE wrote:
> The legacy SPI chip-select polarity quirk in of_gpio_flags_quirks() is
> keyed on nothing but the property name "cs-gpios". That name is not
> exclusive to SPI: nand-controller.yaml documents the very same property
> for NAND controllers, and rawnand_dt_parse_gpio_cs() requests those
> lines with gpiod_count(dev, "cs"), which gpiolib expands to "cs-gpios".
> A NAND controller therefore has SPI chip-select semantics forced onto
> its chip selects, and any chip node whose first reg cell matches a GPIO
> index is silently flipped to active low. The NAND core requests the
> descriptors GPIOD_OUT_HIGH and drivers assert with a logical 0, so the
> inversion leaves the die permanently deselected.
> 
> The example in nand-controller.yaml is itself affected: it pairs a
> native chip select with a GPIO one and gives the second chip a reg of 1,
> which trips the quirk whenever CONFIG_SPI_MASTER is enabled. In-tree the
> collision is real but latent. 36 board trees, all Atmel/Microchip at91,
> give their nand@3 controller a cs-gpios line, and they escape only
> because the sole child of those nodes is a partitions container with no
> reg for the quirk to match against.
> 
> Device tree carries no bus type marker, so identify the bus from two
> hints. Properties of an SPI peripheral are namespaced with "spi-"
> (spi-max-frequency, spi-cpol, spi-cs-high and the rest of
> spi-peripheral-props.yaml), whereas a NAND chip node carries only reg,
> nand-* and its partition table. That is a convention rather than a
> guarantee, since compatible and reg are the only properties
> spi-controller.yaml makes mandatory for a peripheral, so let the
> controller settle the remaining cases: spi-controller.yaml constrains
> the controller nodename to ^spi(@.*|-[0-9]+)?$, which makes the name the
> one bus marker every conforming controller has to carry. A peripheral
> that carries nothing but compatible and reg therefore keeps its active
> low default through its parent. Skip the quirk only when neither test
> matches.
> 
> Both tests were scored over every board device tree in the kernel,
> expanded with the same cpp and scripts/dtc pipeline the build uses, at
> v7.2-rc7. All 3620 trees under arch/*/boot/dts expand; 503 of them hold
> at least one GPIO chip select that can reach the quirk, 765 such chip
> selects in total. 761 are matched by both tests, and none are matched by
> neither, so no in-tree board changes behaviour.
> 
> One needs the property scan on its own: psc@11400 on ac14xx, a
> fsl,mpc5121-psc-spi named after the hardware block rather than the bus,
> whose m25p128@0 child carries spi-max-frequency.
> 
> Three need the nodename on its own, all peripherals with no "spi-"
> property of any kind:
> 
>   - panel@0 under the spi-gpio controller on rk3566-anbernic-rg503
>   - can@0, an mcp251xfd, under ecspi3 on imx8mn-vhip4-evalboard-v1
>   - spi@1 under ecspi1 on imx53-ppd
> 
> The two tests are complementary, so both are needed to keep every
> in-tree board working. A tree that names its controller after the
> hardware block and gives it a peripheral with no "spi-" property would
> still lose the quirk. No in-tree board does, and such a controller is
> already outside the nodename pattern spi-controller.yaml requires.
> 
> of_gpio_spi_cs_get_count() in this file identifies SPI controllers with
> of_device_is_compatible() instead, but it only has to name three legacy
> controllers whose bindings are closed. An allow-list here would have to
> name every SPI controller binding in the tree, 71 distinct compatible
> strings among the candidates alone, and grow with every new one.
> 
> Signed-off-by: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
> ---
> Changes in v2:
> - Squashed the two patches into one. The property scan and the nodename
>   test are complementary, so patch 1 alone stopped applying the quirk to
>   the three peripherals that carry no "spi-" property, which would have
>   broken those boards for anyone bisecting through the series. Reported
>   by an automated review of v1.
> - Folded the two helpers into a single of_gpio_is_spi_chipselect().
> - Said outright that a peripheral with nothing but compatible and reg
>   keeps its active low default through the controller nodename.
> - Rebased; drivers/gpio/gpiolib-of.c is unchanged since v7.2-rc7, so the
>   diff itself is the v1 pair verbatim.
> 
> v1: https://lore.kernel.org/r/20260810141629.81650-1-maciej.andrzejewski@m-works.net
> 
>  drivers/gpio/gpiolib-of.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 940b566946ce..d73114166f6b 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -340,6 +340,28 @@ static void of_gpio_set_polarity_by_property(const struct device_node *np,
>  	}
>  }
>  
> +/*
> + * The legacy SPI chip select binding below is keyed on a property name that
> + * other subsystems reuse for the same purpose, notably NAND controllers (see
> + * Documentation/devicetree/bindings/mtd/nand-controller.yaml), whose chip
> + * selects carry no SPI polarity semantics. Device tree has no bus type
> + * marker, so take two hints. Properties of an SPI peripheral are namespaced
> + * with "spi-", and a peripheral that declares none is covered by the
> + * controller, whose nodename spi-controller.yaml constrains to
> + * ^spi(@.*|-[0-9]+)?$.
> + */
> +static bool of_gpio_is_spi_chipselect(const struct device_node *np,
> +				      const struct device_node *child)
> +{
> +	struct property *pp;
> +
> +	for_each_property_of_node(child, pp)
> +		if (str_has_prefix(pp->name, "spi-"))

You should not rely on prefixes of properties. Node can have no such
properties at all.


> +			return true;
> +
> +	return of_node_name_prefix(np, "spi");

And neither this. You just added node name based ABI.

Nope.

Each peripheral exactly knows that it is a SPI device - it 100% specific
knowledge based on the bus, thus nothing of above is needed.

Best regards,
Krzysztof
