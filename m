Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FB03BD22E
	for <linux-spi@vger.kernel.org>; Mon, 21 Sep 2026 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789975537; cv=none; b=oEUknr8iSZdZgq9vK/7Hv31xw4kI2ZbQ/K87bKq1njIQnYI+7YJY5jZ1JHUgTSGPOgK3fxADzpRxcLg64tTV2GqNnejKksXeGjWZHiRSyPAkymF2uVWp3NM/wZsk2fUsfUoC3TxymxUAwekf/MGoCUIergGeS+EhLXFzzpAsYrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789975537; c=relaxed/simple;
	bh=6tKTGDS6JtG90Il7+2qAPduVfkvtwUyKRtM8IGgWrL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgZz1ZCsaN55XTU/gKFN0UJZmBnI6ftHxktaAyrjKWXyVFjj75FPFNWE979Sq3x3MhzXnxHlydl4BG2PKPDtjSYWwl2ikDfD8SMG59+MkHMDTqpsJv1FAQGFf4tNkn5kTB2sPRMbB+QTgY3nd0jpVMnMpbCLdfa2YatAF2U6t9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c67e4d8d8aso1810107e0c.1
        for <linux-spi@vger.kernel.org>; Mon, 21 Sep 2026 00:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789975532; x=1790580332;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/Z1SbtUTgxZShJMFyPJ1MYGOC5nK1asEC/Nf/hEw6KQ=;
        b=NsEj9ft+LHMBatSObdvIW6/+nChG9smLXec+pAZa3vkCvFBC+1uo5yVzQIZtanJA07
         NJHpmwEfuiQF47aAsS5JbZrfabazjulqP5oXVxtBQ7VJZgT1pRuwZ20hA+0Dqj1Ubz3u
         l0pde0lVO2yAMY5DfKdks5uTdLcwIGXnUHN0Q5suOtHgkaGNT7sO1cEtVwF9KMeRoH5M
         hJNMprkObYMvP20okoCBQHVJ3gCmjrh/ZO/K/zKs9HbZOKHZ/L0WrJwEeX7bR3K97E/8
         MwRZcGkFvvWCbNFafeXm2fMBnFkvrJu4yXITADp65BNsqb4+pzxvcsSmF456oY4blu5e
         1+7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzsuw6k815FzujN/HCH/W+orh9ytTeEyLcidpeGXeW3AZqG5HpOv50amESOoKQug/9KSwPD01T/XQc=@vger.kernel.org
X-Gm-Message-State: AFuF++n93qiOyGqyba6izRQQgrUYt0tIxsonsP0AGsWy8ZQYtBfC9b9h
	zqsq0gkj1zHnjDXDlFGFsSlNsUUUSOKInEz4t5+jwjTghe9xZVKarvlg7gBQnTAN
X-Gm-Gg: AYBFou1umZNdNu/LzWXtlHsULHE+dJChP1cL6Lzqpm82YPD4laomLC5s1ugoWmlOKsG
	iFten1toimBhnFFT1TqubRDyGkqhkfPpo9o26BPqlUGgqNiW/JMIbkZQa1CBvYSO/dkTWdWh7UO
	Uii6aZp/kGscmVjUDC20cy9x1M3DMPmsJFf2dVZKuGOWVnJZMxJt5j7mB7U/2Uqi+0ophuf2Arp
	3N9lpTR1SNYHSy2vz5cke36X7WU6v4Mb1jVb3QV6bdIKdvRqsT1IyEita2En8jdCCxPbCQ3bpac
	bkmBZv2Tl+nEuCRF0EQH2sKmXbSWQtqrgispHKENbYxVNVpTN1cDWUKNBHbIl9uOCjSkkOw+JdD
	YzUuujnvlvc/T+jzeV2rE8qSQk5YewB272DqIZ7eFXKNOMs5LAgcryPRHfPTZFSoWGsdYry6ntK
	7qF6PoE21n3/shB99wjOghJoWIIcP7m4qKj0tTlJuFFnWVl7cb8ypvEyOrSnyz7OOqvQXwcAHFV
	QhScNYy1mujhxNldKpVTEb5xTv4nPFQuOF3
X-Received: by 2002:a05:6122:787:b0:5c6:599d:8730 with SMTP id 71dfb90a1353d-5c9b58cad6bmr4068367e0c.3.1789975532330;
        Mon, 21 Sep 2026 00:25:32 -0700 (PDT)
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com. [74.125.227.12])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9c190d99asm6414166e0c.8.2026.09.21.00.25.30
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 00:25:32 -0700 (PDT)
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-790b4aeb66bso1574196137.0
        for <linux-spi@vger.kernel.org>; Mon, 21 Sep 2026 00:25:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzAsiFmsvSW0Ei9v8Zy2PFklT5VVJUk93kgb8g2Jw2wAxCW2V+CDt9qNz9ZSaQhBEXpD46wRnKMA2I=@vger.kernel.org
X-Received: by 2002:a05:6102:41ac:b0:7a4:e550:eeb9 with SMTP id
 ada2fe7eead31-7a55d28bba5mr3601642137.22.1789975530039; Mon, 21 Sep 2026
 00:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <60988ce9c4913014e255ecbe127e93374f6a2295.1789570538.git.geert@linux-m68k.org>
 <20260918200033.GA1667835-robh@kernel.org>
In-Reply-To: <20260918200033.GA1667835-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Sep 2026 09:25:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXDmZs1f+co7EcC8+yp4BU8iNo-1c-TNg6Xe8nYLeXOpg@mail.gmail.com>
X-Gm-Features: AcwNN1U9s09WD_Fc6q3FVUM3sMCtDOgMMGz5EOC-0K6lXxufMm3wQwxnxJmg5fk
Message-ID: <CAMuHMdXDmZs1f+co7EcC8+yp4BU8iNo-1c-TNg6Xe8nYLeXOpg@mail.gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: Relax node name suffixes again
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

On Fri, 18 Sept 2026 at 22:00, Rob Herring <robh@kernel.org> wrote:
> On Wed, Sep 16, 2026 at 05:18:27PM +0200, Geert Uytterhoeven wrote:
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > An SPI bus node name can have either a unit address, or a suffix.
> > Commit c4fb6880edc15866 ("spi: dt-bindings: restrict node name
> > suffixes") restricted these suffixes to decimal numbers.
> > However, SPI bus node names with suffixes are typically used for
> > board-level bit-banged SPI busses ("spi-gpio"), which live at the root
> > of the device tree.  Limiting their node names to numbers is prone to
> > conflicts, and may cause silent overwrites, especially when a stack of
> > sub-boards or expansion boards is involved.
>
> How is that commit an issue 3 years later?

Because no one cared about avoiding future conflicts and/or no one
noticed any conflicts?

> I've commented on the case which I guess prompted this patch.

Yeah, "spi-ws-2ch-canfd" referred in the Closes-tag below.

> BTW, "spi-gpio" or "i2c-gpio" are not good names because you can have
> more than 1 instance.

Yes they are bad names for node names.
I was referring to the compatible value; sorry if that wasn't clear.

> > Hence relax node name suffixes to alphanumerical characters, so users
> > can write more descriptive SPI bus names, which are less prone to
> > conflicts.
> >
> > While at it, reject empty unit addresses.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202609150228.Nh4nZzbQ-lkp@intel.com
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Other subsystems (regulator, i2c) had similar issues, and numbered
> > regulators caused conflicts before, see e.g. commit 45f5d5a9e34d3fe4
> > ("arm64: dts: renesas: r8a77995: draak: Fix backlight regulator name").
>
> I2C was a case of "too many to fix". Maybe time to revisit that.
> Regulator binding is a unicorn and not a bus. I really want standard
> names for buses given that's the only way to identify them generically.

Aren't "spi-gpio" or "i2c-gpio" (compatible :-) nodes unicorn buses? ;-)

The issue is that they all live at the root node. How do you name
them in a conflictless way using numerical suffixes?
  - On the SoM: spi-1,
  - On the SoM carrier: spi-2, spi-3,
  - On the expansion board (hat): spi-4?

What if your carrier board supports more than one SoM model, with
a different number of spi-gpio buses? Oh, let's start at 10 on the
carrier, and 20 on the hat, like we used to number our lines in CBM
BASIC V2 before Simon's BASIC gave us RENUMBER ;-)

What if you have multiple hats, each with their own spi-gpio buses?
Hence node names like "spi-ws-2ch-canfd" make sense, IMO.
When the WIP connector design is finished, and provides separate name
spaces for the subboard in a board stack, we can revisit, perhaps...
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
