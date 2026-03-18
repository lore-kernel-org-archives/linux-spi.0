Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA7D38736D
	for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823322; cv=none; b=ZJFCdDXT6Ag43/CqOh47JxMxflb0cfl+rg7ctj428jTup0/SS2WlsZveoXJSCFsmB3X3OSLUOGoJgsfxYWLKpcBe2IjsT7iCSQBCpvlTiCxFJEDi1qcz77w2CpHcyUVNKz1oIXBYhEXF2NCqM0aEiHFhEKpQshx7tvZOyif3Qjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823322; c=relaxed/simple;
	bh=1Q3Co6bxbshrYxrPl4jn/U2T1xBX3gjFWpDnRI8lYDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYUvHe82m11BrMe+N9Q6CUZDBEDA7ubOiZTDYHd7NSu+4EEuZc7MU5rso4KPr9wmvISIHmKIYdi0HwOidbUNe74mBReBA3tYoWDa7bgFwRkfijPhmovs1mLb7zQ3lOzmM862erErTgthFmx0rAnFl95bxptS0OmUpqSFBr0nj3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56b7043c97eso1328073e0c.1
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 01:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773823317; x=1774428117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqPUDw6RZ7tI/8SbuWaBeZ31o+A7cvn/glmx6dclWwI=;
        b=hOR4a42q09HJoG1DjbWGMXzvCYqEwaF6PGhV0gCoJJBGOMen9nAjcOBK3mvjtXxGqG
         nSvrp7fMuoWqbsbg4RGD4MAgp57Srl4JelTbPIhDaGeePkFADXB07i3nBd32PGMfg6jO
         Z72uecTUWLF55pwjz5dz1lrbrfjG8L0WzWLiR1ZxbHyvEoeCw2KTQYhg26jGH4hhEUcO
         /8K2L6kC8i+hLYKnLJy/LWyHY+rws1LJm87fVG7VxzrsoFmYi1PX59FmzuxsC6NaExiY
         haCFa4SWv3/uF2ImlwrLY35YlV3Hzze3YOTuyGk7Op17j/R2xkcl1pO9DOhSvGd+LPOl
         xtrg==
X-Forwarded-Encrypted: i=1; AJvYcCU5eYgALeo1mKI5jmBZHqlKbKan5qLVB5xR2+q0dcdcpproGaKYEqIp1Kpom31phUl7ewNCpnKD/O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyawkGHgmjcYlUQIn7H5IBDLrLTT/Cs/RLEc8MxlRJLUB45AaIT
	K1ngVwsUORBWB76t37gCpKvwd7CHlCFu9c6uuNnl0weqgzGCWv2O3RHu9iyqQiuMZgU=
X-Gm-Gg: ATEYQzyVgMb9MYINWJiYDMEAbqPKsaK4QgSFRc+1X8IDL+b2KZ/9XA1osio9Xpe7mQB
	btTguoihn2dNG5C2WvcLnW2PBPc5ybpGAh5IntMw4V7YkjbvMfVBfAFRbUdxLNY/GXkqfhvH3iT
	rzHu2/Dc7R3KiO37xC/T1vy3B/nCgk84oNyyf+HNhm2dwAT7A6UZh/Tmn0mdse8GTYs7qEWY+b2
	UXtattENM5goRT9GtMN+Bio5zzlS1ERPLVNOoche2j0bfsJ3DlkWX12Mmvm3gRv7/w+rX3Q3sCb
	A/BuSxliG23ae5DG/2SElQsOpaIG6GMySfJ5KAmGvK3jJcdp3z8hswrIQsdhY/7GTGNnRsZP6Qr
	TiyBGR6zgzuG5K0SZSBi7m7TyVOekIGFy875tYu8yhdQFUGlHGkudC+h1GNQUkzeQQx2hpwJDfY
	8PAju0o7Q3RiYX2WNgNHQkzzYkEQIeeHL+UOAiY/lbXRYqp1MmFSoKLf6JPWU3
X-Received: by 2002:a05:6102:5494:b0:5ff:2569:cfe7 with SMTP id ada2fe7eead31-6027d122a75mr1076040137.10.1773823317225;
        Wed, 18 Mar 2026 01:41:57 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6027ebf93fesm1050457137.5.2026.03.18.01.41.55
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 01:41:56 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94aca174532so1496716241.3
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 01:41:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7YthUE6ar1yPm53ufNogCl5/bph/kiMyBNcQpmk/5klHRNCKtp4AJSo+xsI6YfP7cmtr5jPrSUHY=@vger.kernel.org
X-Received: by 2002:a05:6102:5087:b0:5ff:e39d:9f9b with SMTP id
 ada2fe7eead31-6027d159e7fmr1126209137.16.1773823315107; Wed, 18 Mar 2026
 01:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <abkCPU3rxHI49N4_@shikoro> <abkD-VLprcbbEbB1@ashevche-desk.local>
In-Reply-To: <abkD-VLprcbbEbB1@ashevche-desk.local>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Mar 2026 09:41:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVX4tfko8iv-EdwO-bBcwCd+cPkb9aP8qJbcM1F4zdz4g@mail.gmail.com>
X-Gm-Features: AaiRm52_MgNfiAr79FL-62Ac0xXnTx-AfzVYThIE_IN0tF6AadQcPRzCkdJNUOc
Message-ID: <CAMuHMdVX4tfko8iv-EdwO-bBcwCd+cPkb9aP8qJbcM1F4zdz4g@mail.gmail.com>
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Douglas Anderson <dianders@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	devicetree@vger.kernel.org, driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Tue, 17 Mar 2026 at 08:34, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Mar 17, 2026 at 08:26:53AM +0100, Wolfram Sang wrote:
>
> ...
>
> > Thanks for tackling this issue! I agree it should be fixed, just
> > wondered about one thing:
> >
> > > While flags are often modified while under the "fwnode_link_lock",
> > > this is not universally true.
> >
> > Is it a possibility to use the lock in all code paths instead?
> > Because...
> >
> > >     struct list_head consumers;
> > > -   u8 flags;
> > > +   unsigned long flags;
> >
> > ... this change costs some memory on every system. Maybe it can be
> > avoided?
>
> How much memory does it cost? On most 64-bit architectures is +4 bytes,
> rarely +0 bytes, on m68k it might be +2bytes. On 32-bit it most likely
> +0 bytes. I expect that 64-bit machines will cope with this bump.

On all architectures with natural alignment of pointers and longs,
it won't cost a thing: struct list_head contains pointers, so the
struct must be padded to a multiple of 4 or 8 bytes anyway.
On m68k[*],  it will cost 2 bytes, as the existing padding is just a
single byte.

[*] Iff m68k ever switches to 32-bit alignment, there won't be an
    additional cost due to the change of flags here, but of course
    there would be a cost all over the place.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
