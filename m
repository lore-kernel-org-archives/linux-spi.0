Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8291E44DB6D
	for <linux-spi@vger.kernel.org>; Tue, 30 Jun 2026 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834074; cv=none; b=rpcARnbhl3mcO/KGGqKCv+T3Q5O+1alnLTH4R8t4ooZYOgn1SDzi9a/tdUzdLZinXxJKvpHmln1WFjaqrVbB4HqL1tqyrJ4IVozQcpEMjcpjz95AMaeImAnvqGIB0IuBZWzVPHJd+Hc31qpNWLdWv34pqcIe/SnQyXwN5miwzxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834074; c=relaxed/simple;
	bh=HECdCdoiVcKsHL9ieEZjduz0kz0EHHXfKnn7LggCP2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNoAD3becFnKNHaq/r3+tVMeyLidrNX8qBfVN7NM//WIzJJP1z6FrHKruiUbzHJAU3+/mgbnQes413Z2YBJ9mtHq2JebKciyjx3wgFXunSsfUJKET13b8ndhezLM3EjWasA1VKONp8AcajRh7A2GTMItNo8Nfeogv5OPapljgo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-969524c1a63so1177734241.0
        for <linux-spi@vger.kernel.org>; Tue, 30 Jun 2026 08:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834072; x=1783438872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FudzaGflml93J0qLROb0/HyeenVr7sqBJ6ASEnUvtg=;
        b=ODu5ilaEduJrDZcWpO0p8yjEx2heiTHzSe9d2c93GLiZ9IrFlahUba4QGOmh3MBzCv
         OHREpqjLEnPZqUuaWxfiPhjTcsvgy0Fm+90IZF+rh3aOTTH7Jd7j59KRlfAFJJvNnHd8
         3Slq/uDNZx3fNTkJRPksSsXj7i/E1qHaTUCkoBmbC40xnqpOXOMKCJSGpzD2jCtJJDNl
         M+XzyR3HzHVRaF+kMHZPIoUKLWUlUDxEXoHJK55phOZUfwXXBxcXf3gqhB5onDa6NAs9
         PCz2iKq0dzb6c4paOvqcTb+fTt5kNB+b/CkazEgtHcq9lhGmdAuaYa3gg5IFadwBlHdy
         xskQ==
X-Forwarded-Encrypted: i=1; AHgh+RrR7Gk9xcXytXZbR5aQs+iF0H6BAimIPnyKaaFLzWC5zKu+yCBwdWUDkryfnxmNG2LQ4LwhuCrHOEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1p3FlLRrMNncWlAXo2lWDTYH5VV+TM0Zri5cQuuExIP+tizP5
	poifI2UYTXHYB9U7fNgIoJpjZDF43AmWfsqz7lwfgRhVAskVe8SWirDjHaiYfXeoB0k=
X-Gm-Gg: AfdE7clVEprFZ9yO5up0ELo+Tj3D+Z/kAAwL4VLKiEdfJsYYEurpSY7UTVGC2vPsrwn
	y6RTtgVgG98YczKooBVOT0N6BE/AkDWU1P/vRt9Z1df5AodLi/FALgMJfYSh0ThvMev91WE7utQ
	ufNq56OQ2v9aEcs+DsSe8ZtD8dp6YNK7GToGYLlztcQP0+aQyYw955KGNj1NEE8lojnKmdsMeBG
	CW4JYVb+Ca+ZMIygUefLgbTAG7ua8jVP1H5vJTfvM+9O6kiHh1rnjJh3Lb6sSKy9+8hQa+foQZv
	WUcB9uBtu/YmtKrr2Dr4uMGPuGjgFZfJFX+y++goxmP+ehYeMOrL46UoGWtR3+H0m6YGjlgU2hO
	aaUqAtuhPa3gLYx9YCxuaerG4qKZAlsMOF2JK1CUdpWzYbNyit8qNTZ2bjM2u3RlH8VtfMtVvlA
	rsVunusaWgzKUR6nxx/wYyq835vMM0XP8NuWIC+GTS7RynBtMjZg==
X-Received: by 2002:a05:6102:41a0:b0:6c1:85f8:29b3 with SMTP id ada2fe7eead31-73a365e0415mr2271741137.6.1782834072418;
        Tue, 30 Jun 2026 08:41:12 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-73a821a6b8csm1305728137.5.2026.06.30.08.41.12
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 08:41:12 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-735f73287e2so2568950137.2
        for <linux-spi@vger.kernel.org>; Tue, 30 Jun 2026 08:41:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpr2wzkb0xFBOfsbaSQJ4k4W0FftjOcVLXGEEHNgcAQ32SAVyO33JW2vGeoJRmXfGfYixUl6OOA8Ak=@vger.kernel.org
X-Received: by 2002:a05:6102:598c:b0:737:5c42:858b with SMTP id
 ada2fe7eead31-73a36aee835mr2136553137.11.1782834071816; Tue, 30 Jun 2026
 08:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626180326.9593-1-wsa+renesas@sang-engineering.com> <20260626180326.9593-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260626180326.9593-3-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jun 2026 17:41:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUi74DDa_xoJ8Lo=eV54w4q9Jhu-1N02vUkNGCKgEywow@mail.gmail.com>
X-Gm-Features: AVVi8CcUvJP0aecjrianzUPa4AqYvcUMhpUwuDQPV--pueaST2jff09tZFzGmBc
Message-ID: <CAMuHMdUi74DDa_xoJ8Lo=eV54w4q9Jhu-1N02vUkNGCKgEywow@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] spi: dt-bindings: snps,dw-apb-ssi: add
 'power-domains' property
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Herve Codina <herve.codina@bootlin.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Sat, 27 Jun 2026 at 11:20, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> This SPI controller likely belongs to a power domain for all the SoCs
> listed. For sure, it belongs to one on the Renesas RZ/N1 SoC, so
> enable the property to be able to describe its power domain in DTs.
>
> Suggested-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> ---
>
> Change since v3:
> * reworded commit message to make clear other SoCs likely use a
>   power-domain, too (Krzysztof)
> * change Reported-by to Suggested-by (Krzysztof)
> * add Rev-by (Herve)

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -87,6 +87,9 @@ properties:
>        - const: ssi_clk
>        - const: pclk
>
> +  power-domains:
> +    maxItems: 1
> +
>    resets:
>      maxItems: 1
>

RZ/N1 definitely needs a power-domains property, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
I don't know about the others, they don't seem to have it in their DTS.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
