Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE43D5670
	for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851103; cv=none; b=aeOQPWlIfHzbNJzbC0ksa9uJfrr8LjeBMZCpsuBdU7iC9ZiRINczIugCwvyltRISYK3EBRZPqMO3Q05MgS82TT0Qm4L3IZfUlaInqrTScYkD93wPW5QvU3dPurmyJiwX2tiPCgswpXiwswekRoj4KplRrpWOEdofrvn2CRa1YXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851103; c=relaxed/simple;
	bh=J9AoQJqhss2LsfIv36b73QdQdOLW9HvVXjRl/JvP07g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0QDmcrAiJwmlrKQMLhOCLrEIVaeMMxr6TA13pFtVlFTSZecn7TeI6G0VVm5sGCR3pOkC6KXbu3aTSB4Tyfk2mPdQxqC/RzcBUJBSe7/5T+PUtKDXn2JYQhoOF0KVLeRZSjAMNc18ykrTuFBqrNrQ4wLu7RDTMmrEyLW5a2hsQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94aca174532so1630047241.3
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 09:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851099; x=1774455899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyAgld3HIOm1wYub494sLGOg4YlSEABoZlx1Bb+ypLQ=;
        b=itI5fS/GL+8Tkklk7Kr9l7PnxcRhQhzGh67dU2m4N7GXdqxg2PHemYJMhXFEyhusnE
         2wRRY5bi6k96gV/aTq/iDag+mulwm4odVFmLL/8/jSHvh5Zd0VzEG4lZEI+Z01hWDdjw
         nSqBagvsbgaLIhnZecn1GyziBgDAwIDoMqsa8gs6wEFufSLE/4KfTBPzsA8G8yunK4N/
         HWQYG68JHttBHqErO/NmfAUMYRAD4PsvBQtjdeVR1qonEx2YaNwOP3SJHNuqSq/3a4Bs
         DjIGDfpwux2+tQCOqy/DzgsRNGz9VDafp+43IEvj4pXcRFO2Oj31a6TpvOrL39Wx6aFZ
         JLDw==
X-Forwarded-Encrypted: i=1; AJvYcCVCWMlhcEvWCc7KW2M+9jld+wWqLOM26H+BnqjaeLVSKX4Voo5yK9djZeZyIimCmhX+a2KZt6gnPKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7H6FPnSEe7KSLfukMhsjBQLJz+oPB60XCwkwIkm6o8mvkf96f
	33+LSWrxQ6rUbREA6EpgRryOv7CQDJZ7k7gWc/DkmWjWa/wxTk0nbNqbgtlw0xahZEg=
X-Gm-Gg: ATEYQzxUPFwLmiGJDk6AQAjvRnPuAJyev9uumJoGGHLotZoeyryd0FRg++O2jV7KpbL
	8XJ7vzmHlOZR4cr+4JCxooRIBqhg6QZqbNPtHkcLnFa3McIT4cOjJ7h2o0pmeTpOmx2cHPbNW3Q
	2CXb7wUDoQU5DH6SPzBcHsXbauwnDIOPb9uYOcyYL1KTl20ey7a/l5MX5zNXQ5YR6lWwtiI5/9L
	H2z0DBHd7nTU1sNVf08aEVZlavKS6qbUBR71BGSdvR2GSDxas/1Y4QCqUxuYfUvBEtzUcl9c9Wh
	diz4j9X3hnFAPJ1AFN+i416vr6QQs7UKrKbXCBTtJwN+fZQ1goD5EGaPgd2CtsuLsGm+i/WKO5V
	zSmUiGYZTG+3QrhzAjA8AVxnTDZrKQb5GCsJKI2D/SsC5ueiU+upzAHbx0+q6EImORMK0welRqY
	TDJmsOhCnvaOkmZ7nMwCcot66kHfBd89Cioirg9qIsqvq6f7X7SgLKb/KIX2tr
X-Received: by 2002:a05:6102:a4b:b0:5ff:ea33:2be with SMTP id ada2fe7eead31-6027d320cc8mr1527067137.19.1773851099077;
        Wed, 18 Mar 2026 09:24:59 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6027ee242b4sm1618877137.10.2026.03.18.09.24.58
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 09:24:58 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5fff77ff69bso9965137.2
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 09:24:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU48fxBzbXwUTA5SD2p1O6R7h049DGJKwp6T/WoHhzqELgupi94pgVo16FGguQf2CKk3TAE674CYto=@vger.kernel.org
X-Received: by 2002:a05:6102:374a:b0:5f5:4055:4558 with SMTP id
 ada2fe7eead31-6027d0b9ec5mr1976763137.2.1773851098056; Wed, 18 Mar 2026
 09:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771344527.git.tommaso.merciai.xr@bp.renesas.com> <f6b43f0dc64e13b1c9942c164dea30002d4c4466.1771344527.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <f6b43f0dc64e13b1c9942c164dea30002d4c4466.1771344527.git.tommaso.merciai.xr@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Mar 2026 17:24:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW+d8_SCBtRH3St2SBWKND1Q=vtcK48C6i9PyQZbjs9Zg@mail.gmail.com>
X-Gm-Features: AaiRm50_PfHsI_l0RjZzNnYxExZrNf0xwI7nlPt_QmbbgWorEasSrObC0tCBcTk
Message-ID: <CAMuHMdW+d8_SCBtRH3St2SBWKND1Q=vtcK48C6i9PyQZbjs9Zg@mail.gmail.com>
Subject: Re: [PATCH 3/5] spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3E
 SoC support
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Feb 2026 at 17:25, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> Document the RSPI controller on the Renesas RZ/G3E SoC. The block is
> compatible with the RSPI implementation found on the RZ/V2H(P) family.
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
>  - This patch depend up on [0]
>  - [0] https://lore.kernel.org/all/20260128215132.1353381-2-cosmin-gabriel.tanislav.xa@renesas.com/

The dependency is now in spi/for-next.
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
