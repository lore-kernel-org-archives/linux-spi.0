Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C908428843
	for <linux-spi@vger.kernel.org>; Fri, 27 Feb 2026 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204153; cv=none; b=R45tHwnSt33HYF/E585MDx68iB8Bfv7SITpJYGUIaNSyHM9bIPc+1jVQ5ojVlNG8b/rD73GUPXVYk735PB0IVJDZb1K1+KEgM7e3Z/tp8b1e3F8DAuYXc7gJdeqWybPnGIPpBi7f1ffFnXni7FsNUwfhsLWBMHuk0XmgcIKLblo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204153; c=relaxed/simple;
	bh=lToFBo+bQaCa9neG/vLe3MHGOkvyleQBs1IqzhcHe1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bv4STwmmY8kiJadzTtMFrTgIFI7QIiv4ODFE9qlDFzF2/7+wa/T+z5zspDS1Idmc38iPv09+RGBaL0SxRhy0z2RIEMf3pi4Y9Cj9zoE+7PozKsv0seBkDBQys2mMCE47bUgLGNIzyudkICHj3NpL2v4HincRGaNf+EJrqzLev7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5674cd243d9so2433731e0c.0
        for <linux-spi@vger.kernel.org>; Fri, 27 Feb 2026 06:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772204151; x=1772808951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUkkEiUGXuiXLmzIVFfuNzK2FaXQ+t2b+WPGwELOFZU=;
        b=QDNkz5rq+/F+Ol27xdIe/hv1Fy1yolQnKaty+t9gfKc6bAjrnvX7Gqaq5PCjLqb5oU
         Y3wRTYLvNebVedkn8GMEhXe8WaZQKktJFVtXstfE8vItyMtMfe8uTbEVvpRDQ11MO9M9
         HS1hP2xp3979wlToj8fyHgYMDOTVRMpnq3h1y31q6Vfh0gBeb1inOGQGsbvk9f492/pR
         sHuqPuUZxb8Ol1qarxsd4FLBBBSUDUQzJFHhGrwLxeCkuS6qcXuaJmY3pGmX1nFTA9f+
         U/zXHP43zJFGdJu1UbVfitewl5J/EGXma9RruLQ0oG2NDmgM7b1kO8oRcTBSnplWEabS
         htFg==
X-Forwarded-Encrypted: i=1; AJvYcCVObnheZ9aE4AFQCHJi6lUJaBXcJK963/KQJgELbaDIWaaDE3Hbpapg1GxwhcPYzS6Jg+5L7a+7Om8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz53hBAHlYS7FhH0fWBiJQWClRRubZK3KCOB7H1P1GQZ9npd012
	DOn8Cye4cZZ/Jvd/xvZ1pdBtH2s8hNbC7wAHqAYR9Xv76MjKndZGm8PlnGLn1YLdFXg=
X-Gm-Gg: ATEYQzxoEBAQcQ7r41wWMeVoBEP8MRmNJA8HFf7fCvRKCiexx43JVZ4W0WVuYkUlRBY
	pK6FTYnB95a54WaOjfSH/fGdDMmZ3TyErdSle++/l/NIE4swnMue8V1jEYP+HRm9MzHXFPVX60G
	G9xKOmKwsul0Luxtg+UuhyWpeQHTfxADklGKENDOJz/ZmdydRMqUBk9bsQ5RhDp4K4bXWl7ehVe
	2j7R/jbGBxuvv9yfTbvzG63HjfU8JjFlYu0ERd6lsv3pN+yEsGG8pXdzmTRLAGZEjSvFt4PAFUo
	8/ZGjZTVKqcA1re1rl3rxBDWD9ErvcY7dsZXeFGfecdqos79vEdLL7T8d9B3SQkkWk7Fg78gvni
	mspAX9W4nZE5TK+0OQLjrzG62fAfa7oYIikXtsHnLahCaQpgtCXhC4612Zo+xI8SsjEqZSwfMoD
	BNGbjlufym26SL50vQpwH+TuQ5uBcZeKysrPTkLSrfHJQLucePTS3aNe+eMK7p
X-Received: by 2002:a05:6122:4688:b0:566:ec03:4683 with SMTP id 71dfb90a1353d-56aa0e7b0eamr1689459e0c.2.1772204151314;
        Fri, 27 Feb 2026 06:55:51 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a92175e87sm6413258e0c.15.2026.02.27.06.55.50
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 06:55:51 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5fdf71f3327so2212150137.1
        for <linux-spi@vger.kernel.org>; Fri, 27 Feb 2026 06:55:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXr944V280il9geK8IiPLq7CgC8ZhLoJxHR99ZYW2bsGFN1Zvxb/7RWN9hREjepObdjoCO75sZgUHg=@vger.kernel.org
X-Received: by 2002:a05:6102:f06:b0:5ff:1734:4ae7 with SMTP id
 ada2fe7eead31-5ff1cffe701mr3749937137.20.1772204150707; Fri, 27 Feb 2026
 06:55:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128215132.1353381-1-cosmin-gabriel.tanislav.xa@renesas.com> <20260128215132.1353381-4-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260128215132.1353381-4-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Feb 2026 15:55:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWJh8y5zXUMtWcmYaEND=PXZUFa01xCVpKt_0X4BdztcA@mail.gmail.com>
X-Gm-Features: AaiRm53Ttbxl3AS1ZsDflKNTMNk92JmxxoblMh4cAxRt1__H5obq1pnJAwopKd8
Message-ID: <CAMuHMdWJh8y5zXUMtWcmYaEND=PXZUFa01xCVpKt_0X4BdztcA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: renesas: r9a09g087: wire up DMA
 support for SPI
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jan 2026 at 22:52, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> RZ/N2H (R9A09G087) has three DMA controllers that can be used by
> peripherals like SPI to offload data transfers from the CPU.
>
> Wire up the DMA channels for the SPI peripherals.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, will queue in renesas-devel for v7.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
