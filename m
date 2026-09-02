Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD94854F2
	for <linux-spi@vger.kernel.org>; Wed,  2 Sep 2026 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364104; cv=none; b=SR5AEGTTvDmOD2vRIzCah2K1W0wNV/+jtLXF99qFo89rfEflpGhLcD2FFF4qbHcUic3AgNJMq/0hMIjgiZqj53QRhVpef8iVGP/nyw72nWrI9YBHz8p6Vy9WW3j5rfQJ/SJq9Kia5D7sAVspSdOI1UGm8C5BlDnYRebw3Chq1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364104; c=relaxed/simple;
	bh=dd9Bc4n94EKXDL0ADU2/wZrlcVly5/OAqlHH4Cf65Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HndXbkbC2WDt5raWxUS3x/k2IltVeRk5TKdDKFFt4Xwvwb6Z+JZTe5dA2HdUsLnNjmHM9O9uswIS7Z5BzNlMLoEsE/wTerZOndUKvwxrFC1iEUzDaaAI45zwIYYe/zL62ALfnVaEW6uS3j2IKQ52zmBFBCa3g8WywLG7dTG/NkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JODVhp6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JODVhp6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AAD1F00A3A
	for <linux-spi@vger.kernel.org>; Wed,  2 Sep 2026 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364102;
	bh=WvDDggsJCp8fWjpjbH2MZ34V8WTIMSRAsuek7J69Z2o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JODVhp6SRX1XR4znAyCaW2UPD+FDbnGSvfHbCC+k45gxVC7aNVrYuQEvG890ao/6r
	 6T1UZ2F7mLSwWB+TUV/7NN9d3vu1GCq0l+OWkFlu5Xv64bnK5LK0APUSatecOnjw4d
	 c0YWgi0PYEbR2VgrQxMwy199ToKiNGNgnvyu6cA/tDDZp6tbRl8aB18WFlXFdYK1hu
	 jwYXTu5tGh7kUyFH35JaQgsz3nwHF4k5MhMYgCkhfXvCBKG5vHp5ahyY8Zs5zyM9Oj
	 37tEwFOwaJKlb+Ra0Qa31B6bwa4555RH8tnTOmmh944q50cZMD/41esy98FvKphmGk
	 jL2rvYpI7YRZw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2533d83e3bso178725966b.2
        for <linux-spi@vger.kernel.org>; Wed, 02 Sep 2026 08:48:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxj4gPIxGEmdHZ6+DCA4hpTuyG5MXJNd5KlnJhm8x/tB40KKkTuye0vheeCkWA9t5LoyqY0K6C/+Fo=@vger.kernel.org
X-Gm-Message-State: AFuF++lsqaj+j0b3j0WMN+RPVOxjmuoH4CDwMDBiJw6KY6nkLhuqmFWf
	Y1RRLrX/ST79cz5XHmGw1WMQGVSWDSAIHY9gxGW+8MnaHpGvLx19B/S0KPj5frKMitUOIHmrPlK
	D3wPF0ZdsRybqW7U8gtzvqWbkXfRkDQ==
X-Received: by 2002:a17:907:6090:b0:c25:c979:e76a with SMTP id
 a640c23a62f3a-c25d54fe9f3mr276782466b.22.1788364100947; Wed, 02 Sep 2026
 08:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819155502.3934837-1-maciej.andrzejewski@m-works.net> <e7995f64-3210-455d-bc97-9f3b51099162@kernel.org>
In-Reply-To: <e7995f64-3210-455d-bc97-9f3b51099162@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 2 Sep 2026 10:48:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ2zHrEf6-4Gohaqj+jq_dTeVoR=xyH=yZDTpjBEDoLBw@mail.gmail.com>
X-Gm-Features: AcwNN1Vp-60QgsJjsf8yFslx_Y0cjbf_CPILfdaB6rH4W7MLE--uqVMj_JD2DH8
Message-ID: <CAL_JsqJ2zHrEf6-4Gohaqj+jq_dTeVoR=xyH=yZDTpjBEDoLBw@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: of: Only apply the SPI CS quirk to SPI buses
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, broonie@kernel.org, 
	linux-spi@vger.kernel.org, miquel.raynal@bootlin.com, richard@nod.at, 
	vigneshr@ti.com, linux-mtd@lists.infradead.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 4:28=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 19/08/2026 17:55, Maciej Andrzejewski ICEYE wrote:
> > The legacy SPI chip-select polarity quirk in of_gpio_flags_quirks() is
> > keyed on nothing but the property name "cs-gpios". That name is not
> > exclusive to SPI: nand-controller.yaml documents the very same property
> > for NAND controllers, and rawnand_dt_parse_gpio_cs() requests those
> > lines with gpiod_count(dev, "cs"), which gpiolib expands to "cs-gpios".
> > A NAND controller therefore has SPI chip-select semantics forced onto
> > its chip selects, and any chip node whose first reg cell matches a GPIO
> > index is silently flipped to active low. The NAND core requests the
> > descriptors GPIOD_OUT_HIGH and drivers assert with a logical 0, so the
> > inversion leaves the die permanently deselected.
> >
> > The example in nand-controller.yaml is itself affected: it pairs a
> > native chip select with a GPIO one and gives the second chip a reg of 1=
,
> > which trips the quirk whenever CONFIG_SPI_MASTER is enabled. In-tree th=
e
> > collision is real but latent. 36 board trees, all Atmel/Microchip at91,
> > give their nand@3 controller a cs-gpios line, and they escape only
> > because the sole child of those nodes is a partitions container with no
> > reg for the quirk to match against.
> >
> > Device tree carries no bus type marker, so identify the bus from two
> > hints. Properties of an SPI peripheral are namespaced with "spi-"
> > (spi-max-frequency, spi-cpol, spi-cs-high and the rest of
> > spi-peripheral-props.yaml), whereas a NAND chip node carries only reg,
> > nand-* and its partition table. That is a convention rather than a
> > guarantee, since compatible and reg are the only properties
> > spi-controller.yaml makes mandatory for a peripheral, so let the
> > controller settle the remaining cases: spi-controller.yaml constrains
> > the controller nodename to ^spi(@.*|-[0-9]+)?$, which makes the name th=
e
> > one bus marker every conforming controller has to carry. A peripheral
> > that carries nothing but compatible and reg therefore keeps its active
> > low default through its parent. Skip the quirk only when neither test
> > matches.
> >
> > Both tests were scored over every board device tree in the kernel,
> > expanded with the same cpp and scripts/dtc pipeline the build uses, at
> > v7.2-rc7. All 3620 trees under arch/*/boot/dts expand; 503 of them hold
> > at least one GPIO chip select that can reach the quirk, 765 such chip
> > selects in total. 761 are matched by both tests, and none are matched b=
y
> > neither, so no in-tree board changes behaviour.
> >
> > One needs the property scan on its own: psc@11400 on ac14xx, a
> > fsl,mpc5121-psc-spi named after the hardware block rather than the bus,
> > whose m25p128@0 child carries spi-max-frequency.
> >
> > Three need the nodename on its own, all peripherals with no "spi-"
> > property of any kind:
> >
> >   - panel@0 under the spi-gpio controller on rk3566-anbernic-rg503
> >   - can@0, an mcp251xfd, under ecspi3 on imx8mn-vhip4-evalboard-v1
> >   - spi@1 under ecspi1 on imx53-ppd
> >
> > The two tests are complementary, so both are needed to keep every
> > in-tree board working. A tree that names its controller after the
> > hardware block and gives it a peripheral with no "spi-" property would
> > still lose the quirk. No in-tree board does, and such a controller is
> > already outside the nodename pattern spi-controller.yaml requires.
> >
> > of_gpio_spi_cs_get_count() in this file identifies SPI controllers with
> > of_device_is_compatible() instead, but it only has to name three legacy
> > controllers whose bindings are closed. An allow-list here would have to
> > name every SPI controller binding in the tree, 71 distinct compatible
> > strings among the candidates alone, and grow with every new one.
> >
> > Signed-off-by: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.n=
et>
> > ---
> > Changes in v2:
> > - Squashed the two patches into one. The property scan and the nodename
> >   test are complementary, so patch 1 alone stopped applying the quirk t=
o
> >   the three peripherals that carry no "spi-" property, which would have
> >   broken those boards for anyone bisecting through the series. Reported
> >   by an automated review of v1.
> > - Folded the two helpers into a single of_gpio_is_spi_chipselect().
> > - Said outright that a peripheral with nothing but compatible and reg
> >   keeps its active low default through the controller nodename.
> > - Rebased; drivers/gpio/gpiolib-of.c is unchanged since v7.2-rc7, so th=
e
> >   diff itself is the v1 pair verbatim.
> >
> > v1: https://lore.kernel.org/r/20260810141629.81650-1-maciej.andrzejewsk=
i@m-works.net
> >
> >  drivers/gpio/gpiolib-of.c | 31 +++++++++++++++++++++++++++++--
> >  1 file changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> > index 940b566946ce..d73114166f6b 100644
> > --- a/drivers/gpio/gpiolib-of.c
> > +++ b/drivers/gpio/gpiolib-of.c
> > @@ -340,6 +340,28 @@ static void of_gpio_set_polarity_by_property(const=
 struct device_node *np,
> >       }
> >  }
> >
> > +/*
> > + * The legacy SPI chip select binding below is keyed on a property nam=
e that
> > + * other subsystems reuse for the same purpose, notably NAND controlle=
rs (see
> > + * Documentation/devicetree/bindings/mtd/nand-controller.yaml), whose =
chip
> > + * selects carry no SPI polarity semantics. Device tree has no bus typ=
e
> > + * marker, so take two hints. Properties of an SPI peripheral are name=
spaced
> > + * with "spi-", and a peripheral that declares none is covered by the
> > + * controller, whose nodename spi-controller.yaml constrains to
> > + * ^spi(@.*|-[0-9]+)?$.
> > + */
> > +static bool of_gpio_is_spi_chipselect(const struct device_node *np,
> > +                                   const struct device_node *child)
> > +{
> > +     struct property *pp;
> > +
> > +     for_each_property_of_node(child, pp)
> > +             if (str_has_prefix(pp->name, "spi-"))
>
> You should not rely on prefixes of properties. Node can have no such
> properties at all.
>
>
> > +                     return true;
> > +
> > +     return of_node_name_prefix(np, "spi");
>
> And neither this. You just added node name based ABI.
>
> Nope.
>
> Each peripheral exactly knows that it is a SPI device - it 100% specific
> knowledge based on the bus, thus nothing of above is needed.

Do you have an actual suggestion on how to fix it instead? It is
needed for every SPI controller that uses cs-gpios which is
potentially all of them. There's 522 cases of cs-gpios and only a few
are NAND. Even if it is 10 boards per SoC, that's still 52 cases which
would be more than I want to list in the kernel.

Perhaps the SPI core when requesting "cs-gpios" could state "apply the
polarity quirk to to this GPIO" rather than the GPIO core having any
specific knowledge about "cs-gpios".

However, IMO, for bus nodes, the node names are ABI. That's the only
way we can identify what type of bus for some buses. The DT core looks
for "isa", "pci" or "pcie" node names for ISA and PCI buses for
example. So I don't have much issue with the current approach.

Rob
