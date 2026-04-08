Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE03A3812
	for <linux-spi@vger.kernel.org>; Wed,  8 Apr 2026 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636895; cv=none; b=TQYYQrhVQ2hnkyXmZ/PNPRRMGUQOXBYJvXOrNHKtquuzEXJqQfa1JZieNzdIPJBIIxKxnaA2LGGrgE5T96B8KA4bPLct5/LivHJMfMnDi/taknkaRQUYpjg7PXqkc0ZFxd63WFwacys2PUE1JaSKDq194Mvof/fk0GCAlAg/jFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636895; c=relaxed/simple;
	bh=o9aFN/oBxjJk7ilLKE+iObF5zpOesxCwPJ4VHcL/xkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hktm8rODx95R9WGHVRP6F0zcq6yKDthAb5BC9Md2ODfub/Azm0ad1USRXdKqK2mOGuuE8krHSzvZxHQubzRpiuZ+/dpNSV1/ni13kkTAH6RS/uL1qC2pkn6ppkbgcORAwCJKqD1nnoDK4syTc6k5G4yqfTP83BCxvHoeRckbBTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94dcf70af41so1456341241.1
        for <linux-spi@vger.kernel.org>; Wed, 08 Apr 2026 01:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775636893; x=1776241693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQpQOf4fWDiiKTZ8RNLIoiaoYNDkkDqXEA0sfJBBI8c=;
        b=cA5dJcdmzVpcdtXNZ7DMJIlktCFmLR9kNSfjOg5Plm6PoHW9y+avzPJ+6NMpgVNVfp
         2aS0TIFwEdspuaK7UllbZIyGo00DGgEInrLLsln7XvwBHa2jiY2sX7au8Oz+PTGh+X2f
         I8vCdLW02eyFkClBWQGfGjm85VTy92W8LF/t6llxFr4a0NoOJGCQT3I2ANt58xSKJPTb
         zopIRL51bGC3yMfcT0L4/FJOts/S9lrLuiI4XSMyOJDBhSD9q5QV4t5TVWyp5MoGlQAz
         LCBLZtvY/TXfuulRC1zREan6eOfensvYw35LqT+WvRUKBMs81zZ+YabQJmP63yNQI+hZ
         tktQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMCSQ7yTdE7d5ehvNA4ksPWElUmYzfZ+2NhFQEmkrIBdpu3isD0PfMOftpg6gmEm8AiZYyf1iVy5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0CbnlGND8FCxGkYwmljJ0Gng7WRzUKuzBmoPLlJ99M3sN4NSy
	D4lW3seDfDfNO6Op8yaNfIkc04qVnWGmQLsTmEhDYdm5z47OAVTC8mfgREcimeqT
X-Gm-Gg: AeBDiesqlZ0ADYTtzOsdLCO2Dxv3XssxJDctthRv0vfmy+XY2zaYO3oJsro+Qz3oWXY
	o5GPhdwn4aoxr9GKvBF/yBBK8ov/QrF3Ed8pdumi6XNKMw827/axiREsTSVnB45yYrr2k+JDlZ7
	nwCirXhpD5hNSD/fHYZ/yLmsimf3OlPgZFCw5kWLyZQoSG4B0Asv6T0uGII/cP8LG/C37ut31KS
	OFN7uWFAHX1ZgmMNo7hG0shfy5618Set+YcZH755PSxrJ/gLZjiuTLdlQ34tOI21vTFblgwEmNr
	0GtzQuEUX5hsz1UN50OIVSGWI6UtJSPXZCPpoohg00SQaKc9n4Q9KgN1lyEHgGTEsAiSZd6VeRT
	qwMyHgz80Y8UpmWDVjpqg02NdVipiy/AUA7jk8OV6l9qLWa4LLxdx5Q62ZM0f8OKmtw/mhFTBDf
	lNN3XZoccaVPmhGjYMQFCogMv8djHSVqT9DZwpy5ffDC2U4FHPBfOEO6fpATxa
X-Received: by 2002:a05:6102:f89:b0:5ff:c5c8:2734 with SMTP id ada2fe7eead31-605a5021387mr7120576137.25.1775636893397;
        Wed, 08 Apr 2026 01:28:13 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6074fe8cbbasm1372377137.8.2026.04.08.01.28.12
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 01:28:12 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-6055a0414d7so1905829137.2
        for <linux-spi@vger.kernel.org>; Wed, 08 Apr 2026 01:28:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3ev3C0ETY3UhLVEDUbIrolKkzl//OVuo+qO1w8NnMKZ9hFkEr0yrNA5xxpxiQYodDaSozM+brq/g=@vger.kernel.org
X-Received: by 2002:a05:6102:2923:b0:602:8ccb:c993 with SMTP id
 ada2fe7eead31-605a5013b05mr6453381137.24.1775636891875; Wed, 08 Apr 2026
 01:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407145753.101840-1-biju.das.jz@bp.renesas.com> <20260407145753.101840-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260407145753.101840-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 10:28:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVHWxmY7fCue2Q+4Wvf2QbB2ABaQL2yi1Z9koov7tj6Zg@mail.gmail.com>
X-Gm-Features: AQROBzA34NCraYwlgtVmX6Zb7nvooLN9XjKRAeqpyWsi4l4Jb7X8ZFeX4g2U_rk
Message-ID: <CAMuHMdVHWxmY7fCue2Q+4Wvf2QbB2ABaQL2yi1Z9koov7tj6Zg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: renesas,rzv2h-rspi: Document
 RZ/G3L SoC
To: Biju <biju.das.au@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Apr 2026 at 16:57, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Document RSPI IP found on the RZ/G3L SoC. The RSPI IP is compatible with
> the RZ/V2H RSPI IP, but has 2 clocks compared to 3 on RZ/V2H.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Added ordered DMA names for the dma-names property.
>  * Dropped the tag
> v1->v2:
>  * Collected tag

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
