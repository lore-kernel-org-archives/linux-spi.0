Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E537B3E4
	for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785064731; cv=none; b=C4vKPji8BpbjWNMN8LPF/xJN6EpQgJu2NjAdxoLh52vgnSuxWKPhd74OshqwvcrZoFs5WYK/wS2OoztYL5GX+JZFJtfS3RStdB/UibtEQ96UJakHFORNUqFEFHAuE1+wEcfOLUFL+ewslMKHXgxwX3VhLkWEr3/MgSzTCWic6Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785064731; c=relaxed/simple;
	bh=nxusbugxTptpa+rPpPTZTTrxFEmCuoSHa5aCbDPS+xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIdQKleElxHVaiVCdHvFcXguzY11LK2t7I2XRyfcIJpvJGoppflctHcTWdYLaIT+RIxgLsf2WpIES5kSg3xqyB09T+1umDNhPuXFc1pY+EbVBAWncesteT1KpGhB7S94/GxIKfmrxHibmcv/aqY99DwWu6h1Ky6jeuJI+GG9P8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso1194528a34.3
        for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 04:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785064729; x=1785669529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=632RwbBBibm199GNX2dzWevYniUR/dq64yJK2ZdxiqY=;
        b=bcJBn1SjJVxlgcSQvsA9PeE7cgibvUamVsEb5o1eSomYCNnZqCG1/MfIbghsvPCZVm
         p8EiBe9miBH3C02TJTjjPYK+iqaoMoMiVNgzs+xLzcgWc9v9qvNjYTtcF3tXGOffeDhL
         vhQc8Dj1L5l1BW8/srWkTML271sRjn6ONP3ivDi3YGv1PS3jGYoVm2xHmY/9hhbIMO0a
         Pcx4KU/C/+JIgJwD9fuzfvM1j3yJt5DvkxDaLvIzQfHOwXCHpC4JaFsWeE0eBovE/+in
         mivNkpPnePOZ+Rzhf0xVGfebIlSJcyhQELVRCMkjAFAJP95F/xRcHM+QuSMtQZ6zVhoX
         VTsw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3YdKYU8kr18+GCQa5TvBQqE/hvjZhk5CE8gFcvGeDcRYdGi5oqPHZBgZF8d1Cre1Bh/X7Bas8A+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS4TAMGloeaiiomlNUKA8aWSfzkggSTh9gTp8U9ntX7Mze8CyA
	qocEGwcQE6DXe3TjgsDFG49bGtkPCChDYQ5dn91zbFNIxzBdyb7jq/con6Gv7TGZJw==
X-Gm-Gg: AR+sD13Guum1orxdqq4fokeZc2f0w7SnrHvzM7LiK51aJKjZf3Tu/KLx+TDwW/QP/Eu
	qEkNUVdCcw5VUt9hjWmIIDWXpkhN2gx8Vi60916SiLqmD5e2bmr1g8W7B/DVJPN8dOpU7ZhFuZD
	9rFJaYuqGaRGGl06/ON1ISPHL42ysC7ci/GaY5tnKTbwpLxOGJEHyHi4hzqlIqv/XChRETm5dXx
	PF/WCmg+PAEYguf22PdY5lFqmEJho5A8CplfDlMGN9rxT1kgBj0n9QwpXW5d+A2SIFNFl9fHG+e
	sjtGZHj/CyTw0GQTw6WDNfQTOvsQovU9dLlUyY5KIgZmanhhOv+O35sHhRSEEc856qqcUW4w7nI
	6Hz8X73pO4lcmsUbXFrl2adl7JJjHhns5XXrq1VkPXzMwcJfLayMvtsJEMQ7xcwqxEEEGU4MRtg
	l7vRtXHXVGY6sN1IVPilqV57xC0dauoxFTFbKnLsLv3grhBlqNuNVbWcYven22HOeJgMbVW/e/
X-Received: by 2002:a05:6830:498f:b0:7e9:b537:102c with SMTP id 46e09a7af769-7ee78dad27fmr4366484a34.25.1785064728782;
        Sun, 26 Jul 2026 04:18:48 -0700 (PDT)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com. [209.85.160.53])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29a8d094sm10181911a34.0.2026.07.26.04.18.47
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 04:18:47 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-44caeb973b3so996795fac.1
        for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 04:18:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqtMrm8eumqtF78F7LMpeGVpmw3bxsTg3cjpNzYUnmnraTLqQa6zdgQDYYGnq90oI5duSHd0aE+Emc=@vger.kernel.org
X-Received: by 2002:a05:6871:1c7:b0:417:3441:6c54 with SMTP id
 586e51a60fabf-457f26b3ab8mr4168574fac.27.1785064727020; Sun, 26 Jul 2026
 04:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-5-fourdollars@debian.org> <al59LnVJQhiZq9yR@ashevche-desk.local>
In-Reply-To: <al59LnVJQhiZq9yR@ashevche-desk.local>
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Date: Sun, 26 Jul 2026 19:18:35 +0800
X-Gmail-Original-Message-ID: <CAAT15mNtGTyHHdYooj=Swe1hZ1K3Jo4TkO1groi1LnVih4M+ig@mail.gmail.com>
X-Gm-Features: AUfX_mzTCh_05ojLUq8ZB-hAiaGj-Auwe5dWIigJ-AodVsVlW5LsP53qKDqeICk
Message-ID: <CAAT15mNtGTyHHdYooj=Swe1hZ1K3Jo4TkO1groi1LnVih4M+ig@mail.gmail.com>
Subject: Re: [PATCH v16 4/7] spi: pxa2xx: lock out runtime autosuspend for
 Intel LPSS SPI in PIO mode
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:55=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Jul 21, 2026 at 12:21:13AM +0800, Shih-Yuan Lee wrote:
> > When operating in PIO mode on Intel LPSS SPI controllers, runtime PM
> > autosuspend clock-gates the hardware block when idle. On subsequent
> > transfers, MMIO accesses to trigger resume are performed before the run=
time
> > PM state machine can wake the controller, causing PCIe Completion Timeo=
uts.
> > This issue does not affect DMA mode, where the DMA engine holds the req=
uired
> > resources, nor does it affect non-LPSS controllers.
> >
> > Lock out runtime PM autosuspend for LPSS SPI controllers specifically
> > when operating in PIO mode.
> >
> > Acquire a runtime PM reference via pm_runtime_get_noresume() in
> > pxa2xx_spi_probe() after registration, and release it via
> > pm_runtime_put_noidle() in pxa2xx_spi_remove() before hardware teardown=
 to
> > ensure the runtime PM reference held in probe is released without invok=
ing
> > runtime_suspend on already-unclocked hardware.
Hi Andy,

Thanks for the feedback.
>
> .runtime_suspend()
>
> // this is how we refer to the callbacks.
Updated the commit message to format PM callbacks as .runtime_suspend().
>
>
> ...
>
> > +     /* Release the PM reference held in probe for LPSS PIO mode befor=
e
> > +      * hardware teardown so the PM core does not invoke runtime_suspe=
nd
> > +      * on already-unclocked hardware.
> > +      */
>
> /*
>  * Keep the comment style as per SPI and many other subsystems
>  * and as in this example.
>  */
Updated the multi-line comment in pxa2xx_spi_remove() to adhere to the
standard Linux kernel multi-line comment style with an empty starting
line.

Thanks,
Shih-Yuan
