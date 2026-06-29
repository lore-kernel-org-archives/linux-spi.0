Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2B3F9F44
	for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2026 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725556; cv=none; b=PRfSxhZV7sFaDaZMXrr7NpBTimd5WZmEs1pvTvCW6ae9GMyhLTAfHzgz9kSE1xa4XFzMtOOqnJfU2DgbsUt0R7Wg4PND5cgJh/eUIHl2mKtimaRJm+LhJpGuL2tYFHBwKf9HC8GSBfEULdv/jhkHsibx8/gD9dmbSeMF8DFUEX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725556; c=relaxed/simple;
	bh=av/M3ZtUQavT/hkBofKRoJGx6fD4OmsKWIzK5NQPTGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiURPbtE/DC1GJQxt5KrEMGx5cpQJk9S4Z4r3w9d3YB1fpNgM7UKIfULGftFXsgxd5eIjpCGHPp9z/ImMyU58r4vdRmH2vcemulcj9xAehoDDFaZLJR6pPpUHN1OMegf1/td55GHZ/A2TKINB403CgbNnHf/lPpa+jEOZk5vXyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-59d7db12342so1211110e0c.0
        for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2026 02:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782725553; x=1783330353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPgpCbYo3dOS6VSWtqh+ogyk9l9INK3PsDaC/Z8QySY=;
        b=qwqXeOfog8WaxpFW9wA9btrRSIoHiRkEG8+sOfaGajLEcat8BgRDCr00Ss5MiO3ASl
         iD1Jupb9ABpNvIruM6YkSGlLdVJQr7OUeoKw8vC9dOkRfEk8tHgWPD9RcArykCaN4pcW
         EeTT1V1gTALCyrYpZOw5uM2JUkYxipWgYFYvAhKFoxoDo+cb2/A9MUFRNbp5Z6ejTNv1
         xphU3rcRmMsDxjiCaXIDCshIFUhnrFLmCTIAh5kd7pYAXMohcoNqi4cVbi4JWmSKaGMb
         1sKsys+ZJEMYKXPXOUaafTG5dw/MEHBdC/WhlfVWqEC7lEfBAzm/tpRS7EkWXWt/OmsF
         cxIw==
X-Forwarded-Encrypted: i=1; AHgh+RoTjpa1INcqKJjWlHYKS1m1RncGHliJms23Ya6F+D4HRHAMcPLPOUKVif4pGp28k+B0bQqkdQ9f3aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3HFVnqxp9iiXYC6Z5SdC9iG5FnnnLKib5sFzS1YKyHYzwlhq
	jHgkZN+ICfDJCK6Q9gM0HM/cUnIcI9+FYy+cPjwsyrNHj4gnJuAcrrAasilq8NQt
X-Gm-Gg: AfdE7cmWFn1gKCSlsEJiIVWttUNDqWRHUFtFzNq5MWe83VsiVkGPoZ8+P7BmRjF0/35
	wN2FCIPaTCkneaH8WuqPZ/1QiPmy1BaadEfb7fA2cij044kzXociluInyPrG+xuSr64edd9bepV
	lIET2KRWfR6GErXaWjXzb//rf8zeEQo1CKiG36YOB/INgk1K+xybd2UfbECmIBNmhUxPCkWGeIK
	jen/Em30LVNRGIYu+WlNDxDMsXxnTHnUYN03z6+Fj97Gs6A4HME8u97HiPYK1FOWnE4U74VKsAI
	dIC6G37OLS3Xf4P/NHIDw6amLKPzseVMDL8bGcF8csxbVypdfGEhf4Q38w4bbJ02hZJkjTG+qFY
	pMViwS8y23T9zO51RwuGx2EsFf+XUV6RV8W2nAFVpxjvHhesXRs2mUrKgDFGwAohOvBtUMjE8mW
	Uhs/ornHyA/w+7T2Y1oF14DSlRmlsF+tbqsgRxyeBbrvI2zv/KHnSl0nBXy727
X-Received: by 2002:a05:6122:6c07:b0:5bd:9dbd:60bb with SMTP id 71dfb90a1353d-5bd9dbd623fmr1504845e0c.9.1782725553268;
        Mon, 29 Jun 2026 02:32:33 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bd79108c5fsm5312988e0c.17.2026.06.29.02.32.32
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 02:32:32 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-96944741eaeso152021241.1
        for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2026 02:32:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpWHgQEtat9M2QlMbzQ2O3in83ihRdr2WLcUrISwMcadVGFaDd9WnDg2trsSBdFTzQ2ollYZah4Q5Q=@vger.kernel.org
X-Received: by 2002:a67:cd95:0:b0:737:b586:6386 with SMTP id
 ada2fe7eead31-737b58665f3mr1404074137.16.1782725551832; Mon, 29 Jun 2026
 02:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626180326.9593-1-wsa+renesas@sang-engineering.com> <20260626180326.9593-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260626180326.9593-2-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2026 11:32:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVu15fJ=bGcGCNBY+jYFrfqP6VOj4Lh1Xp0Vu39Zzj3kg@mail.gmail.com>
X-Gm-Features: AVVi8Cd5PLW0VbQV3bpvy1FRMcV0RmFmKlx0lEhwlZ3tFnN8kqtg2CHL7DRXdtE
Message-ID: <CAMuHMdVu15fJ=bGcGCNBY+jYFrfqP6VOj4Lh1Xp0Vu39Zzj3kg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] spi: dt-bindings: snps,dw-apb-ssi: drop
 superfluous RZ/N1 entry
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Fri, 26 Jun 2026 at 20:03, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Commit 164c05f03ffa ("spi: Convert DW SPI binding to DT schema") added
> an RZ/N1 entry which was not in the original txt-file. It doesn't follow
> the usual "<soc entry>, <soc family entry>" style for Renesas SoCs which
> was properly added later with commit 029d32a892a8 ("spi: dw-apb-ssi:
> Integrate Renesas RZ/N1 SPI controller"). In that commit, removing the
> bogus entry was overlooked and is finally done now.

Nice catch! I must have looked for renesas,r9a06g032-spi omly...

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
