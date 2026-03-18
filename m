Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929853E5ECA
	for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849801; cv=none; b=cjgfSHZDWASX+eTPcELGmyIFMAx05PpDa91vMVP8ZEvrQOgejm/jJMsKeADlnvwoJmvQeA6G2rgl+FQYdVJvr4/1IZPcdYm4d7gxo03icPiB7xUTEe4iUazt5bbT85L22grfZkN/+nUTz7DjbEUoYWIp3Sg30hU1Ltpn6UG+c9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849801; c=relaxed/simple;
	bh=XVuxTIuxemn5HdUQiQr8DhvvEOWckmMMrPQjvcKJhm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3lC01RlOdakCo3ethgoGV8/ntSPx72ck4SgQ7C5NbimYvjtdxLi6NdaQ00KGGHsyHcOkn9zA0zkRWjTV429XnCdQCiowh10S2bT9TXGoTaMayYLMO1AhRltw3DQqFtNgZC8a5qCWbUCwXylwt3cf6NdZeE9Vdj/U1AA6MfRVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso6669095e0c.3
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 09:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773849795; x=1774454595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uo5OHzsqXu4hR47Gp7Kdyr+G1caq7dBmUC13A5J+n80=;
        b=aLlotGDmdpbnOd+HUqZHam58+H/8M5CjrcBJkBZV8jILETyEwvt9i/yhY5uZUbm54f
         CxYj4SOEIRhWFPcAOEHCqRnHwQBS/4UZaRC9X05uXoWTITRrwlwamDbtwGCV4Es53Ctq
         bY8nzp7ng8M0jxMVAOMhexZRvs5G6YsZ3iG3Y90fXtcwtFmhAGqEG6nZkBx86ZMwij3C
         a0psKk5Vdsr66pTKVwuOBcTdiqCjzr5H2G2FeENL0oCWAveoD0Wwf1ROmuRyQ4mHrzCW
         +tVmeMd0r4cXAsF2gGCMcyuwm2SxOhde/n+zlkWP+1eVb7sMA1Hn5VND58vFWoxjKMJy
         B1Xg==
X-Forwarded-Encrypted: i=1; AJvYcCV5JhoWFhuHXMhPGJL0EbeNmoswPG7yM9n7RIyqN3SNzXkbgi8kM2kOu27SJbiJbamys9maACODLzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQujGTx8aOBe2SJyh3GPNDsAp24gi3tFIHKoBLBm99ctK5uX51
	RH/7Fv5VMxVH/ngzkKqb/NTCww22JAXJ4X01el3iLoxn7N+SRx0/M8pSRWWTmiitz28=
X-Gm-Gg: ATEYQzzyALhhAiajf2lZGTJC6+ztUrlUATRyBH2S8AOAKQ0qSsmQJ9Wsf2LFtVe9dS2
	pyAA5Elx2CDsWsxZBovCLZqPtpzRJL38KsgJ6jPZBt+SDZuKtynnXODLndIdtubo236+k3fhuUJ
	smuhkFRlFCVlt9tjiorjA1A+kREhQkSgk5j87WKi3oJyyzkBMz7EYxX4lOvHMPrIVy4AgosCP7J
	lBKxI7alWGF+UtsW7fyuD08hM2pVjASloBn5UZxa1ZF84UGweihkifiEMIWMzj/HnMaeRqbhOYu
	VFaWoO92fO5NtvtUWNpjTIwuDLhsm8RCh4idU9nUDZ+P2EeaibkSmtro9FeaxUKHSUEo3jeZRYo
	tCEOJ5BEzcbJ9c/8wcDFZyZZHJJlX60Tj9Bsj3FDYPbCkwcWUN756erCKByCg0xnwl8pjpTzisO
	EkHV6drSogGzbbWBb9eVMsl1/Xrvb3K47lFWZPq72y8bLsx7eK5LdUOFsr8jKxLXkM
X-Received: by 2002:a05:6122:2521:b0:563:83b2:ef2d with SMTP id 71dfb90a1353d-56ba71e7eaamr2380261e0c.16.1773849794409;
        Wed, 18 Mar 2026 09:03:14 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56ba705cb2asm2037842e0c.14.2026.03.18.09.03.13
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 09:03:13 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56b1b9899d2so6425683e0c.1
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 09:03:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVF+UC/WJAhg1vt0mmQ/NpDfFhkzAG2FaVX6SbFjald7vr6zqWq9I+Ikx58jDRz9XEqu4Ty9EQzBnw=@vger.kernel.org
X-Received: by 2002:a05:6122:2521:b0:563:83b2:ef2d with SMTP id
 71dfb90a1353d-56ba71e7eaamr2380106e0c.16.1773849792902; Wed, 18 Mar 2026
 09:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771344527.git.tommaso.merciai.xr@bp.renesas.com> <ca59fdcc6c32b8f6659aa9218f1a42d2bcd258c3.1771344527.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <ca59fdcc6c32b8f6659aa9218f1a42d2bcd258c3.1771344527.git.tommaso.merciai.xr@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Mar 2026 17:03:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-DeV5hfQAqK=ChxLATm+S1MjOsObYsssi4JFQmwn5Lw@mail.gmail.com>
X-Gm-Features: AaiRm51eNz-z-fsHN9TtWH7481RQArMChCwXzqF0AFf2HRP5BqKDYm-f9uccbZQ
Message-ID: <CAMuHMdX-DeV5hfQAqK=ChxLATm+S1MjOsObYsssi4JFQmwn5Lw@mail.gmail.com>
Subject: Re: [PATCH 1/5] clk: renesas: r9a09g047: Add entries for the RSPIs
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Feb 2026 at 17:24, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> Add clock and reset entries for the Renesas RZ/G3E RSPI IPs.
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v7.1.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
