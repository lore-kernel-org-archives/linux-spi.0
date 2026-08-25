Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881342E43D;
	Tue, 25 Aug 2026 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673195; cv=none; b=UHVhiYNhkFwx5HUP4kiEA1VVbrZybpBFZDxR2AqXtV3SYWZyL/+LFvM54ToIl9GMtY2vLEM+LWL21EKQWnyT4LVlR5OgR1Ret71FQTXLbHFUdMXcsCmpsIICmMK+Bgz8ux0pjFSnn7v71NdiIn+7JxhC3OULavacMUFvZdUEjo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673195; c=relaxed/simple;
	bh=dcKT6azsjRjWutpi4ebH55Jr0c+6I4CEvnw1UsnE80g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pomv/50aUh3BqXpzkaGflmjkzvc4f+jQshkKPHaZzR1n3vFGTQ02e7gXipGvPV/9scW1cbjbPJraKCUOsPjvo6vOGh35wUA5M9WNrk78UQpVZmC7ORp4PeGiPgJVDjjx1DpHmdDjxGG8BCqWiiy30jCs5LkYjAiHkiZ0AZXJWd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ttp339aZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ttp339aZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 621B41A1766;
	Tue, 25 Aug 2026 15:53:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 344E2604C4;
	Tue, 25 Aug 2026 15:53:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E279D11C7A676;
	Tue, 25 Aug 2026 17:53:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787673184; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ayRsWbjbDg+OxGMZloCREgzB7cLLDf7rWS6c16W8m04=;
	b=Ttp339aZvzmPPp1xKY3R8tnslhH2kqZtTJOsY+TbirETxjUP34ngaOeHLkKkkoupWugiej
	FE2jlvbl7TxCWrCgFzTPbiRJgUqMp6y9hRg2XXv3fuJJKBeDL6lXp5RVybmXEDyTpVRKTs
	HLqsMvdBJ5L5WsT60LR8dweqPYRPwEmAFBInWrhd232HShmFxFTXfkCZOcJdhWtMEko8ti
	9qTM5eoOI2RtzKZ4rY+XSZvH8odfN3kODQd8kO/RHtgVWstGniLlnpGFtOayje9sCjfcR/
	SVfRPIP072W2MQwzk3xRk4JakoKI3N/NycfaBhrnm2MUnkUtCjD2X8umDS/6Jg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
Cc: Linus Walleij <linusw@kernel.org>,  Bartosz Golaszewski
 <brgl@kernel.org>,  linux-gpio@vger.kernel.org,  broonie@kernel.org,
  linux-spi@vger.kernel.org,  richard@nod.at,  vigneshr@ti.com,
  linux-mtd@lists.infradead.org,  robh@kernel.org,  krzk+dt@kernel.org,
  conor+dt@kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: of: Only apply the SPI CS quirk to SPI buses
In-Reply-To: <20260819155502.3934837-1-maciej.andrzejewski@m-works.net>
	(Maciej Andrzejewski ICEYE's message of "Wed, 19 Aug 2026 17:55:10
	+0200")
References: <20260819155502.3934837-1-maciej.andrzejewski@m-works.net>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 25 Aug 2026 17:53:00 +0200
Message-ID: <877blegpsz.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Maciej,

On 19/08/2026 at 17:55:10 +02, Maciej Andrzejewski ICEYE <maciej.andrzejews=
ki@m-works.net> wrote:

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

:')

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

Sounds okay to me.

> of_gpio_spi_cs_get_count() in this file identifies SPI controllers with
> of_device_is_compatible() instead, but it only has to name three legacy
> controllers whose bindings are closed. An allow-list here would have to
> name every SPI controller binding in the tree, 71 distinct compatible
> strings among the candidates alone, and grow with every new one.

That would be impossible to maintain indeed.

>
> Signed-off-by: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>

I believe "ICEYE" is your company which backed this work, in which case
you should use "(ICEYE)" instead.

Also, this probably deserves a Fixes and Cc: stable set of tags.

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
> v1: https://lore.kernel.org/r/20260810141629.81650-1-maciej.andrzejewski@=
m-works.net
>
>  drivers/gpio/gpiolib-of.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 940b566946ce..d73114166f6b 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -340,6 +340,28 @@ static void of_gpio_set_polarity_by_property(const s=
truct device_node *np,
>  	}
>  }
>=20=20
> +/*
> + * The legacy SPI chip select binding below is keyed on a property name =
that
> + * other subsystems reuse for the same purpose, notably NAND controllers=
 (see
> + * Documentation/devicetree/bindings/mtd/nand-controller.yaml), whose ch=
ip
> + * selects carry no SPI polarity semantics. Device tree has no bus type
> + * marker, so take two hints. Properties of an SPI peripheral are namesp=
aced
> + * with "spi-", and a peripheral that declares none is covered by the
> + * controller, whose nodename spi-controller.yaml constrains to
> + * ^spi(@.*|-[0-9]+)?$.
> + */
> +static bool of_gpio_is_spi_chipselect(const struct device_node *np,
> +				      const struct device_node *child)
> +{

This check will be done for each child, whereas we should have to do it
only once for a given controller node. Plus, as soon as one of the
children has a spi- property, it is enough for enabling the quirk for
all the children whereas in this implementation, only one child is used
at a time to derive the bus type, which means in theory you could have
one child node that gets the quirk and another child node of the same
parent which does not.

This is not a show stopper, but I believe this can be slightly
enhanced,if that does not make the code too complex.

With the comments on the tags and SoB addressed, you can nevertheless
add my:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
