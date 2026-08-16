Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966823E3C68
	for <linux-spi@vger.kernel.org>; Sun, 16 Aug 2026 21:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786916393; cv=pass; b=lZ/Y6KauC1aQArJaBl2LcwNTCR/yE7SRKHUbZFJWlOpKJ4jvPTdpnBG/zUlxo8LjXLx1NJgcNG70aVP30lmuxmKJtdFuM89OKlPNSY5/Sqxe0inJ/ksSDIF6qyF9/5U/xb9DzU9+nNZr6Avfje33b7SOFnnKS0j7c2XNMB0Sa+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786916393; c=relaxed/simple;
	bh=sk/O5OIRnaq3arFgD+vpKmJGWa24ka0FGptRJwolFo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrW8wtxq5v7AGlPibFvqS/KAQuLXVVpIlNz3ivTjGaSy0oqcSBaYr8aalESpSdnE3rJupMvICAn/9tUCs7xYL9gSvDu+OSBOhQ6V+atIVjPvw6rirQYiYx9f9vSY3KLaoGxLaffMA9Vrc0ro2TmClB7Lkm0DkL4OjqXRbCEILp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M58y1Ib7; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M58y1Ib7"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698aece3d7eso509921a12.1
        for <linux-spi@vger.kernel.org>; Sun, 16 Aug 2026 14:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786916389; cv=none;
        d=google.com; s=arc-20260327;
        b=JqtO9bJWEJmPNee13L1c4x0dlkzVVhGjQ2GFEgB4bAeG5++DuhGf6+kX5uxUlqk4Nq
         /OiBLUmtgjqCZfxtLbajNBoKyseQRCjvj/ESS2lnPkqCRxRa7OLmUUSqzcldXcREAcnj
         ReB4j7Swian7AI4xssRB3lA3epLpIZq2ITL5WF3QAO37pd4N1jJEg/nmCcAhyPvopllv
         AggYhwMMoCp3Wb/1mZZpHBW0oiOYseSnpxY3CzWT8WGJpBq1fjDBRsjEBqn2CuHlIY+A
         mnhgOm5+21XQePkqwxnE3i2nhVxJ78uzwfJ4e7Y9zAW6VsYJZnRGHqgyWX3VDBB5gTa2
         sGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xglRKTt4KUB+6yAUqDnkPRNrWgjj9VvUzr7120MLrIU=;
        fh=bBTC++hnVGLegjxNgFnsmOrfDEX61bViz11u6eTW0VY=;
        b=GQ1YE6tCnsJtQ0mVzEzsPmn2Dzvw3MkEMmpN2M2SAS6kNmzKQaWuI+a36pOO/hap2a
         V/T1wf26UN5Siz1+OuzTT0F3gLXhD5KZ6SvmYzeAm+NJvmSdgMZ184IG7Zrz2WbrbXsO
         G3AwKU/aZtAAw3/qRllVlyBYXMLTrKhEosmsHEbifXHguc6X72iKnwZWGQw3wkYCSuM9
         UYXrOWKIfKiTjvFUS5iMphwfGHn0NZT9sBNKBvW1epdts3pcCpmzUx7Nv9P1KbMSM2R0
         jv6r1VRrdP/qhP1BCODweg9tAYNdbFaEiq+4WuHXBMHvn5uX3Hup51XhOBxQfWtHDoF6
         hytg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786916389; x=1787521189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xglRKTt4KUB+6yAUqDnkPRNrWgjj9VvUzr7120MLrIU=;
        b=M58y1Ib7U7fP0Tju3wcfjfiKdVpDvIVRvfB2fXQDyTfA8yNFOw0T9HrtZkZoaIrl1o
         iIpSW4+EM8o9eEqjDeusbajuvgbsOtQr+VYLpHLtehhkuQFHYw7/8AVX4zvM0eN7JgEj
         3Dq6P2Ps5zMlsEEJ0aCpGhK0stpLHfSY1Ztv53GP5g9GJKI6+J5jmFMdKFIcG3dDoEwB
         2vwuV8gs0CNfOzSK4PKGHvMzwz39kW7t4GMIyjh/jgq/YjS8pFqvIQv9IdTA5UH6ueHn
         SUmsNlYtByQ+fu+z+AZTDRtzEtOP/5qK42qO0Tg/4tZOhoJmcM1BairJI6ARlE+S2xX7
         BaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786916389; x=1787521189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xglRKTt4KUB+6yAUqDnkPRNrWgjj9VvUzr7120MLrIU=;
        b=acNMMrIxDN0m5+0lIdviePFSRDFvmiIsJRW/VkBaw3q9ieE2puHVKUyzYk3pYzsYbs
         19/UijRdYMuMJs6UYDSNkasShQDfW284h/siKFahXYvZ0UGRRAncI5VUFeN7Lb9AiLdV
         ogFp0wHYpDdJskTs0W6WaKc2OkvBf6cywPbDfh3JVJua9Yt6Ynm7Uj1ym6y0gwXODlnS
         UKfxzWXXP3y7XPKQOf+aFQXTWi0tZ9wMJ0M9m7r8DcICR5xHS49qtKl6pbiLm+fBlkPJ
         Waeu6waGBCD6uvszg0sRCQOGkGKarpmM+3H619epQ0E3gB8+TyzCa5dwzstwzQpFPfxd
         WFgA==
X-Forwarded-Encrypted: i=1; AHgh+Rrl2jMnpSz3PKYs7Kio03wqKZhSrWhd3CxBHKQ+oZ5G9IsERzltfzGu0pIjNgB3NX7mFjDqZEzWDNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ejZGmkFLH4uRLg9OmwL/ZtPQMICcMDhlPkNzmJnMbbhLSPDD
	hPDSNsGiTYOnJu0X24F2LqayqvGH2q9s7GpBP69zt0sm3ndz7JGMUjWF3KOmbLfXKletFysIyKO
	FIqgfHrDFf3GyknLP6HLxV64rSVcO7u8=
X-Gm-Gg: AR+sD13IqfmwlQArnVz/eWATLC0mtEPhleH7f/3L7KYN0Wgo9HvndW/43vKk8+kbI4e
	7bcMP/bicpsqVkZ+/mthXYpUZ4/+L6onujio9mH/1uN1+Y+zHmaPrJ4BA1GjsdA/jW6kiWObhTx
	Z4LrOuaLWa6YLnHEzyic37sebyYmxbNO1vF4N7HNActExGghN2+cSD0AoKivZMq2JRzwwZShZBO
	3b26wYsUhBrpJNmqeOQWmBor1y11Kme1NZkOBlafBWnRRHIDwVHTX089vwsqf1YPKlB87uihzD6
	/9SVbLFafOq7FA5s7ItODzJddIC6L6Fl+ki+q9h/RoGd
X-Received: by 2002:a17:907:1c13:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c212a1f6ee6mr425274466b.3.1786916388402; Sun, 16 Aug 2026
 14:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816-ti-davinci-spi-v2-0-6c6f5171422b@gmail.com>
 <20260816-ti-davinci-spi-v2-2-6c6f5171422b@gmail.com> <ed2d4520-f09c-4be2-9c0b-5c6636e74653@gmail.com>
In-Reply-To: <ed2d4520-f09c-4be2-9c0b-5c6636e74653@gmail.com>
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Mon, 17 Aug 2026 03:09:35 +0530
X-Gm-Features: AcwNN1XNcnn9rjXY-wCP1UnwjDFl0JIj6YGfUBtyZpIqNmQuy5EagFVjYzqBJn0
Message-ID: <CAOWyW_7_gwXzjPh2yZZ-5wR5mArbYZkGJvkCMijpWaML2P4D+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: spi: ti,davinci-spi: convert to DT schema
To: Dhruva G <goledhruva@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	m-chawdhry@ti.com, daniel.baluta@gmail.com, simona.toaca@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 16, 2026 at 11:09=E2=80=AFPM Dhruva G <goledhruva@gmail.com> wr=
ote:
>
> Hi Bhargav,
>
> On 16-08-2026 03:53, Bhargav Joshi wrote:
> > Convert the TI DaVinci/Keystone SPI controller binding from text format
> > to DT schema.
> >
> > Changes during the conversion:
> > - Create a separate ti,davinci-spi-peripheral-props.yaml schema to
> >   properly define the ti,spi-wdelay peripheral property.
> > - Add missing dmas and dma-names properties.
> > - Add constraints to ti,spi-wdelay based on the 6-bit width
> >   of the SPIFMTn.WDELAY hardware register field.
> >
> > Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> > ---
> >  .../devicetree/bindings/spi/spi-davinci.txt        | 100 -------------=
---->  .../bindings/spi/spi-peripheral-props.yaml         |   1 +
> >  .../spi/ti,davinci-spi-peripheral-props.yaml       |  25 +++++
> >  .../devicetree/bindings/spi/ti,davinci-spi.yaml    | 118 +++++++++++++=
++++++++
> >  4 files changed, 144 insertions(+), 100 deletions(-)
> >
> [..snip..]
> > diff --git a/Documentation/devicetree/bindings/spi/ti,davinci-spi.yaml =
b/Documentation/devicetree/bindings/spi/ti,davinci-spi.yaml
> > new file mode 100644
> > index 000000000000..b685082de721
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/ti,davinci-spi.yaml
> > @@ -0,0 +1,118 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/ti,davinci-spi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI DaVinci/Keystone SPI Controller
> > +
> > +maintainers:
> > +  - Bartosz Golaszewski <brgl@kernel.org>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - ti,da830-spi
> > +          - ti,keystone-spi
> > +          - ti,dm6441-spi
> > +      - items:
> > +          - const: ti,keystone-spi
> > +          - const: ti,dm6441-spi
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +    description:
> > +      Should contain a phandle to a PM domain provider node
> > +      and an args specifier containing the SPI device id
> > +      value.
> > +
> > +  num-cs:
> > +    minimum: 1
> > +    default: 1
> > +    description:
> > +      Number of chip selects supported by the controller. This
> > +      includes both internal and GPIO chip selects.
> > +
> > +  ti,davinci-spi-intr-line:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1]
> > +    description:
> > +      Interrupt line used to connect the SPI IP to the interrupt
> > +      controller within the SoC.  The SPI peripheral can route its
> > +      interrupt output to one of two lines (INT0 or INT1). Set
> > +      this based on the SoC-specific wiring to the interrupt
> > +      controller.
> > +
> > +  dmas:
> > +    items:
> > +      - description: RX DMA channel
> > +      - description: TX DMA channel
> > +
> > +  dma-names:
> > +    items:
> > +      - const: rx
> > +      - const: tx
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - ti,davinci-spi-intr-line
>
> The old text binding lists #address-cells, #size-cells, and num-cs as req=
uired properties,
> but the converted schema omits all three from the required list, was that=
 intentional?
>
since #address-cells #size-cells are required only if there are child
nodes so i omitted it but will fix it
v3.

> spi-controller.yaml defines these properties but does not require them, s=
o this silently relaxes
> the binding and permits controller nodes without the SPI bus cell declara=
tions.
>
> num-cs was also required by the old binding. It should remain required to=
 preserve the existing binding,
> or else the commit message should explain why making it optional and rely=
ing on the driver's default of one
> is intentional.
driver defaults to 1 when num-cs is not defined in dt so i kept it
optional, but since legacy text binding required it
i will add it to required in v3

Best regards,
Bhargav
