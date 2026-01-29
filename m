Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2E280327
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769673901; cv=none; b=qrBhwUnnz04fxTHP5S6SVci96f4VyL4noPjg4PGF62u9lQA9yM/grmuwJvdLbxRxeeVjT6SWrAg11aWgwErql50hnJ1LaMnrWxN3uEaYCaP+xNvlDEWD+caQtj020fb6RJPIr39RQxsbNvF52qrwh9OIJL+jgg7wwz4X9Gy3udE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769673901; c=relaxed/simple;
	bh=91tVL5mKuNj73Dz7moYY7OGxZC1gqClrSFgk0jV0cNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZpb9l6dgrSCXLeUOj70KFLXLU31kIUNHpwkDF55AJEc0BdxZMaiuUSEsjXO1eIcwT/pwaAMexRghMtw40cUO2qkhXvlpx/rWTZ78SpRnX0x533jeCtxcVEGsO0X24cAGnIuI8vYqlgzCFl85eJJSKz2yw2qp8Wt+T1jH2OZhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-563497c549cso360467e0c.3
        for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 00:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769673898; x=1770278698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0gR7dZCHphDKOV6AbU9UOkdND+zeoXCfVO1M2NTZUU=;
        b=vO+eVPVamvn28+REDY857pzmZ9CvCO3QEzHDis+cFJkUTizsnuzfPL3kIqNhMPP78e
         mCHPD52HQqy2e26y2f/KM56O/2nh5VnvP37qsjJBkg+zcOBOrEvTkFz3DzyRTFOD7bcP
         ukyh2ixRQH+ehdsWc+MfvPmqQgXOiyYVV2TleDZEBlFs9kgGUqLm3cQBOOLACPhqtuXI
         Msr70BZNv2wfbdH73imdsJOSr6z8xMVd/OT67h3noZzWkjGJN4VGN/qfLjoWOssEOzpk
         dJr5ltOe34l82aw+tlPd1+hyVuokXGLyZcordz8ioDkbsh9NIcXxI3gfwP/bWF8tjY6g
         b+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDEwLzT6/2ZyM8VGTOct2W6nHejgVwffcEYoNHLLUY36wZCvyEyHZWQLjn5Yk7Spsj41Y+eRo+zqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9vLs5Bph+bhti/p7JvJX+PCQvde+JnX4SKKW0HEmA4Mv4Eu6E
	MnJYPTmHyPgtsACQZdfwuAP6oOR45iVY94BhP2NsvrLMB3MXpfuTFgJ7tel4POUb
X-Gm-Gg: AZuq6aJzUbKxUix5/XYD1imR5xZ3pNFwCo8n8CWjJq1jjett8M9U9zdz2UIQcUU2emS
	N+VkroWgoKDSrMovyEP8JHeLzzAAK+lVRgFv7Hw6QQWJBENlJ/uCH/g0uyaEBCPslleQp+BWfzN
	m5shljfHrk2HhpXiN9pZa/GqT9/EwyC+job5khl4TlNAcdSgh6GVoL2fqDuB8Qr2dfhzuO2SPw0
	zXQuDe8bK/stJVr2Hrpe1X40GgE8x1bMYu8P9zLo7186glXNnKFCI7l3bPHSkaaqnqKAmex40ve
	AkvBX15vziFC7S3cYlZlV7c5DVVeMwd61PUUIQbJo9Nn55Z865ufYQnM9Ru892R6n6oMYTk9oP2
	WpqzPkbr2l5joo1kl3bIuM0hEyLsNDxN+vd8k5nzFoLDPwQZnsKIqaVHwUqSzHUEUehVGsRJ9cJ
	nEwevZWOPl7dlneVLImGWg5eXv0cPI3C83NvWIVCDxtW+ahbJ6J742
X-Received: by 2002:a05:6122:506:b0:566:2741:2e5f with SMTP id 71dfb90a1353d-566794aa60emr3288098e0c.3.1769673898115;
        Thu, 29 Jan 2026 00:04:58 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685d07b42sm1087168e0c.18.2026.01.29.00.04.57
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 00:04:57 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-566360cab02so476024e0c.2
        for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 00:04:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtZIbZxXKEAW7ejRfLG7HxGpywyu4LVd8909pTtPP9ayxMRoh7LIaFp2PTlMOULvi88hwqqzht3bw=@vger.kernel.org
X-Received: by 2002:a05:6102:54a6:b0:5df:b7f3:5875 with SMTP id
 ada2fe7eead31-5f7236eb1d3mr2932320137.3.1769673897247; Thu, 29 Jan 2026
 00:04:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127201706.616374-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260127201706.616374-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260128-sequence-platypus-59ae3318318a@spud> <TYRPR01MB15619DCD987445778003A81588591A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <20260128-debatable-scribe-4e55c208b31a@spud>
In-Reply-To: <20260128-debatable-scribe-4e55c208b31a@spud>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Jan 2026 09:04:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWYKFoBnGaCfvVJFwYXEvtVyxXiAzHC2JvmTCwc5H91wQ@mail.gmail.com>
X-Gm-Features: AZwV_QjTTisPi414sjhCr82V_-8ygcgoSAfE-Ll893eiMx8FQNA9_dDyqKpLyMg
Message-ID: <CAMuHMdWYKFoBnGaCfvVJFwYXEvtVyxXiAzHC2JvmTCwc5H91wQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: renesas,rzv2h-rspi: allow
 multiple DMAs
To: Conor Dooley <conor@kernel.org>
Cc: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Conor,

On Wed, 28 Jan 2026 at 21:09, Conor Dooley <conor@kernel.org> wrote:
> On Wed, Jan 28, 2026 at 06:51:48PM +0000, Cosmin-Gabriel Tanislav wrote:
> > > From: Conor Dooley <conor@kernel.org>

> > > On Tue, Jan 27, 2026 at 10:17:04PM +0200, Cosmin Tanislav wrote:
> > > > The Renesas RZ/T2H and RZ/N2H SoCs have multiple DMA controllers that
> > > > can be used with the RSPI peripheral. The current bindings only allow a
> > > > single pair of RX and TX DMAs.
> > > >
> > > > Allow multiple DMAs by only restricting the possible names of the DMA
> > > > channels.
> > >
> > > > All '.*-names$' properties must conform to the string-array.yaml
> > > > meta-schema, which requires both minItems and maxItems properties to be
> > > > present before the items can be a schema. Otherwise, the items need to
> > > > be an array.
> > >
> > > Why is this in the commit message?
> >
> > To provide a context for the maxItems that are needed below, even if
> > there's not really a maximum. Which is why having a maxItems does not
> > really make sense but it is expected by the meta-schema so we can
> > constrain the names of the DMA channels.
> >
> > dtschema/meta-schemas/string-array.yaml:
> >
> > if:
> >   not:
> >     required:
> >       - minItems
> >       - maxItems
> > then:
> >   properties:
> >     items:
> >       type: array
>
> Right. You can probably remove all that since I'm asking you to add
> actual constraints to the property.
>
> > > > Declare a generous maxItems of 32, which should be enough for 16 DMA
> > > > controllers, so that we don't have to update this value ever again, even
> > > > if currently the maximum number of DMA controllers on a Renesas SoC is
> > > > 5.
> > >
> > > Huh, No. The binding should constrain this to fit what the actual
> > > devices do.

The device is the SPI controller, or the SoC where the SPI controller
is integrated?

> >
> > Should the binding for SPI be updated if a device ever comes up with
> > 6 DMA controllers? It seems a bit unrelated to me. In this case, should
> > we constrain the number of dmas and dma-names per SoC? Some may have 2
> > DMA controllers, while others may have 5. Please let me know your
> > thoughts, taking into account that I only added maxItems to satisfy the
> > meta-schema.
>
> Yes, I think you should constrain it to the correct number of providers
> for each device.
> Whether that's done or not, there's not all that much reason to set it
> above whatever the current maximum is, since the binding will have to be
> updated to add the compatible for whatever device exceeds the current max
> and the limit can be increased then.

The actual maximum number of dmas pairs does not depend on the SPI
controller, but on the SoC integration.  I think the (single) DMA
request signal from the SPI controller is just wired to all DMACs
present (on this SoC, IIRC there were some Renesas SoCs where some
 DMA clients are wired to only a single DMAC).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
