Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E523E330
	for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535304; cv=none; b=Opy/EwDOhbt4g+Y0exBWGZJ7AXSs5wY+ZurdtL8cfTc/MDK+XJat5EUylJfwKESHVmHvjRYm8hglAQbAwsgvTUQsdnC/3ZEMos/HIXai33FRxrIJ7ViDGIxtr9C1V+wM+o4ac9+nEzddWYSSZMcjv7dN/34l8bj3Dv0dwfqfXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535304; c=relaxed/simple;
	bh=Qu3UrdHfRGUo+IQpch7jHWfBEGOhd/gFnZp38a4AiS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMDDDhtGcvb7r4fdrkqbitBtwE9nw3ZIDAblSHf+sc3puyS9E2hl8pc+pdvZgBDEBf3tY/EhIebNpL17KIbh2roHIzgzdrk5teyJQKzN0H9egJRHPzheQTdcAR1noe5hXz4dysTXKT6/95tQxhjEvNLQ4Io+NnCLm21HcpE1RvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56a9c5cb48bso495516e0c.0
        for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 07:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774535302; x=1775140102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx17fbCum0HxJGLiZIM7+APW+qVuJWwyHiukjhC23hI=;
        b=PTFAXAHP+2+srtjUEBfJww+ojKUJpsYfQIZwX9hP8YVIUfkmsn8B5Asq0JNxB6WQmh
         S8FB4Yi3Ls+A60AitC0upnSfDy505AKicTxaV15mPoyxikqKTH9jIb1LHUhp18nNFO9Q
         HZARM/Q/+zfnMr2TGjCJ6sbI09RC/DKe3CJYf5LG+P/JojnImfgDhjyEI1UjUCikwzma
         IG7u7mGzFZ9VbAsHNLx8OXBr21JRP0tGMujIBWlJ0Y0xCWjt+/+NwfPKVqf3ZL+YqGdQ
         vtcPOvW8D4HVrAz5tWa6pzpcY07wcEx+KZ4vrtgFujieDr/5XhKeK1/YjZnuxS+9YzKm
         y8Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVXsgHCL3M5EZ+mH2M3nQU7iHYShcORgegiv2COFtiGJvMGZtyHzChr2EHw6MyAbcUqDToZjGdSPtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyETYIwe1z4cPsB5UC6sz3c+33x66smCl02IbA30E17reeiMZF1
	3zG/Cr30WG7RAgubkqdu3PDKguRCZlPjHmJtla0ZR0A58w8ayflHjhZ4xx0jD7ZzW2w=
X-Gm-Gg: ATEYQzxkYXWGGV1tdlXopCG/RvSi93kTm39Wn7C5tljuAuveP4nCIRDslKM8nJn9WlA
	NkShJ5rtI/J5+ODk/sSCX0LDVnC6Cg0Trn71N61uKi9GVB+cDvHP+/mQtBoY5d6SBFaZD0FnnpN
	rm8qf39Fe3vd6OWyAl/a+d/U1IKdm5VO5e+GktwPYpO06LPky8R5qcbxBV4CCk7oFsUoDqkoy7s
	kxLNl36cscetl8YC0OJuYJvfaav7lVTkxWg5F4ALNpM+PX4vUpE8Ht/0HJDU6S7SlliR1cxDU6W
	mScdBz8IC9R/3syxZhgpCAVi0giQnCOwUHMBs6zsFvP/gG7u1WGaHRN2IMPN2W9nA5CCh5RnK+e
	Gl+3++AUBoSJkLLZ7tLUi10ogEFN9RTGm5tUNWuw5s1S0LYIUjPjtL/q8XC1t8i5s5eVDWjjfGl
	KKMUHLFfAHsHinG3QAXmGVOy4YxzQ0130AKc+iMog7MZPt7gP9VZBshS/3bPwpD2Hn5ICbQ4m6n
	Ts=
X-Received: by 2002:a05:6102:3ca1:b0:602:8b67:37db with SMTP id ada2fe7eead31-60387316808mr3168694137.26.1774535301975;
        Thu, 26 Mar 2026 07:28:21 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-604d50c928asm3266357137.5.2026.03.26.07.28.21
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 07:28:21 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56d3fa1ea69so150815e0c.3
        for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 07:28:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlu9AkZ6BVU6/i21yPhW9k9BAiA3QqFGcHugj+VokbgE2L/l2vWM2J6VRpe2TPmtSZLKFRL3wq0Hk=@vger.kernel.org
X-Received: by 2002:a05:6122:62f2:b0:56b:7a5b:3cee with SMTP id
 71dfb90a1353d-56d220699d4mr3816280e0c.12.1774535300726; Thu, 26 Mar 2026
 07:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074907.9697-1-biju.das.jz@bp.renesas.com> <20260304074907.9697-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260304074907.9697-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Mar 2026 15:28:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWQOQwZ9qgVaqWNrhA2mVe-5s5QcmJHD10QheSOcOn7qQ@mail.gmail.com>
X-Gm-Features: AQROBzAhM3AW6MrbB4cFj6sp3RlNTps86eZahrOvjSYvBr_GjZzQv99EoywigDk
Message-ID: <CAMuHMdWQOQwZ9qgVaqWNrhA2mVe-5s5QcmJHD10QheSOcOn7qQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/G3L SoC
To: Biju <biju.das.au@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 08:49, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Document RSPI IP found on the RZ/G3L SoC. The RSPI IP is compatible with
> the RZ/V2H RSPI IP, but has 2 clocks compared to 3 on RZ/V2H.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
