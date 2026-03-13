Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F503093B2
	for <linux-spi@vger.kernel.org>; Fri, 13 Mar 2026 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773363644; cv=pass; b=fkcMZrgRWLpJXulpSOXinU+nhQwAuXkZ3MX3GzCsLCQjONcA2PS9tBI1EG8I1+om2BbWFxIIEkmyO/HDVlNR5rFs5CTLEZa+0STqIr15MHy9v48vyg3OXQPZ6ztxnE+uKh6EV9VK3+wtsr02I65NcFb6bAQIiBsGU1LVyhRNxLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773363644; c=relaxed/simple;
	bh=sWXbHUNWyCssRT+Z0j94kKl4zmDZN0doACSqgWVnHEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAHvSHLOyZs008CnvU3zPnDxGUmSJIOnNmjpF4t8X59DQSK4arvfymOBa1kBMTSa19oeDWSyo2JBvlhiLA6DFG+asYQHmsHdhxpFjdPGKlYriOwngQ6z/zna7IH0irksRZmNVhxhY4ssgbh4wBvcWJDqyG49x9z+n7B2ZFFjM7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZA/lz0jz; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZA/lz0jz"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64937edbc9eso1740188d50.2
        for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2026 18:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773363641; cv=none;
        d=google.com; s=arc-20240605;
        b=du4DBV+lPPkd1rXd+6ZlzhUIyCDMvmqq7mULWcsTIMGUhAIfBvqpP4wCqmir+2wnv9
         WreVu1+dODkkG9tyVj5aIjBACJTt38XaAKB5m5qLNimq7uAKaq0b7XjPpBz0XeQA2s19
         aPd2xamuA5ThgMeIQciK3L+BIWdhTaZEyWIVbubfB88CcZMf6bdveQ1YGaWN67wTzwVE
         gLJ3nPP4scIu44WvZzUbBe6kfh6YXhc2YU7fM0WHBf1LZ0WySVVO73kxTHpLYx3ZICBm
         ranIJlTWFSqY47tRNsHYK2fXogvNJxCa2cuQ1hvclaGXhc+0wSwtsdlKOs+AQ0u7YHrx
         76Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WEIoHUDBRKW7sPjWtgozpXFsqYAeqWilfaHlivAXGTA=;
        fh=k3zrtz42OVslb+2KCx/l0TER2rflS8OfKu1AdnqdPCA=;
        b=hKHLD4Z7JobvNJMMGyUpNJVuH1RUtou+wpqHTUTdD4Q3EvuhYE5nStFVxlvih8VGuy
         SGCTk6gGZ4hqCc0UWKY0paLyE6WDXhh6Hy2W/YeyqsHAjT4BOftse09LrXLXhNXtIdyb
         MK2zUbqZkldV2BGW5fQ32QkoD2NkKP9SFBVySI/+pKBWY2LM+g1vow89g+/sT0MkR7cA
         fvu8EETAf22jwT81KBgnxDGF8lRnNyzB7jpF1jtMpZkeDcVsoyZD6Rlr/EoAYkLbdY7P
         hBDnSzvd18rc0ov2bLzRWvmgeg8cK5Z6U9AdP4Jv0ZpOLPO14LniYumKFmgmkscbwC4U
         Yz/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773363641; x=1773968441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEIoHUDBRKW7sPjWtgozpXFsqYAeqWilfaHlivAXGTA=;
        b=ZA/lz0jzZ5SnEt27k5mt290nazi42vhGGnOyNcbDIrJk0WzjSHSUXA0OXFphwHSWli
         WNhDUXBka7oi/+/SldIRtUuf1Po9CwQ6Y0+CSBiC/7rRru2Mvrwgy2C7Lvu84y8UZU3c
         nmLVa2qKS2YKHBiYT/MZ/bSmE8EFdQz3BwQto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773363641; x=1773968441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WEIoHUDBRKW7sPjWtgozpXFsqYAeqWilfaHlivAXGTA=;
        b=VZhcSkT8f0//UDjCh8Dtr+mQQdiLw7W9MXFpIdWgieFYlTQ5F4NujU02SJu5wDQMqg
         1rp5yZeHqtKMGplk9skASNXt+dka8DO8w/LaHPQnfEo1iqeIzfeVppDTAmZWI+6mMTLy
         PFwrVkFjJr7AXVQPL7vQXNw+a8pAGFvxXJTjhieJkgVQi9CiibfBIGlrUBqc2oODIVrr
         Ny1//u9FdGxLNJDdXqFs4Z8hhsamOlsf5wrRp8CM3VUxOnIW+Xg8NBTaRL5holr6EbZl
         Wcm4LSDC4wHTh05nDAUUbVnRTw5bRuOXkQOKfAtUJCkvKYYZDGgVyzzxRf7vDFCyClI9
         YXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7SNd0v6SI+nKenVakXRzIIJO2vKohcuRoJ7Toqf4BZ3JqoGCzlX2LJGdIZb+7KrUCgbIXrf0JLWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/OZW/xKqxKs9CPekuw1Rdf4b3U4nLPEACOhTOS1ZHUv4sWE0u
	RAH8Iw5T2iA2A1xrevF46UHxvWAyfDEouu88FejaDRe1NhDYcJiLu/YEeKvkMage0K7qT6xAkCe
	uulR6vX9ppDEYofI9VnO3V+VmstQzYEOqvYhUZeZ8
X-Gm-Gg: ATEYQzxifKVErS/F4y/RXcHGW5ulJYRASdRp9TQAd8L6V8cJDwFNA4nI/4RPl4tUUCv
	0Wj3Blq20ygjzsZoPdXqZ+5MFiZ/rVz/RbUeDwl2PLxFsDIZBnlRNsH4IRsHdyHAqAgR01/PMdd
	XvqA05dfJnm6ROmqV+qtsSRgDNsGxNbUI/l/yawaBA3nzqanoWSRGrtcn6QeJCRqU1dzLMJDoxk
	wJw/kHpSp0t0ZYCqHnP/7WfINJlEq4WWUAAg+8H3/uJARXXT6vlpWhru3IpWghNft6ychjZvWbl
	2VamL/yRl2NAUFcj16FrDJFagESU0Ibgx+A56haB
X-Received: by 2002:a05:690e:23c6:b0:64c:a815:511b with SMTP id
 956f58d0204a3-64e62f59679mr1215624d50.3.1773363641056; Thu, 12 Mar 2026
 18:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-9-1515ba218f3d@chromium.org> <1cc6de61-8b56-492e-ab78-e3aa448f58ad@packett.cool>
In-Reply-To: <1cc6de61-8b56-492e-ab78-e3aa448f58ad@packett.cool>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 12 Mar 2026 18:00:30 -0700
X-Gm-Features: AaiRm529-VNRFl8j9TL1yc6G4h205p6aiqQ4Ar4V5wWtWy0meX15btognc57fcQ
Message-ID: <CAEe3GZF7ct1ZFH2Zd6AJnO1vBJQZobGaQKO+hTMJjFcCQddq6Q@mail.gmail.com>
Subject: Re: [PATCH 09/12] dt-bindings: input: Document hid-over-spi DT schema
To: Val Packett <val@packett.cool>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, 
	Dmitry Antipov <dmanti@microsoft.com>, Jarrett Schultz <jaschultz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 11:25=E2=80=AFPM Val Packett <val@packett.cool> wrot=
e:
>
>
> On 3/3/26 3:13 AM, Jingyuan Liang wrote:
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> > [=E2=80=A6]
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - microsoft,g6-touch-digitizer
> > +          - const: hid-over-spi
> > +      - description: Just "hid-over-spi" alone is allowed, but not rec=
ommended.
> > [=E2=80=A6]
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - reset-gpios
>
> Why is reset required? Is it so implausible on some device implementing
> the spec there wouldn't be a reset gpio?
>
> > +  - vdd-supply
> Linux makes up a dummy regulator if DT doesn't provide one, so can
> regulators even be required?
> > [=E2=80=A6]
> > +        compatible =3D "hid-over-spi";
> Not following your own recommendation from above :)

Thanks! I will fix this in v2.

> > +        reg =3D <0x0>;
> > +        interrupts-extended =3D <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> > +        reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> > +        vdd-supply =3D <&pm8350c_l3>;
> > +        pinctrl-names =3D "default";
> > +        pinctrl-0 =3D <&ts_d6_reset_assert &ts_d6_int_bias>;
>
> Heh, "reset_assert" is a name implying it would actually set the value
> from the pinctrl properties, which is what had to be done before
> reset-gpios were supported. But now reset-gpios are supported.

Taken from the original patch. Will fix this in v2.

>
>
> Thanks,
> ~val
>
>
> P.S. happy to see work on this happen again!
>
