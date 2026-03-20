Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185636829F
	for <linux-spi@vger.kernel.org>; Fri, 20 Mar 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005652; cv=none; b=p60m0neJdzpXb1gGfqAoom4ZLLnBLE4dfhlbQBZ2eIKhvNLxuAUDLroDJE1x7+Kjab1rAEPIncbD5gFOGJMn1q5VBQRUwsx2W6uoAxixEzHAxztpQuU4VH6R22GKvRpPU0p6JSuCi+a78265ys/ghltQP93Hly2ivC96LH8OdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005652; c=relaxed/simple;
	bh=9ieM0PKneLc9XAFn1kgI0QbNwUio1Qq6fWkxlV5z1Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpJ3Z5+y4nBbYSaZ4RDPT5LalqnVWUQS4OGRkQa+QLq+4rfuBvZyAMzrsOyeDkBfJgMabQ5Fn606MSOiprhoT7q3/GKi4SOA8/rB+SnrWrXeZj2otRDw51B4MBssH+R54ocrHfuUrx+3PKZJT7M7CllZpJiSnEkDUE4sDuO/4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8297310ce0aso745800b3a.2
        for <linux-spi@vger.kernel.org>; Fri, 20 Mar 2026 04:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774005650; x=1774610450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QM2QQuood2CIqMt6ghdF4q02+bVScicBaTi5mQcy40E=;
        b=lgcNXB7Xj4Yh0gsPxw2dogBv4CXH5iVDOvWnAUo9ITCOCcdbOLAwi4z0i6WIaKGPvI
         BOmu/hSPdituDqi3OsSUwv6adNW2yucIhZ8x5VepOZJBwRU9vdRk/f9o6uvaPX96N73j
         DBXvTj5bfSLxPHOYTWWeuIuT51z1JiIT84tAVObTxemcvYLWccZc0pOkTcEo+8Q1gNwb
         EPDqqaa9MF7X/D71l8RLULfA+TFBshi4FriyLsja1IhyumX05f5ddRyON0Qu9kP3cMlj
         Aa07cD/0n0eCzZ2NdXGFaMBjcJgZXU25lII1m7qWLU+oglJkHqHmtRRKwjEFrCmf3UhF
         FSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNOvunixj0KaImFzHIb30FeNsKsfwqs1KFDsump15g1oAk0ML9YbICJIRCA3jZ4ReGJua3DAQJbOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpD1Q859IHDgx6/Jc+tc/V0VAjd6XfpdinWqdq5/LcOHtKPuJX
	ZxhrqjYJ7lv6ZvS1kMCwNrLO8t9o6/FiH7oooz+zCmWr34rfeDP2U7oDH0G/1IK0QP0=
X-Gm-Gg: ATEYQzz/NiLKnpbUvlGGwScoyPuFl2y7MmDHzYJAtpYjX+p3G6hAThPpZs0Rs+kKdJv
	vAfzXGfgJ7jiwpcfrPn2NY6Fa5M4sDkAGKhUDARPP74X9+Moe6L1yPbCS03BpP+Ptt66HpdS87A
	L78pp7X9GFHr+QwkBYm7BirHjyXeJf3sDH5YPZMkpEBi3S1jXKgGyHJeuiI6R0kWk2M3T49jDU0
	A1TRlIgJecb15vdIsHMuvVf7l+bOzGFAmmcrX/VMf6YOtZhgRij1UU3C6SKItWl6gAIsJTpxFkh
	X/QajBzenlg5SD2rsvVgvB4jMo/ySWdpf6NoUlkde8ld/dsqK4kVNb9sk2FxiyantIFoBCfbe8r
	f0UFDa0H2gP/l/RMcMjLnLAJUUKyr+oyBGRjpgInO726nXhgF/fym+Ui5j0KVfXyDZYa1tWmGwh
	v+OxstHtJ8sJewKGtVJj8h4cXGejLWstkkTkxF4tkJQY9EMi/wgxllPPvZ/Tk=
X-Received: by 2002:a05:6a00:1acf:b0:827:455b:86b1 with SMTP id d2e1a72fcca58-82a8c301b94mr2015268b3a.28.1774005650172;
        Fri, 20 Mar 2026 04:20:50 -0700 (PDT)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com. [74.125.82.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040db797sm1817063b3a.46.2026.03.20.04.20.49
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 04:20:49 -0700 (PDT)
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-128ebee22caso1489298c88.0
        for <linux-spi@vger.kernel.org>; Fri, 20 Mar 2026 04:20:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyYOYyvh+OGuWwDLASgbNtQ1fas5hMd5DuMnwfu+BhmGaQz11IA6j8UeigTUBuQb2lxVa6rxk2H54=@vger.kernel.org
X-Received: by 2002:a05:6102:3713:b0:602:9228:34a3 with SMTP id
 ada2fe7eead31-602ae79cdfamr1587306137.0.1774005294541; Fri, 20 Mar 2026
 04:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771344527.git.tommaso.merciai.xr@bp.renesas.com> <c8df5202caf4e36ee5beafe78ad0940643edcbb6.1771344527.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <c8df5202caf4e36ee5beafe78ad0940643edcbb6.1771344527.git.tommaso.merciai.xr@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Mar 2026 12:14:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWTOPYxC7r0ztuPc72T5xeDgcfo6CUi8sRcupjiJbRLGg@mail.gmail.com>
X-Gm-Features: AaiRm506QxR9HoC6NaRd9ZijJZ6-iF5Bj8kjApAjQvVWwUbRpOpkLxT5Tya6COA
Message-ID: <CAMuHMdWTOPYxC7r0ztuPc72T5xeDgcfo6CUi8sRcupjiJbRLGg@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: renesas: r9a09g047: Add RSPI nodes
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
> Add nodes for the RSPI IPs found in the Renesas RZ/G3E SoC.
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
