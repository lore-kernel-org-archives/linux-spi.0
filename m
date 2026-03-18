Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBFD3B3BFB
	for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850484; cv=none; b=DIIHSTu/uomnXBCEBg696YmEQ3nTm3uwvzPavaMjT7HF4WAYKr12CtaCiCOB9NAXS/dOwbe2R94KlMfnM7i8mcxaVLpJ4pVHFSD1ra15Az9pU2KkHIM8zMdaP9hcqAu4YFfauJ5jKnG7nNkYkPGg0w8IXw/uHjPRv5J0rbXvvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850484; c=relaxed/simple;
	bh=61LThXM6TkHf22dtxLqfIwd9R5jJPl9iMytA9rm+YuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xf0gE+4zLCpxXTHuDPdBQQ/lYVfPyFpsErrpt6+C0kOxQ/AwEFmnPS3VTXuz82zEkiocxByIW5y8f1Z1R3IRcdjbi6pCTI62pJPY5jBXcOcVI3XPNbLfivIX/8rBuGKu0BCWLUuTnJunSkk1lEASrE+LRF2U/YQF4lLSPOpYL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94ac8cbf3feso3733590241.0
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 09:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773850477; x=1774455277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQg3ZojwgSHDqijm0VNHDAW00kkVZrPeOY6PyIIDxp4=;
        b=adHglzw1mG+M8DjxsUK3folM7kC2I/HcUMt0MlhKlugZGsSHle9AYih72loUCEQHV/
         G1L9fsQspdmHZBabrsasRaCzb7uxtU5KgRGBDaGTFqw/ZRclDLrsGuB8YKVQUOul4A5X
         1a1Mq7epyPfhJZK9sIAi1Ze1Px2p8cdEn8xWuEEZw0QsxGbP9JAdoGPQAjint2tFpS9Z
         SB+p8BWrse8BkeMFprHcJB7uG9b1F/DnNC1gqR6dtzMMYBRH3VQDTGnky/5cUSQ35XUT
         MYS3cC9XEjXWgcCYNpXMPn7lZ7Um35eMbRwTvzFjEAEbwGrDAEl8T4pG+ifwoNiD15s9
         +PWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIpl3PTbrjlwop21OSvnodb8VtcU5L/j2iLY/XEUH42ecaaEpgdiyIvhcbO+XX4DbpdMXTFlojsTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw75p6Eco0ycTjEdltjHyL6qcuvMVg1Z9Ct67p791TmIrN6Gw43
	GzyCR4OZTbwpe+XIwoZiKaKynqL89WssuGuqauZUeHn5Dp4c2lnqaxbRoyJX9+HO82c=
X-Gm-Gg: ATEYQzx9fY5NhhgqeU6NtzwZ6zSKGbdgI1zbSTWrRg4OV8vJybDpskWmWt0RC/5wLBF
	4koBPQDKJen2X7FTOmYBkMXJ3pp5Fo1wniaeNGAvixA8IFYzBqLyUG2/lsKOYPsIEj5X4QgDrur
	dpZvl6Oc1auym3cXuCs17qY4gVhzMOqK2ddMYvG84lLxAcwtpMYcEKPQc1HN6G0nwDt87PtZlRq
	auJRNhdcCCqO/2+Tse4u0Uqx7nU6g/oC04qWvOSQ6pDuT4UJY8UKmmrBqfWxWikQXXqwR00fCuC
	S1/EE7tCG3eVh4EmKPwAaTJOSBvcvDNoqQaf9rikGeMnHScqzTy5x2Mf9cDQPl/GI01rnfWBydB
	jXaAq9D6wt9IcYpCgLhenU/k1lHcdu94JjOMLDxTm6gjHRZqEqc2zxffuBE3YS1iU8iGFn2Q3sU
	Z8f1ipTVugG0fB9+WRk7C8BSeKv3RcEBH9iq5MYajP9GP+PqtUdcovoSMnRomv
X-Received: by 2002:a05:6102:441c:b0:5ff:a34:6ce8 with SMTP id ada2fe7eead31-6027d2b6f08mr1909531137.20.1773850476848;
        Wed, 18 Mar 2026 09:14:36 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9510325cfafsm1543241241.2.2026.03.18.09.14.36
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 09:14:36 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5ffca37e8cdso9020137.2
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 09:14:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+cysir5z5eUKp62fenh3MjhnxcF6YKsIo2hEdWbjUKaf0dYt+OI977slqVRvOxAZ4l2frU9FOUQk=@vger.kernel.org
X-Received: by 2002:a05:6102:3596:b0:602:7a74:fbcc with SMTP id
 ada2fe7eead31-6027d12667emr2198273137.15.1773850475876; Wed, 18 Mar 2026
 09:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128215132.1353381-1-cosmin-gabriel.tanislav.xa@renesas.com> <20260128215132.1353381-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260128215132.1353381-2-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Mar 2026 17:14:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVF9=CVokdAoAKxr6QcEoftqTv8GcUTd2y2NhMcBWRFmA@mail.gmail.com>
X-Gm-Features: AaiRm53rX4HCYWST9itRTskWWhbI-bKvKrF3W9m6D7fYdmf48lf66Cz3h9Y7xcM
Message-ID: <CAMuHMdVF9=CVokdAoAKxr6QcEoftqTv8GcUTd2y2NhMcBWRFmA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: renesas,rzv2h-rspi: allow
 multiple DMAs
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jan 2026 at 22:52, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> All supported SoCs have multiple DMA controllers that can be used with
> the RSPI peripheral. The current bindings only allow a single pair of RX
> and TX DMAs.
>
> The DMA core allows specifying multiple DMAs with the same name, and it
> will pick the first available one.
>
> There is an exception in the base dt-schema rules specifically for
> allowing this behavior (dtschema/schemas/dma/dma.yaml).
>
> dma-names:
>   anyOf:
>     - uniqueItems: true
>     - items:
>         # Hack around Renesas bindings which repeat entries to support
>         # multiple possible DMA providers
>         enum: [rx, tx]
>
> Allow multiple DMAs to have the same name and only restrict the possible
> names of the DMA channels, not their count.
>
> For RZ/T2H and RZ/N2H SoCs, limit the number of DMA channels to 6, as
> they have 3 DMA controllers.
>
> For RZ/V2H and RZ/V2N SoCs, limit the number of DMA channels to 10, as
> they have 5 DMA controllers.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>
> V3:
>  * impose proper maxItems for each device
>  * impose maxItems for dmas property

FTR
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
