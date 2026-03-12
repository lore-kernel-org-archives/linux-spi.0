Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBB254739
	for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2026 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773277139; cv=pass; b=YXE/yIQPL7hfdwk2rGLIS7QMFJi1AJ4M28ws4Ur9HaNVtEUqRkVJY1ExkPBhIQYHiJhoeTUuhij3VKM9qb2DIrhbRngUPq3OY1TEhdln85As3CMI+ANF/lyq8Ei98mm0i2BQA+08Tfhz7mZDiX2DsKl84y96O3blHSW3ADmUmHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773277139; c=relaxed/simple;
	bh=/U4y6zMTaicCXSRzWDrp1+5aO6aDI934v4bGAGFBGSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FG1pRHup9QoqTwRy2ZYxdLWv2kDbW9LBNBQYVwv1Lh880WWNTSY8OKPOLVhzbmNRIVqzzbItUpMf3CbVSnyGSTPs3KPqB5d3iG81yww+oXJMFy6dlbO+VEFrhf9GzxDbk1twopHyi55xHtbThbwVDLoBI0TnddeAKVdzIqoutrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XSmm664+; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XSmm664+"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64c9f7576d4so447795d50.0
        for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 17:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773277136; cv=none;
        d=google.com; s=arc-20240605;
        b=D7qXMRZRunVqPZFNSQBwTt5AfuAj50ze2LS8N3EsiKTkk0QD67KFilLgKfVvZxl7Vs
         XU9Ha4tHbEzgcUxjCJG1nHsXV8QjHCbVsGJsju46/jAaTPrOpzRS81HqtoTmSXstMk9z
         9hNaOxEjahe7IsZTExpxuwqIJuBxFpEDaDqQGxNIveaYzroKXI3SgB9SdONbHp/98FpY
         fAwqbqOQzoZDvwfTE0/2q/UuLbM/R4g3O55jo0CJAo2F80sVE/enJ2XM6Mdfd372OJNb
         GGwUSyrsWMHuzR/Ag5rBezTDtYv3gm9FOMoGSDcltA5tb9L8PQ86MiYi4gznnjYTItpN
         hhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hm+lu25xFH5D13LzOfbqgKLYsmGame8eJlz+wGxK40k=;
        fh=JgIY8tFXFqvOZaqGqr7uTkTfibikmqxgMUjascg7kTs=;
        b=Eu3zQT8tv1R6xlgDeLt1fNFEma4U2bOdV5GWrxlui44ah46f8k1yTGWHSsTOTdUIMR
         YAVicK4+oPZ24VgPTcU2vD4zXb5ly67s588J3I56MqBWyQB/AzedOteKPQXz8HifNXZG
         75wR4t9rRCegIsPH5ljUcExTanYAQBnQseVAhR2HZX+nITtpWw/wSwKno4AjDAF+9l9X
         SYXFPD2XONJJcARjNPK2y4XbkyIUso8nhNcCDUxxZOH5UmjLRWpQR4t+WE5AXPCXshpC
         en+tsEDGoQAspM5NkrzIpoAJ+AernUFTH1O5WY+MPAIaHocdr5A0tyrfchogNJ5kD4lG
         PcZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773277136; x=1773881936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hm+lu25xFH5D13LzOfbqgKLYsmGame8eJlz+wGxK40k=;
        b=XSmm664+cpfOX++b/WASYI+HDr/mXw8VjWvr3goVQdJDMsHcwWVhGVp3VlY2/EOq/e
         cOCptFmrJaJRPR10fWmyzHERv4q0vwvKrRIGsdPPih2/sO+jNybIXpQmlNawq3p66aNm
         UoIlxrsSumXnUivwq7Cc9bLkwhBiOc7ktlyyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773277136; x=1773881936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hm+lu25xFH5D13LzOfbqgKLYsmGame8eJlz+wGxK40k=;
        b=T4Lru4M4sdXTthHdpjO+VSMWG1e2q+wZ73/5OIueP6PFH/FJa7Yw404BGH7zGPiCLd
         kJ1wNATsUiP76iTng8HFePFcIadwqNKZpVbbErKoGvKNyly4K8tz7o7+ojlu1lGf1vKL
         nspZ2389IgcYO/440EHuqgI0decBo2dKZax3tsvSt5wxnoASJtM5+YxpQUTF2B4q/ETU
         yEUBPI84WmMlWHDDp3BvoQRdLXiKlIhlQ/uTRJkdBWM3hNd8UGUrpKI7CFScAzSdA52P
         6pMmaGNLv2tJ/V09oGv/JvSmRXcQsFKcEo0D0TZIKG//PBnxC3ZZFfbcoQuGpB1YakMb
         H0IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWea51qS2OwevKgMdpB74m5NIhs9pj7+0AO2OJ7UPm7WNjG9aBiAf3IUhpohROaMZ1Ob0PRUbaCD9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ7KrsfTzcoDojnu3hnUJh47KztrRNO2qAFI5jOWpreIsKGlcN
	JZRjFIt5FLzsimSqvnLqDPePMDYd1ssGmK0m0Zor81j1FoMcoGxsxnc+TGjCjoxptU3UjN4lA7o
	/Vn5bsfmjWsAfoVE7mPvvT9KqpOQR1SaFdRXwQio6
X-Gm-Gg: ATEYQzx7GY1iRUWxhpKDYu0BC/3dC0xdBHL/p8e8Xo4NpEKLfcsoJT/NeWjWhYxIfrH
	MwhFIB79PHOW+BKSBztNeCRo7cittNxiDu0GO7T4nwXs1fCK/C/Yl1ze+ImxYJs26TgDLNpNRUS
	eRJ6Ikxm2juaqEdiQxtsmtzMT77zKqxfVZaMA2xkXUTzOVM1qxVue8FeKwYG0DM6WnvTTORlXW3
	We809aLvMeimEu6ndSgGhXjuXNIwK+sYX+xpNcQymyaDhC18dPFvXMy8qjIvijtY8pwJTujokwG
	T9u4tZWqoHMVDWRz6QUtjpxBOU8PmAp6hKtqRo/I
X-Received: by 2002:a53:ee54:0:b0:644:60d9:8648 with SMTP id
 956f58d0204a3-64d6587b0dbmr3375090d50.87.1773277136581; Wed, 11 Mar 2026
 17:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-9-1515ba218f3d@chromium.org> <CAL_JsqKN45FswZjo+27OzoHMeM7ec3hS7piF7SKNykmXNSmA0g@mail.gmail.com>
 <CAEe3GZHSqepvjjopLwrWX3_n4+RnCeVVQnAO=Swixgu2z3OpUw@mail.gmail.com>
In-Reply-To: <CAEe3GZHSqepvjjopLwrWX3_n4+RnCeVVQnAO=Swixgu2z3OpUw@mail.gmail.com>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Wed, 11 Mar 2026 17:58:45 -0700
X-Gm-Features: AaiRm52dLVPqyen2q9prIqB7vkYq8vC1PiQ2eD_fJkVgOSB27JkdvvaCBQOmlW4
Message-ID: <CAEe3GZE_79Lqtzv4ZRi6zWuV_DgkCREBDcZJjpR+X9OaGZCA2g@mail.gmail.com>
Subject: Fwd: [PATCH 09/12] dt-bindings: input: Document hid-over-spi DT schema
To: Rob Herring <robh@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Henry Barnor <hbarnor@chromium.org>, 
	Dmitry Antipov <dmanti@microsoft.com>, Jarrett Schultz <jaschultz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Resending to the list. Apologies, I accidentally dropped the CCs on
my initial reply!)

On Tue, Mar 3, 2026 at 5:53=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Mar 3, 2026 at 12:14=E2=80=AFAM Jingyuan Liang <jingyliang@chromi=
um.org> wrote:
> >
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> >
> > The properties are common to HID over SPI.
> >
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> > ---
> >  .../devicetree/bindings/input/hid-over-spi.yaml    | 153 +++++++++++++=
++++++++
> >  1 file changed, 153 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml =
b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > new file mode 100644
> > index 000000000000..b623629ed9d3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > @@ -0,0 +1,153 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HID over SPI Devices
> > +
> > +maintainers:
> > +  - Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > +  - Jiri Kosina <jkosina@suse.cz>
> > +
> > +description: |+
> > +  HID over SPI provides support for various Human Interface Devices ov=
er the
> > +  SPI bus. These devices can be for example touchpads, keyboards, touc=
h screens
> > +  or sensors.
> > +
> > +  The specification has been written by Microsoft and is currently ava=
ilable here:
> > +  https://www.microsoft.com/en-us/download/details.aspx?id=3D103325
> > +
> > +  If this binding is used, the kernel module spi-hid will handle the c=
ommunication
> > +  with the device and the generic hid core layer will handle the proto=
col.
> > +
> > +allOf:
> > +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - microsoft,g6-touch-digitizer
> > +          - const: hid-over-spi
> > +      - description: Just "hid-over-spi" alone is allowed, but not rec=
ommended.
> > +        const: hid-over-spi
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO specifier for the digitizer's reset pin (active low). The l=
ine must
> > +      be flagged with GPIO_ACTIVE_LOW.
> > +
> > +  vdd-supply:
> > +    description:
> > +      Regulator for the VDD supply voltage.
>
> Is this part of the spec? This won't scale for multiple devices with
> different power rails.

This is not part of the spec but is needed for power management. Is it okay=
 I
mark it as optional? Thank you.

>
> > +
> > +  input-report-header-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 0xffffff
> > +    description:
> > +      A value to be included in the Read Approval packet, listing an a=
ddress of
> > +      the input report header to be put on the SPI bus. This address h=
as 24
> > +      bits.
> > +
> > +  input-report-body-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 0xffffff
> > +    description:
> > +     A value to be included in the Read Approval packet, listing an ad=
dress of
> > +      the input report body to be put on the SPI bus. This address has=
 24 bits.
> > +
> > +  output-report-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 0xffffff
> > +    description:
> > +      A value to be included in the Output Report sent by the host, li=
sting an
> > +      address where the output report on the SPI bus is to be written =
to. This
> > +      address has 24 bits.
> > +
> > +  post-power-on-delay-ms:
> > +    description:
> > +      Optional time in ms required by the device after enabling its re=
gulators
> > +      or powering it on, before it is ready for communication.
>
> Drop. This should be implied by the compatible.

Thank you, I will fix this in v2.

>
> > +
> > +  minimal-reset-delay-ms:
> > +    description:
> > +      Optional minimum amount of time in ms that device needs to be in=
 reset
> > +      state for the reset to take effect.
>
> Drop. This should be implied by the compatible.

I will fix this in v2.

>
> > +
> > +  read-opcode:
> > +  $ref: /schemas/types.yaml#/definitions/uint8
> > +    description:
> > +      Value to be used in Read Approval packets. 1 byte.
> > +
> > +  write-opcode:
> > +  $ref: /schemas/types.yaml#/definitions/uint8
> > +    description:
> > +      Value to be used in Write Approval packets. 1 byte.
>
> Why are these and the address properties above not defined by the
> spec? Do they vary for a specific device? If not, then they should be
> implied by the compatible.

These properties are not defined by the spec:

"The Input Report Address (header or body) and READ opcode are retrieved
from ACPI."

Same for the output report address and write opcode. I will drop these in v=
2.

>
> > +
> > +  hid-over-spi-flags:
> > +  $ref: /schemas/types.yaml#/definitions/uint16
> > +    description:
> > +      16 bits.
> > +      Bits 0-12 - Reserved (must be 0)
> > +      Bit 13 - SPI Write Mode. Possible values -
> > +        * 0b0- Writes are carried out in Single-SPI mode
> > +        * 0b1- Writes are carried out in the Multi-SPI mode specified =
by bits
> > +               14-15
> > +      Bits 14-15 - Multi-SPI Mode. Possible values -
> > +        * 0b00- Single SPI
> > +        * 0b01- Dual SPI
> > +        * 0b10- Quad SPI
>
> We already have SPI properties to define the bus width for read and write=
.

Will fix this in v2.

>
> > +
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - reset-gpios
> > +  - vdd-supply
> > +  - input-report-header-address
> > +  - input-report-body-address
> > +  - output-report-address
> > +  - read-opcode
> > +  - write-opcode
> > +  - hid-over-spi-flags
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    spi {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      hid@0 {
> > +        compatible =3D "hid-over-spi";
> > +        reg =3D <0x0>;
> > +        interrupts-extended =3D <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> > +        reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> > +        vdd-supply =3D <&pm8350c_l3>;
> > +        pinctrl-names =3D "default";
> > +        pinctrl-0 =3D <&ts_d6_reset_assert &ts_d6_int_bias>;
> > +        input-report-header-address =3D <0x1000>;
> > +        input-report-body-address =3D <0x1004>;
> > +        output-report-address =3D <0x2000>;
> > +        read-opcode =3D <0x0b>;
> > +        write-opcode =3D <0x02>;
> > +        hid-over-spi-flags =3D <0x0000>;
> > +        post-power-on-delay-ms =3D <5>;
> > +        minimal-reset-delay-ms =3D <5>;
> > +      };
> > +    };
> > \ No newline at end of file
>
> Fix this.

Will fix this in v2.

>
> Rob
