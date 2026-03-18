Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD53C4540
	for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850030; cv=none; b=tQKUNtJBwnhA96tWnwLv4Nz0mHofJpE4Yja9oVq1RtGZHr/Y1l23EnBNaCVzCjToKZJ6HcrFTUogcTKW2FKgk5W9GMPhcExcR817ufQ4VZiyLhFBEgL69eE69PtLtqSItYl6/VbcPbr3YjbVwdwK56iogzuOA+QYIllIdRSr9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850030; c=relaxed/simple;
	bh=C0K3zuIGCFbCWEAA6RQca9NBjlh1H0UByRONnfECmAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLlkBKec7wuNDbITL7Hh7xdc3r8CZZFPShDu8RUDT/+R9XGFxxbF6bR2D527E18ssK5uijIEeO+3xXsH4vtyf05bEAbL1t4SQOZD+VPdCDhtv/VsOMrQdEdT8daBXPcBpDCLaDgOCjRXqnc//8ukFMmyN3QgBGB7SyGMD6Mv8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56cc6fe8815so312553e0c.1
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 09:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773850024; x=1774454824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikhQ/s135EgCf6c2OwoW/1zLZPqI7cynubnVYKoEijY=;
        b=cwUfmaakr1bUoenj3JTIG6F+TPsi5gk9g6COxXd79fjmYCwXsi2FZppZd26aTJKNk8
         m6h/ogw1PLO0TF5wJrnD39Jt42I0h2Pe7MROmUK585X90uq/N4Rlde1B91zQpqkS9sbL
         BHG7GkBgRf5Fz9MAzXpkBCtaBC0x/R8qacgb7OsKvN/ZcCs5txagDSqVU1vlL1KgrKlN
         qakyufMujIljcIrKkLiStYeYxrZsopVEODZ3WDVBkrDCq0zhkOfnTnAv9p9mcy9tPR8H
         wHX33YLLQIdk1QvBuJY/HLNr6L3dD6VG0W+23ToeEmCgapqZC+fHCR13MvI5NNCpiNBp
         7vBw==
X-Forwarded-Encrypted: i=1; AJvYcCUSyzjU1IqdT1XCldfMQ9XRBTvCOCbKm3aorC24s/UBKlqBxr6PwNUzkTzKqDA/SNUf1TUKHd5qbCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6SbKNkMV6ude/L1O+Tyo+Q1nImCD0VBPzixO5edP85qTxnAb
	8r+66l2erzWURYj7X0d8iEAdxeM157CQQEx71o07elbxw3MbammUPkhwgqU/8b+gWGQ=
X-Gm-Gg: ATEYQzz/2smJ+dpZUip8jR3OM/BlQlzRtmwv3q1ADjII1eKAPZ0jFLkJSygC0GdKiFw
	zBGbCJX8VrNKhl4sbiCEeMuENgQUmW1H2Se0tEY9vO553icso6kwZ/WF1GjQxijDNIgRsDEN8aT
	bqTffdKy6l04SzG4LDe0xCCPpfHZPNQ0y63GdjFJJXl+Fs4xVQXXjOEP5qUE5xTbQzuqJ0KJLBZ
	zCfK0lzLZXFQ0qsZZrjpLld3h7nfIaS5c9nniZBfi6j5XKbUgGvkYiBPt9aUBq3i6o4PrcB3pWi
	o96nBnAKN+SZ3Lv9diZEB/Pz5LD4YsguceOuaChCzHHnHNWH+r6V/mQ5ToMUWFROSPxBYYZMrH/
	lMPLynPhsXLs52xzwmL8NUQhkhS8ORNOFyOGQQkKldwBwE5TSHFJbJSrhQESrE8Kv8UYzsNhKXX
	DG3h4hqqactFLC2WWreKJ0KSdGY9dinl9i0iM00O+r8RJn7dPstuHtsf3MPQoNePFT
X-Received: by 2002:a05:6122:8c0c:b0:567:499d:1fb8 with SMTP id 71dfb90a1353d-56ba719311cmr2253751e0c.13.1773850023819;
        Wed, 18 Mar 2026 09:07:03 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-951034007acsm1560872241.9.2026.03.18.09.07.02
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 09:07:03 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56b679e72d9so2172903e0c.3
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 09:07:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFcZ/j38CCbTb4u/AydK7amPqnF+sIZ5qvZiE27ThGphQh1DUZEAa3Xp1ACekU0XNFwXtuGDxiPs8=@vger.kernel.org
X-Received: by 2002:a05:6122:8c0c:b0:567:499d:1fb8 with SMTP id
 71dfb90a1353d-56ba719311cmr2253679e0c.13.1773850022582; Wed, 18 Mar 2026
 09:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771344527.git.tommaso.merciai.xr@bp.renesas.com> <ea6ed3b82c5a326732adfc0fcdb2922bfcad2591.1771344527.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <ea6ed3b82c5a326732adfc0fcdb2922bfcad2591.1771344527.git.tommaso.merciai.xr@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Mar 2026 17:06:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXOxG7JKmwZFEy5EE+qJKSMuafA58HQGfFxzNDTsJ9OEA@mail.gmail.com>
X-Gm-Features: AaiRm53ykWAMjD_Bg0jQpCEt2WVWpWU9Yx6QysAtvExMVNjGws_pY1ovqWPD_kc
Message-ID: <CAMuHMdXOxG7JKmwZFEy5EE+qJKSMuafA58HQGfFxzNDTsJ9OEA@mail.gmail.com>
Subject: Re: [PATCH 2/5] spi: dt-bindings: renesas,rzv2h-rspi: Document dmas property
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Feb 2026 at 17:24, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> Document the dmas property to state it must be specified as TX/RX DMA
> specifier pairs.
> This clarifies the expected ordering and improves binding readability
> without changing behavior.
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
