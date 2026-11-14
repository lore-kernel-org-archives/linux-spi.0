Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794618820;
	b=h/0K1x0XnHThlZC+n3QcD0pJStqaobqpgto2iMk75cnZVwq2unhUSgbaELWCUhD7r2i/
	 NLNilfnAtv8vzDqz1GhTdKVuPD9nqxb1ZWIMOqGCSERy4HkqDZjmUgjpe9RZiC0EXeQ7a
	 4eyZHI2RGauDBfEhIkYCtrf912UPTvmW5+fpp8qMNtFSZ3V1RZgWuoOlBbfkGa0rIemkD
	 H53bTerhNEIb13HxVkNTrenHxF1LfeJt+DYYdFAreey/cKaj2wfPVqPoboB+zLilJEZmZ
	 iMUc9FV7WcZrWI57vSiQxz5ou0ZBjcW955qaH2CUqXRI6Gszyr5mZsC+lLfBWyh/EkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=mRnwY06Mr4WaxMQBOxox7fUWk47wPCvPr48cEnpqDt4=;
	b=CcvfnK2z+KeGtKPmDJXxywtoZ1grB3mIxwhjwiPVg+vD0P1Gw2nVxlMnH8R8C4DzCuVY
	 74jK5rLbCB+RiK+anLeuP7spe5y0U7yk2L2ItSLJS3SP9bYWwnVPmTabtXZa1TdM4Hcyd
	 F91aCY1zy85CYs48XWkPBStYnXl7LvZm60mRe6a2Y3OgHXtD3LodqdvhcP99EEp3yFvku
	 0Z37nicGnkOz1b1S4z4o1RDDGWdC0TPHqT1BLcBDqARo/xoRQ/WLoqViakI22cW9iDJob
	 kG81W707ZO7zwGJoD5g1dlWDW2jgm8gpZHUph4NqN1MaVYMduNOEZKWIVawpVJc/F/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oKQO1Jtr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2FC606A889
	for <linux-spi@vger.kernel.org>; Sat, 14 Nov 2026 01:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A2FC606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oKQO1Jtr
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3adfb0c9e3cso2981911fa.3
        for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 17:13:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794618818; cv=none;
        d=google.com; s=arc-20260327;
        b=HYuLAS7d4vRM9dGMM9zH50d+D2EITHv1ZrBbTQvo3AjybkCyPhOLZusmzSoLxHVFsP
         kDxtQdrZGV6X0whdMui4DtR5CUJiFW9W5Qd7dsUWscsNrtD+psZShS5OZlCrlB3l3813
         NRXDZRZR2dswcqs0TPnh4k4o/kodw3ipXZtzHuxGaC5O7RHJqwPb6kX/FhO2sr7y9q4v
         yDuKHo+hpymLErKVRisYDhgUopBfUjmeIGGlUeMZIhwq412IGsqG0d08ypFJhNfjJ31e
         lwelTox8H1zww2mmPecUwr0Irf0elYwSX2Lgo7MMIZLb2+T1hRHOFxGshEmVWBfmNrB5
         5SXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mRnwY06Mr4WaxMQBOxox7fUWk47wPCvPr48cEnpqDt4=;
        fh=9lwdl387XtnnavHKHmfmNOCId0Oqvi6iOZLzaBPzcy0=;
        b=be6cyB4OxtTzEyUVyx3+wiDtcJfIbqq/GH461h68cQ0ZeAUOqekktDrjfzS0KKkXtX
         Uk6Qw8qZdVCXUMpx9x+bfc73giKDQ8nRYUifOa7MnwZ4E15V9IiNNTxs/qWlvs4VKtFo
         JyuX/JO4BnJdqWjzagAipgzPZHr+TPEShfG26DPWem9FmoLdnYq25g+nTe+0aFupuXwe
         hBp1Em21suGyK3tABbAqaihe6c3w2304vuUWxaY2hV1wB5R6buHrkRynDTq4i5dZxu0w
         Ejamqxg2up2W+GXn4d9dUvctiOsemVs0Yfo3kL/3Tnv7uMvKkMCGx1inHRwspAySl6IB
         eVSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794618818; x=1795223618; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mRnwY06Mr4WaxMQBOxox7fUWk47wPCvPr48cEnpqDt4=;
        b=oKQO1JtrElFjvMtBC5P6k4rRBbO6GLmIU7F2eRl4LZPlgxHmY9EjG5O4Z/Jc6Qf3HD
         iPmZROIV6txd1l5e5IR5aNSYLrnioo4jpGj25JfuzJTIvv+WQrKdzbLYXg5i4ogddvph
         hHEEoUDaZx54JzFAG59XBPLl4baO34iNRBWfjr9YsvtIbmxvf8qy6BWmunHfu+KixTAv
         JmZQIZ6E0cz4EllKe6AYgvR4KFSflkkMXSEu+56SYKrPDEGj9JPyNVtRlm3+D5aLH0tT
         s3xPdAy2rFsTObvTcwnSyJRQM/S6t8RajpVXaVcfrdRlwoK9WQ/qZLOkN+rGMW/8tNDw
         oZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794618818; x=1795223618;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mRnwY06Mr4WaxMQBOxox7fUWk47wPCvPr48cEnpqDt4=;
        b=mc4vE3ZJPpIGS/cnuFAKdFWr/5Rrk/cw5Nq2SIfpt+JfsEaiL2Vgm/hkYYf3S7+N/8
         TzryVOBAZAaMmz1f30Ylhi8OHCBkPElOvIAzteMlDHwxapsdZk2UFFkYZ4OWkjFkOZdr
         blpZCEyx8ML0WUepKwnIrl+5HM+X7m3gn3PHoPTsamDhfdEj/B8yYQ4vDaOID8D1VCBx
         cc5giqyP85GHvdueiPlzwgUI637jmOiSCdT0l7evZzUlG12ZfuKsTBajbZXfR0fnhV7x
         rcxL1s92kVDY1bgs/w+zzVWc21b16uZECigQvsCYP4DwW8FrrQGY33OfRvz6DzUz9/Ro
         Rbfw==
X-Forwarded-Encrypted: i=1; AL+hErHOK7CYSjvbuFcpmpU7jY07LR2hDSiHhZ6dGz0k/pxciodQzP+bN0nzWWnBperKkdS1g/VhFoNFJVw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Q9QUt1mMSvyKthk8jSqUaqogw2oetxiqAnyVIM5kG0yFxT/Xp
	jTeKrVJElpIlTghouFVm6lkAArKeFZ/gUDCyaMTxXqVredKW+GezYZSlVbWpx4zfe1J7FdfYv8h
	gRyj9CDgPwZDxy/xaXHJY6O1Oqq/CtvrQNPulykFaPg==
X-Gm-Gg: AYBFou0on7EVUANGdvP0JsPQwECInWHvaR2sMCzvYM/EN5TczR8RYitdPEI86FNh8Qk
	pawo/pEVA5JLlr2ZxTIy1Y+idkDfiN670+iB1cXZb9geKtZ1YjytRw3mCo75vkhajiHZFDMFAjV
	f8BhHixApCHw6YWZ9bjO1Tm55OXUdgNio0jw3s9+9DEdOI0V2PCZ36TMOLcQzvJGDUnaCLr/KZ+
	Q3/uk3dZxL3zmZ27zvAdqEw++UU3poSG0qCSyGQU+T3p3gBazxfS3T7sqYQX+16tGn76tk6dx9X
	x94+XkVBjHAEP7iobK4rnge8ES08tUoOfSTOplRFvC1s1glZn3bwmvDroeFtgNDkBkVDxT3f6ej
	YB8nUChp7r2ffFtlnDIqzEJQW03xyuvTXUVneKV56ZIGipczCZQDipxNCoz1tskmOx3n9VJ8=
X-Received: by 2002:a05:6512:3e0d:b0:5bf:a66f:e5e with SMTP id
 2adb3069b0e04-5c17058b108mr1887902e87.0.1794618818343; Fri, 13 Nov 2026
 17:13:38 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-spi-sun6i-h616-dual-read-v1-1-59bea5a897d4@gmail.com> <179461167656.590303.12402709871115244251.b4-review@b4>
In-Reply-To: <179461167656.590303.12402709871115244251.b4-review@b4>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Fri, 13 Nov 2026 17:13:27 -0800
X-Gm-Features: AclHuK_CV3TuQGipcbjy18QP_8RBQLDadnLrh6ZniBLdvP-qmCmNyU7dCRkLAeM
Message-ID: <CAEy9hNUgWgO_tzV=3=X82A3kOYBxhukOvqRzaq+-YC18=RZW-A@mail.gmail.com>
Subject: Re: [PATCH] spi: sun6i: Add dual read support for the H616
To: Mark Brown <broonie@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This new compatible needs a corresponding DT binding update.

The binding already has it: allwinner,sun6i-a31-spi.yaml lists
"allwinner,sun50i-h616-spi" with the "allwinner,sun8i-h3-spi" fallback,
and sun50i-h616.dtsi uses that pair. The patch only makes the driver
match the specific compatible before the fallback.

I'll say so in the commit message if a v2 is needed.

Arun
