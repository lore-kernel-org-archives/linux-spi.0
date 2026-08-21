Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C6C3B995D
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307429; cv=none; b=caxnNW5I3DLuSNBcy6kcXvxowP8/3TUgbNOC50uqsVIR+zFSL6LqFdT/OYCdiQW/micQtjkPLpTQ6jFRfaHIEeSWmkc29vAIkBqNK+hPoGKInpPP1GzFaEI+1p1a9XjMzp+w+C+3hxgtJuihG+WckszFuIZyef2m3b8CZsAqDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307429; c=relaxed/simple;
	bh=TajKrkP7iAilCm/Wf9qOw7yL7OS5AMPI8Bf5cDTLAK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=u0p7Y8dRmKH/BGNZ8Ggn5us3DZ6ApGGy7NVv6UBsdp3ECw4HYmVA0yxmQv8fD9p6/shJEjuvmJ4Mr05lTJQGyHe/66wy/8VdLjEPQmbDfrF1WGYtgAu5C7wxDAHfSKGwHH0GzBPzgOE+iBADSsHQVVqCVjLcFLveddI9EMxLBHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7475a4f8b05so437610137.1
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 03:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787307417; x=1787912217;
        h=content-type:cc:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NZ9qFWwtyy0CyLFBazZArycje1mFKlJigB1GC39CAP0=;
        b=Darl3F8E1ECSyVd4Ir2SU2ddoYOgXctWB3pD3eexcB14ZC8XVeuanPAhPCYgXnaxRC
         qrwJPIJqD9KuCDAhHUOnnkz3m1Vd3bAUG37Y0YgoExtUT1oan71aQ9H+XacJxtSLHGlY
         UarRx/UVFoqc7V/CpIEu6+s/uNvjTjpKY0yELaByxb9qx7z/uZ9Q5bCYqPBXsIS1sJED
         GohmT6YvvgiOwAOaFmWxKa9GmDFqck7McpKk70G6tLwW1G5N9gXaYG0qHDH1oncU4DFo
         BiTQBBvdSLKkPWLvuUJTb4mHmQMmwxa3AKf9OZtn3rZrARO+7VNH+MBAVglYcGyZx39S
         BR3Q==
X-Forwarded-Encrypted: i=1; AHgh+RoxhCTjridUfNehwwMzcb6Ye93mxBIsCOkGLBS7bcCNJGHM3p9dJScgLRm+8klZvw0L96/uNKr9+Yk=@vger.kernel.org
X-Gm-Message-State: AFuF++ljK3hE93WxJL7vfqOpSdoj7Dpnd/C3zH8HSdPMIC2zlOytQmBp
	Cu6macjA96mFYrVRlwqQ37BxWq3W8216+9xikpsqQPjxmKQoiIxzlPh/4UCBKk98
X-Gm-Gg: AR+sD102jfpHPDd31x8XhN4PXafDYtdMWPWFTbO0kJ/DlMoKxqMeedpXyGJP7nLNkpm
	gW5FTMH5SSOn9fZhv9aVxBlAsll7ewVxj+Re0f60xdQdYmvtvzdAPQucJNC7nqXmFUyZgV2fhwg
	2VZr0ZpacPsh9HdKVjg+5FOYccqOggPqOey+OXzsN9T8U7278agVtyc+/V8jRxdlAorhJfbYDSA
	2tIymKB2VtLg1qkG0rL0AUhjxHBfzEs0+efvk+7ibjolIpLP7m876Muk0dARk3yjIt0I9xSIey2
	F0h2mfmOYdKANmIwXKAJ1/AYdzJTtl1udWqnpinsVmuvJ3qKCGanLKvWOw4B56Z068GYYYfLr3v
	JEvGFNHXCsGei+tAQh5suIEmkI0S4XMJEpKt+UHn5rxFG/9XFdHAJwzusw9aCwYqUwah+izyhbH
	AmYsdoLx6YICvzdoQgvYt/G/ASkj9ybfbQ4aZV/yzKjfoY28MT5pWlujbctShsdqNo3oJHewnY6
	OeThaD0HjWh7uBu5verlxKftw==
X-Received: by 2002:a05:6102:512b:b0:778:5bbb:b2d2 with SMTP id ada2fe7eead31-77a64358362mr2032295137.11.1787307417094;
        Fri, 21 Aug 2026 03:16:57 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c4e76040fsm8354728241.3.2026.08.21.03.16.56
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 03:16:56 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-977168e4f3dso617854241.0
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 03:16:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqq0R2iEtpUYc5PN1MnCwmtp9pErrTqj6B1jDVG61kBI9YRPt4lCEbwzezUzie4YBE6H3+ypBD2JGc=@vger.kernel.org
X-Received: by 2002:a05:6102:512b:b0:778:5bbb:b2d2 with SMTP id
 ada2fe7eead31-77a64358362mt4198076137.11.1787307416387; Fri, 21 Aug 2026
 03:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787165329.git.geert+renesas@glider.be>
In-Reply-To: <cover.1787165329.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Aug 2026 12:16:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXaxV9K8=yQ3KU-V2dV-eFqFqMR9WDyt2RVKADLS51Dcg@mail.gmail.com>
X-Gm-Features: AcwNN1XMP476J77X05DStUZ6YHTKoquM1cTbXZSuVIS6ygsja8ReRo486qzyWdY
Message-ID: <CAMuHMdXaxV9K8=yQ3KU-V2dV-eFqFqMR9WDyt2RVKADLS51Dcg@mail.gmail.com>
Subject: Re: [PATCH treewide 0/5] clk: Make sure clk_init_data is fully
 initialized (part 1)
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Nuno Sa <nuno.sa@analog.com>, 
	Guenter Roeck <linux@roeck-us.net>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Sunny Luo <sunny.luo@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, 
	linux@analog.com, linux-iio@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Aug 2026 at 21:05, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The clk_init_data structure contains three mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  When commit
> fc0c209c147f35ed ("clk: Allow parents to be specified without string
> names") added the last two methods, this was done in a
> backwards-compatible way, using a priority-based scheme:
>   - .name, .ops, .num_parents, and .flags must always be initialized,
>   - if .num_parents is non-zero, .parent_names must be initialized,
>       - if .parent_names is NULL, .parent_data must be initialized,
>           - if .parent_data is NULL, .parent_hws must be initialized
>             and valid.
>
> However, not initializing all members may cause subtle issues, which are
> only exposed when CONFIG_INIT_STACK_ALL_PATTERN or
> CONFIG_INIT_STACK_NONE is enabled.
>
> Hence this series makes sure all members are fully initialized, to fix
> such bugs, and to avoid future breakage when converting drivers to a
> different method for specifying the parents.
>
> This (small) series is part 1, and fixes all cases that I identified to
> be real bugs:
>   - The first patch fixes a crash I saw on BeagleBone Black,
>   - The other patches are only compile-tested.
> All patches in this series can be applied independently.
>
> Part 2 will be much larger (touching 185 files), and will fix the
> remaining cases that are currently harmless.

FTR, I split part two in 13 subparts, per subsystem:
  - "[PATCH 0/2] ARM/soc: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787239869.git.geert+renesas@glider.be>
  - "[PATCH 0/3] ASoC: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787239902.git.geert+renesas@glider.be>
  - "[PATCH 00/45] clk: Make sure clk_init_data is fully initialized (part two)"
    https://lore.kernel.org/cover.1787239813.git.geert+renesas@glider.be>
  - "[PATCH 0/2] drm: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787239944.git.geert+renesas@glider.be>
  - "[PATCH] i2c: bcm2835: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/9f82f37e6d6c069cd44326bcd5e5a2a8069a13a9.1787239980.git.geert+renesas@glider.be>
  - "[PATCH 0/2] iio: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787240005.git.geert+renesas@glider.be>
  - "[PATCH 0/3] media: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787240035.git.geert+renesas@glider.be>
  - "[PATCH] MIPS: Alchemy: clock: Make sure clk_init_data is fully"
    https://lore.kernel.org/3610b51df642abb1fbb39f5bd93fddea43f8f164.1787240060.git.geert+renesas@glider.be>
  - "[PATCH 0/2] mmc: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787240090.git.geert+renesas@glider.be>
  - "[PATCH net-next 0/3] net: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787240118.git.geert+renesas@glider.be>
  - "[PATCH] peci: controller: aspeed: Make sure clk_init_data is fully"
    https://lore.kernel.org/48aa77c45e109f78ccd806bc3b7bf380c5bc5e71.1787240145.git.geert+renesas@glider.be>
  - "[PATCH 0/2] phy: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787240165.git.geert+renesas@glider.be>
  - "[PATCH 0/5] rtc: Make sure clk_init_data is fully initialized"
    https://lore.kernel.org/cover.1787241693.git.geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
