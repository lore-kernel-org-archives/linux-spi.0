Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792790984;
	b=1iFPlaq6d9xVi3YzlptUGdh1OyxIwYVNgAommjWHxZNINmWmSFfC6PRym2oD6oQEkkEM
	 UV0A9OPXwJNO1rXd7Ax0PXM7WkX4cR1kX2KOjg6clBwTpX/55GU4+h4+3YVGw2FQwvAyV
	 qJ5H/WQQqkC1B9jdtxDbYTWJuy1D5g0gJYh1Sx+EA/A0JLOY4TuDtyy2JA/4BWw80N/5T
	 IoVEQYqvTqAmHMAOathNS/My3xXG9GxoX+n5Mvmmw5s5LdNnyI95oMWCb1XzSx5+x4enE
	 BlDp4ESUhS+Sc0LS9L87sRVZuOgkSlblrMHsRx2IuUIrcu89dn5Ek1/Zm+RZz1twp4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tUl6eNqYTZcDOJocOSUOl6ratLkDYu9rB2KUNaQCwrg=;
	b=i04qiMdTawK0a4IE8ZK/VpsK9F2Dd4K7n41lfRCrx2JCOnslCUc4gvKcrKpNYsW7F+zF
	 TIe7nkvfPXcyB9RrqkYX0c5CiWCDBv7hDsW8hnHnp7TeLOzNxMq62Uz+3NK1Df+Ej9hC/
	 yeDL+59Loj7FU3qwjDiZbfyvUH5Um4ISTf+Bgmi7vZrqtey/NTjiBIbQkfS/09XihWVZ9
	 ODGrmvCL1gjR8HNYmGhCGfjKzCMRgCkJ1mcrOpq5oViBdWzX0VCcvxR8jblmF6QuavkEa
	 i9LxvIoIUxviilajE3vFwXMye8OjmuWmreXI8RrXee0d/cda+eGuc84/wJrm/rX7jlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bfcjC1d1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4175606A31F
	for <linux-spi@vger.kernel.org>; Fri, 23 Oct 2026 21:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4175606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bfcjC1d1
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8a83d2706fdso12145047b3.0
        for <linux-spi@vger.kernel.org>; Fri, 23 Oct 2026 14:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792790983; cv=none;
        d=google.com; s=arc-20260327;
        b=pD+ih3DLpY7L94/zJtADRBaUFSwPwK3OC9PH2KYcD7fvXO8QyCi+bA0Ye5Dwe13+cu
         rIpf+dit3ia1WeVIxecTwpw3Ndc1WGi9Di6KbRxXyHUlsSPqIaOQEAF3qrFdr0aEEgBl
         ihRYH/qePXG2JGDrOvH389Z17qWYk2nIp7LqMV0n7qu5MqvDWWe8FdScb96K1t6Urt+L
         KRsMisdRCIloj7HdkEYX9+nkjYAlJjHtDMQSaRr8dl/EeHk7nOlPQOiPs7oyhMf0iZYe
         t4LQZfbim4vXEJfWygBbTwRvvs+IkU2DHR8PMMZEnXnqu935EUrFfnzDRE2v0FT0vnCG
         pcUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tUl6eNqYTZcDOJocOSUOl6ratLkDYu9rB2KUNaQCwrg=;
        fh=oLEdg7F1gVdb7JG1QIpv+e2fLE+dBro8sDmUGR0qm6Q=;
        b=V5OlRHE4/UQ7lcZZL9ql0pwrr8hiM6FrsLZiojc9T+QVc7hFftCsAwXe2CKd3B8Ere
         4ntXj8NHGC0MV9d9Wa6qq6ffO63N8ohCt6ChsjKrf5faYfs7KwNF80KQDjSVMbp5v48z
         yDVlbpfYK7K1+H+gSo7pjDP2vx4wt2zldiiYouvkHUKCfyFT3r7ahG8Yw3O0kqXjSMH4
         0DQYB/IdQa9xBvLA9xS9qUXBEe2j7LDin23WJ6tO/Y0f8I+SC5A+uHj+2zxII9o5Toih
         lJmATlU8RvO90aj+S8YfAn90yCTMY7p1sxka805DxVNZGawn/Cli8NfhHhY4w7stjAGt
         lKbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792790983; x=1793395783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tUl6eNqYTZcDOJocOSUOl6ratLkDYu9rB2KUNaQCwrg=;
        b=bfcjC1d1vWOT1pE9X7gNabyHtF99QX5dSLBV1xVK5YhE+PCKgQcMtacFiknvczljas
         pSbRQQ9f00apAwLTNHlvUICLRGZIUiHLO8ZQWR+ht4d+xEi4Ee1BfJDsQU16ahnkS88G
         uC4l5/cmHNgM95Gpkf2IrZNxEA2vsG73DTUts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790983; x=1793395783;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tUl6eNqYTZcDOJocOSUOl6ratLkDYu9rB2KUNaQCwrg=;
        b=K94dTNFRKufLRRmVart0wGwDamtnLHFXB/e0WCdj/s0pbAxtamCzJd1/p3OYMSQ7wp
         fMeDfYWCil83tjtFdrVMKuy5ql6MziXaMQnkpP8ZDfluwBdmi9cUMAL/X/8gXCF/omvr
         PLaD01gl5ZJGMaN34gfnncAlC7rSLM5QMMCCpBHwo/8oP5TWEBLCPAWtg7zqFCEYth1y
         iQ9cVBGIogjAvz7YXK3xBKmB/Eo0uG5ny0IWNqmd+rRal4Znjew4Y2RZAE2pr37ac2Nr
         7FV8fvh2slkwYg5NzKy8eUGlhacJullZBUjg9rvCBi23rqVR87cbxExcovWmtJqfnYP6
         gkDA==
X-Forwarded-Encrypted: i=1; AKwUvBwOf8MBKXQ/h9oUQXAbzDzLHQ5Li618gtX3IgVWr7dEMTb0yssCbam12h+uKAQ4l0cayazfDAOvPVs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5SPsmS6YHeJ3Egva8AtdwsmJP/Q1g3lHoUru0rIZye74dHC6r
	6vUNiHmwmTd/rK+dVpmci10edx7wqq7Ts1hy6zORoBe0M+1+rtEO3+egfMP/PwFxtyPTyCe6bmM
	BjzQAZw9ZH1Wl4okslbIgjX8LxXYOsaC1+TD4uZdR
X-Gm-Gg: AYBFou2Al2M1cq13QOsh58+l5OHrVpx/pPJE4d+WvAs9LxgZxWSfLpcEFTGPgTUXKyB
	q3/+W1UNYnrGgoqkTZU4LtuUKRgthKYsKI/LU6xNkLNbCD2NVH5lK/rnNC0AIXT7MIgoYrEpudh
	HsRNV3Qp5eUcEZglyLIrnaOubPGlknFDjU9Pad4uqwQlAbRcbM/prlxJjPgZPNtLntb/pzLrfHK
	mGvowAyOkPshKN2dPur1g0ztSZZLh3BvzV1beVdA5SzUhiAUf75gKp9hbdnkutM5OGojTkVRlot
	2I5HmxkQjKUK9TrNPdznpyEbyWKbD+guxVTHYEDFunD9Pq5O6PRVMeFG6ojOdcOtjnfi3f4AA43
	NeXSmxIuTii1HNaUwIo0HCANf/J4ChHtLBBO51R/nsqrardmR62j5DoLNALbW9P3c3Q==
X-Received: by 2002:a05:690c:6113:b0:8b0:9e11:b636 with SMTP id
 00721157ae682-8b166c28a62mr2850907b3.62.1792790982824; Fri, 23 Oct 2026
 14:29:42 -0700 (PDT)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
 <20261019-send-upstream-v6-8-cb9ba4b3d6fa@chromium.org> <20261020-breach-aim-4a497c0089e6@spud>
In-Reply-To: <20261020-breach-aim-4a497c0089e6@spud>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 23 Oct 2026 14:29:31 -0700
X-Gm-Features: AclHuK_rDtmewSuhFWuooVP3bMSAuGCimyDmFSMqJ4WysgkfaBZ_lCNbaUs0JsA
Message-ID: <CAEe3GZHKKXTMGKTNKK2VxWJucCdTM1cTEQ1MWeN+CYzdkYb8xA@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] dt-bindings: input: Document hid-over-spi DT schema
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

On Tue, Oct 20, 2026 at 10:57=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Mon, Oct 19, 2026 at 07:01:20PM +0000, Jingyuan Liang wrote:
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> >
> > The properties are common to HID over SPI.
> >
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
>
> Signoff chain is not right, since the nominal patch author is the last
> signoff.

Thanks! Will fix this in v7.

>
> > ---
> >  .../devicetree/bindings/input/hid-over-spi.yaml    | 130 +++++++++++++=
++++++++
> >  1 file changed, 130 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml =
b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > new file mode 100644
> > index 000000000000..2a5fa0868a09
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > @@ -0,0 +1,130 @@
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
> > +  The HID over SPI specification does not define fixed values for the
> > +  read/write opcodes and the input/output report addresses. The host
> > +  retrieves them from platform firmware (ACPI _DSM), and they differ
> > +  between devices. These properties provide the same values on Device
> > +  Tree systems, so devices that fully comply with the specification wo=
rk
> > +  with the "hid-over-spi" fallback compatible.
> > +
> > +allOf:
> > +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - microsoft,g6-touch-digitizer
> > +      - const: hid-over-spi
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
> > +      A value to be included in the Read Approval packet, listing an a=
ddress of
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
> > +  read-opcode:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    description:
> > +      Value to be used in Read Approval packets. 1 byte.
> > +
> > +  write-opcode:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    description:
> > +      Value to be used in Output Report packets. 1 byte.
>
> I still dunno why any of these properties exist, especially when there's
> a patch in my queue for another microsoft touch device on top of
> this series that does not use any of them.
>
> The commit message really needs to explain why these exist and why
> compatibles cannot be used to determine these things - as is done for
> the microsoft,romulus13-touchpad. If the very next device that appears
> seems to require a specific compatible and cannot use these properties
> to get across what's needed to the kernel it calls into question why
> the binding is designed like this.
>
> pw-bot: changes-requested
>
> Thanks,
> Conor.

Will drop these properties in v7.

Rob, since the binding changes, I'll drop your Reviewed-by from v7.

>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - reset-gpios
> > +  - vdd-supply
> > +  - input-report-header-address
> > +  - input-report-body-address
> > +  - output-report-address
> > +  - read-opcode
> > +  - write-opcode
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
> > +        compatible =3D "microsoft,g6-touch-digitizer", "hid-over-spi";
> > +        reg =3D <0x0>;
> > +        interrupts-extended =3D <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> > +        reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> > +        vdd-supply =3D <&pm8350c_l3>;
> > +        pinctrl-names =3D "default";
> > +        pinctrl-0 =3D <&ts_d6_int_bias>;
> > +        input-report-header-address =3D <0x1000>;
> > +        input-report-body-address =3D <0x1004>;
> > +        output-report-address =3D <0x2000>;
> > +        read-opcode =3D /bits/ 8 <0x0b>;
> > +        write-opcode =3D /bits/ 8 <0x02>;
> > +      };
> > +    };
> >
> > --
> > 2.56.0.212.g129ede20d9-goog
> >
