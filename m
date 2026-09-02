Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0F317163
	for <linux-spi@vger.kernel.org>; Wed,  2 Sep 2026 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333449; cv=none; b=WZyBgpSD+7QmhrU6UyPwwiHCKTOXJ4K0Nmj7RBJzRbjK7qkXWWbo1gUZFAt+/5rg/9+6DPlZqAc7iqytApoz9QSa8Jqb5DpCAcAChUxc8hN8FllUarM9kW+FmgmKzLK0sSSq58829Mw/3qrl+uls38sq1+ZoyGIlN+wJi0+DZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333449; c=relaxed/simple;
	bh=FcEGZKdbboa4FlcgyJibjyTx/ihhZ165/+Bkm0EaDJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsjqSeU6Etw44lPPQzEAznoFefW9yoheKdUhQSchqvqv3D/WR/YNfyZuZHrRhl5YE+kiLtp2m4PH850tWwBWi5ZKvDvNJXbkXafokl8vWNsihzZ3Ce9MzXUdNv56pkAc9Tl1nErr/vJx/vZlGRjSi+to/F7dMr0abFIAfAdSlII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7542a2ee156so492622137.0
        for <linux-spi@vger.kernel.org>; Wed, 02 Sep 2026 00:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788333447; x=1788938247;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t2ScekBF+Nh8awtyScLAZusIOUSKJItl3YygmIsOaTM=;
        b=GFLNDviZMf2xaG4C3PZUg+yaRIv5q7g998Di8NyexRHGK+HvUoEl087mmFXvIHhyEF
         Nvv1RiosgWgwb0vbHdTPNapS7sc2yyuH5X9Ly3D6MF4S1hST3Fliy+wNNz0AJYcoC/hY
         fgfiTAZXbL8ISWmC8JAdWYD1wcJYCLuM7YUF1tya3piAOUzaSS0W2lsNYyANzn/N2bla
         VkTv+m9bABUjwWEXuNCV4vRcMELC2+VQV3UbLy5v1St54jAwK0UjqoXpEOmR49hCdIU0
         mQqxpMxuX0Gip4tiPTHMYJKXMlVK/mrykA9ft6b3V7d7fPDurNt2fghLCtR6phGBz5QN
         5i0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzrwiGP2vXeWTPUfwJrT8NZNm/W+tztX93Mog4XHJ8iEsYDSwuirN5N2E/YerL5V9fe8ft2Fz5cxkQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nzDVegEHyTOGRligjwEOkAia+vagx33RFl808O9EubMpK0IIK1
	+KUy4rOwA9ycP2CphLZ9SDe5QcVrlKaloEYtiYV2jROV+k5BSwVyt9p5ie2s2xoP
X-Gm-Gg: AYBFou2R8+AYXHydJ2R6Ed1FN5nlwMkn9Mz3k7RiJwYkoeoF3btqOCgWp3RQH4AAlBl
	8gAApcZjkHmswOclCohL23DIlIfLNpf9q11v0I2930USlinaMP5RqrZ94cc3eWh7tV0+P1JfWbQ
	4PEN7po17trnQV0TK4axLWl6Xd4pzIzK2uKCK2GyJNqeX+ZXktVfqzoUH8dhS9aAfQONr0a1vtj
	3DyjGCQ6taH6yjMhxUZ8NoN85AtT+h6gh6CmCNMAnNUjcwOzVIL+TxUI2D8uD/pgG8kq8Edheum
	jJi6+7LIrOD5/yROYIuGWfZlZ0zuDq1Ipf2G305qfKidilkqzvE2Yb+D+vV1/0SLuidsw07Rj0w
	/OgigjwXlcu7/er+cRmxugH6zVwG6L8I1gjvMf9Lr/NZkcyt3TY+0BXYvvON2ik2V3OLCv/AecD
	MSj8mmaMoK7EuSFTm0scV+RH369wkLnpWtNE3WSPkDRNqxlg/wEgGHQ2RrnB/+ixe9hmnebYYcL
	YyiV3K8hJ97O54JSXGO9ha7r6ZTkQhmWT10
X-Received: by 2002:a05:6102:fa7:b0:786:dfa:c5ea with SMTP id ada2fe7eead31-78a1f233c09mr1149998137.5.1788333446646;
        Wed, 02 Sep 2026 00:17:26 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-980672f5277sm1620252241.6.2026.09.02.00.17.26
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 00:17:26 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-785073ad5ccso539359137.1
        for <linux-spi@vger.kernel.org>; Wed, 02 Sep 2026 00:17:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz3AwgWluCMzcKt88/c/aJ8t5Cf3X23vHGzDIYfHsyEJWuUjXBQ305Rj3PubxmpwHlk+B+jhLEvU/s=@vger.kernel.org
X-Received: by 2002:a05:6102:f10:b0:781:3b9e:2f06 with SMTP id
 ada2fe7eead31-78a1f3e5445mr1064326137.12.1788333446299; Wed, 02 Sep 2026
 00:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830140133.24156-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260830140133.24156-1-pengpeng@iscas.ac.cn>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Sep 2026 09:17:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWaf7hYoQPCUBJmyErujLMth-_FAwPqZ=2dF9wkN5kc4w@mail.gmail.com>
X-Gm-Features: AcwNN1V1xFGksx0Kl8r6LOPHuVvW3tElc1K5c66IrPHXI-t7NJDIFpshnL03c4E
Message-ID: <CAMuHMdWaf7hYoQPCUBJmyErujLMth-_FAwPqZ=2dF9wkN5kc4w@mail.gmail.com>
Subject: Re: [PATCH] spi: sh-msiof: propagate setup runtime-PM errors
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 30 Aug 2026 at 16:10, Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:
> sh_msiof_spi_setup() ignores pm_runtime_get_sync() before programming
> native chip-select registers and marking the configuration initialized.
>
> Use the checked runtime-PM helper and return failure before register
> access.
>
> Fixes: 7ff0b53c4051 ("spi: sh-msiof: Avoid writing to registers from spi_master.setup()")

FTR, this is the wrong commit, please follow moved code.

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
