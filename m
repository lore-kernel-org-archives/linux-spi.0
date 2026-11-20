Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795204968;
	b=3TNZC4+fZUxtj+HI4tpyEtzL/Z1LNsoJGNybhxd4+sP2gJiEz+4ROQpNnyf41WLf0KGR
	 m6INb6eJPD3+G8AdaoZTYg0W57rkiMy+Fnwr5YrJoj7yzH+GnDLuuRM3YHYB5SXbow+GQ
	 fRNw1n+zcEjdhyFXRjN9J9VFUnnwJM/6I4FrQuR2Wkm4hgtSnoF7LGdSJetIn82Q+h51V
	 plMsloE/snD61b0qkOzmaadZ85EWCF3fibM3fqkKU7LpYjxPdawN7IEy6lDbw2fz2mh90
	 JYelY2Jtdv7apzVQu5QbP33yeCxTEOo6hLX+fzWHqjyjnnmdj1ppdKRZ19eGEFMufrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4V7U58O8sKkT2FqZynxSVbl9uHZQNKqD+q26N4wEsfM=;
	b=syQCE/u21hTt6uzhpnxdKGNBp+3qwo/DAYVrdTsbwfd9kmEYpiRPyOyCr5v4jmFkttDc
	 p1vdJlKue8OyIC2Lz8HpTT3u2riEkp2EH7LbsJz+K29i3NEBM34YgVIabXreiohpDdNb2
	 FXb1aZMga/EqNsCFABmmU6VW+ZNhEfNh8S7IrH1mIi5rkKK/dXV6K6vYyzN/riI89Vn5V
	 yVE3sILSgSsZEfy12jC4LwZsb9piVgLUMqq+CfMiomcnaYxp4SqJB1pWuT5KHsucOUKIW
	 RBHGLCW1/B5PyZXzujTZTR7BlM60XAF/UAfxF4X+XQJH+7+3llihpFxHA7ujmwADY0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WaMYcHhB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361B1606A6FD
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 20:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 361B1606A6FD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WaMYcHhB
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b335ef6441so9565177b3.3
        for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 12:02:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795204964; cv=none;
        d=google.com; s=arc-20260327;
        b=nyr08W7dCRlJF5J2RDTYpwsLO3NDYvkRuAvA1QS4+xCyJymePx8hCh3qcMfbRS61Ci
         FpJYx7Be82ksB2QN37GxnC2L0IFKMK/kHBf9y6IxYLd0pJGoDZfRF1Nu6C/5Jsogtkz9
         Se3LCTyost0SlXOpzdaymT//P/H0XQCUnIVibhffRakSaRFU9kqqHK5kvPMPGNq3jxA2
         cQ4vJlex2eJ5jcWQyZzTOwUpaxOQo+HiFfZ9UgXr2RpHt915BTspHVIiseIBzFcjZgG0
         sQPXCjWKokda9mCWclK9HEKw0Qi843e4AlByl1PjrlC6PV6IyvV33qiZdatnYfezkOE+
         rndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4V7U58O8sKkT2FqZynxSVbl9uHZQNKqD+q26N4wEsfM=;
        fh=wPgdRFh+w5XGqCJ24Uaxu3HF9IA60q76OHc1QumDJfc=;
        b=a53MJnciPvP6IxuwJZF4PlUgiY2A/uJHK6xJVjq2s+KqzG87IQBfIL3L0XC78yStp9
         /VG+XKv8UKzMka6MM2uPGE6oE1urmhD0458fxjT1xdaIzyggtn13xk2WiuXXipYh/rQK
         ZF40VrlvKVIJ2OdWciWF2WSoyXGxdLYD60q3f4FiCfozBb4YPXvBGEVpn2+ea2tHIup0
         TfNEwXL0+mfkqzJ4oD9Cm9FQJT56TUAOIlJQUmudMzZ9VD7HUc9nHNVGJj+tYkYHRTy0
         qNqpqnFy5XWnYd7mS8adQ/drVnpWzRg/Y0K1toxvlKlDvyZ93mjSZsBP/AmPtkSPEC5h
         8ysw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795204964; x=1795809764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4V7U58O8sKkT2FqZynxSVbl9uHZQNKqD+q26N4wEsfM=;
        b=WaMYcHhBNZ+35v+6wpg2naLtL6eDcZGWsH/op1cQD4c03wrQ8D9MdgfrpovhVdIVdA
         2vQEBszX+L485tw/WsOjNI6nY9CG5gIGG0K7OjZRK2gMC/7bEIPYyrqsu7ZYpm9MYQC0
         3I6OnJRjbJW1M/wIfBUqPj0fZpDXE7cn+bncY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795204964; x=1795809764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4V7U58O8sKkT2FqZynxSVbl9uHZQNKqD+q26N4wEsfM=;
        b=uqpSgXRoSe2YYplfnB+GQUgI+m10jwAGLtAoIKg14mTdTm9TN2Bsx0LNDkQsEx7bp1
         r3MeHCaPtZbgf5cOOqVZirJPbvHbCN3aYWSCvHC13EKFYOUWYmShhMQaZNpMrmdAyC+6
         PmJspFj5wkm8HqyvESpnWLBooF4y3j7Yn7y5H4eo1heNMptPGtshuQGFRHWnG66ylHts
         lVyk3dVDEkLn1i3JzSHC8wQQozzAUz90r8TSgrEAWGY6CLPgHsN54WQOTTGhSngaj1Wp
         s5Xuwp6TYeaUo62o+dkO1yQ7s6vPGEmoEdwTf1LZGucZF81GXLRzSPoK/rPSBMrXjS7C
         0jAg==
X-Forwarded-Encrypted: i=1; AL+hErGWS3pJ89uTJT2yp+C3CYiswshGJYr7JqND+VP2OIp1r1euqh9sKeJIvbADvgmKD4vefhmGCRuGnQQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gdm8Ee8I++nStuXrhhBm4+H1rE/IZiZpYps/3rkkQ6t1GPje+
	++jBuixSES/DEh5cLMEmIcoYa2Phm/TLEqnLJ00LASfCw1d5xArbOfRHT2z2QVdiiVjBOT0zVT9
	oOrWI1/2KG6A4xRmfou6HVXKOiTJUmdFUuo7OKYwIkRdVTG7z7O4=
X-Gm-Gg: AZFdTZfdrHYBJVDK7x+A/DGBMuecStpnELfAcIPO5O0bOm5DYC4V5gq0lrY4SH9GdBH
	8RSQbB7wRu8f5oaks8csZyxKqIwyL/Z4QIyVC3IZr+YjhzKI1Q6eUSAyB8IPZFGTf1ls5aRroX7
	7gtB1cjxBn2I8Bfg3ItTrqjLQO+3W4YzDrSopdpE0umMOb4zU94LNxYm5yDU8AwqC5ErSkJAVMS
	yHSI8oL5Ar2ZIrz2yCzFM9QZvAy03vccp/0qKWaPmHNLyXxwPMiDtLfVf9HxjX7dQ0mizUmTsLv
	sX8y1CsCUZqfxZI/QZPWjpBUq+SJK56/sJlWkZB7d8vhcoyptkLMij3Gzo1+77LT10CEAR/f7yT
	lRq44Zqyd20l2HJS7KP/DpKEh6s8YA2beQyzojMBG8dYPhwK4u2cV8qAWYYD5f5hKilRz
X-Received: by 2002:a05:690e:4008:b0:67d:e36c:6bc8 with SMTP id
 956f58d0204a3-67df44c1825mr1431647d50.146.1795204963908; Fri, 20 Nov 2026
 12:02:43 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
 <20261024-send-upstream-v7-8-abad13174b43@chromium.org> <20261027-silicon-unvented-a0c8dc394e87@spud>
In-Reply-To: <20261027-silicon-unvented-a0c8dc394e87@spud>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 20 Nov 2026 12:02:32 -0800
X-Gm-Features: Aa3M54pc-1DTIKZ-A-hc9wj9AlprRrg4PvxeOwd0_HsaV1fm3yOGyT9vmhS6ZyM
Message-ID: <CAEe3GZF+P2hHHAQO_eWq=yv83HYw9ebEdkO_RZ4zPkQ6e_bAeQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/11] dt-bindings: input: Document hid-over-spi DT schema
To: Conor Dooley <conor@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, tfiga@chromium.org, 
	fqwqf@fqwqf.xyz, daleyo@gmail.com, Dmitry Antipov <dmanti@microsoft.com>, 
	Jarrett Schultz <jaschultz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:17=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Sat, Oct 24, 2026 at 12:51:42AM +0000, Jingyuan Liang wrote:
> > From: Dmitry Antipov <dmanti@microsoft.com>
> >
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> >
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
>
> Personally I prefer how this is done now, but definitely worth those who
> approved the previous iteration taking a look at this because it has
> changed significantly and no longer contains any of the properties that
> cover the timings etc anymore.
>
> Worth noting that this changed since the previous version after I
> pointed out that the second hid-over-spi device did not make use of them
> at all and needed specific handling in the driver.
>
> > ---
> >  .../devicetree/bindings/input/hid-over-spi.yaml    | 75 ++++++++++++++=
++++++++
> >  1 file changed, 75 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml =
b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
>
> Typically this would need to match a compatible, but I think this is okay
> provided other hid-over-spi devices actually get added here - the series
> adding the second hid-over-spi device didn't do so but should be able to
> I think?
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks,
> Conor.
>

Hi Conor,

Thanks for the review and suggestion. The intent is for this to be the
common binding for HID over SPI devices, and I hope more devices
get added here over time.

Thanks,
Jingyuan

> > new file mode 100644
> > index 000000000000..bed0746f004c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HID over SPI Devices
> > +
> > +maintainers:
> > +  - Benjamin Tissoires <bentiss@kernel.org>
> > +  - Jiri Kosina <jikos@kernel.org>
> > +  - Jingyuan Liang <jingyliang@chromium.org>
> > +
> > +description: |+
> > +  HID over SPI provides support for various Human Interface Devices ov=
er the
> > +  SPI bus. These devices can be for example touchpads, keyboards, touc=
h screens
> > +  or sensors.
> > +
> > +  The specification has been written by Microsoft and is currently ava=
ilable
> > +  here: https://www.microsoft.com/en-us/download/details.aspx?id=3D103=
325
> > +
> > +allOf:
> > +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - microsoft,g6-touch-digitizer
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
> > +      GPIO specifier for the device's reset line. The HID over SPI
> > +      specification requires a dedicated, host-driven, active-low rese=
t
> > +      line. The line must be flagged with GPIO_ACTIVE_LOW.
> > +
> > +  vdd-supply:
> > +    description:
> > +      Regulator for the VDD supply voltage.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - reset-gpios
> > +  - vdd-supply
> > +
> > +unevaluatedProperties: false
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
> > +        compatible =3D "microsoft,g6-touch-digitizer";
> > +        reg =3D <0x0>;
> > +        interrupts-extended =3D <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> > +        reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> > +        vdd-supply =3D <&pm8350c_l3>;
> > +        pinctrl-names =3D "default";
> > +        pinctrl-0 =3D <&ts_d6_int_bias>;
> > +      };
> > +    };
> >
> > --
> > 2.56.0.257.gf7497c7d27-goog
> >
