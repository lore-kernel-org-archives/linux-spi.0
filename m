Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C143553D
	for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626028; cv=none; b=PDtFb6SJB48jqr1roYdEi+aM+F2vefdJg8pIRaQIcWkxgt13TM5Ngd6dGSsK4XZDO1SZebrmGvK0gg7C7UJLR67yyccDvUxcHPFOGChnPeVRaIsA1FOCHpxa+BkqreypFT2JGcnStREc1CY+bfOJTY4hugMs0dR+PQw8UwF6mVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626028; c=relaxed/simple;
	bh=X3rtVlfwuBHfi8QKaUyI4F5pKBS41VEExBlCMwJv40c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvsdhKRFhZLNHRiErJPej59RW51MoMIdAgJ1WoZc4LW4zwTm9qjerLNYHubVhkkyeQlPmhYdel5WytMQ1wfPl8CtTrKFsfNE2wvEfSlB7DIQi3uOlk7tzyx/rjN5L8x6WP8vWtAh1xzYRIzhSxbGmcF+ktrgTYm5rmtrMiQQntc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb787dec99so6482781a34.0
        for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 02:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784626026; x=1785230826;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RR5FCwNxjoPJGnHWZgDvk/8q8sjW5dLGxnRh7VR12B4=;
        b=Q4DQu6bz2qY0VbhGApWA6bcxMNlzAvBnuE4ynkHhS+vzagTDkGxBA4hkPfrMEHrc4N
         6Cq6YV2m/i5Ae4ZZSUvaK0dO/qdc/k7pFtuNyCltD/co5XsaeaiMHk4dOGomVxaiT15t
         OjMy1iIRkCv76/vfSrZjLgIG67mZXXVcKcopXqYX+aFDHAlID0eIG7K6BlCvQDx0wyEz
         MCp9Qdc0vu/37lQA1ypg8/c5KWfw/zhwFPbZjTx6vdmFKpVJoV1xTJINB9BPEhX9zyKV
         vAx4mbq1A+aX8raRJIYwBawTuksqUlijyiZjK60o4bdE4v3qz2r/64EOu2wJNVu0roxR
         +MEg==
X-Forwarded-Encrypted: i=1; AHgh+Rq64DwvlypnfKwwkNy7CIJ5hTJnR08CM0Z3HGG0+rC6vyvX8D291gEKJJhhRj4wEsxVfLGJeL7tuBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSJA71pijuwrU+DFOGphC+C308G5uyos/mNDc+miHO/zfflUaT
	13zNbNbv2BMlKLCqO0xkisHND2j5iIuV+QwX/2E27x/Buy7jhgtHGgoEcXeblEztLA==
X-Gm-Gg: AfdE7cl1DlNyN6FTrX2aZMI7I+LLSs5GYFs1VwkLpFa2AUDO+VJDxjVbznIVu9qtqB8
	o9FEB1Gzi0yDmywLaNCaoMNNfC+VqWKSlnyqYmEirOsZYNJfofsl1Ep2LSRt3/OTiTBINFbzDcU
	5ogHQpUjE2aF2tl+RFsYqf5t0LFG/TNNJyZGBLcKJ5WSVx+a3D9LoreQkbJHxexMgXvxIu8rzpW
	eHleaXd06mgF+cbywzj1oNGM4ikFe4ge733IBsiDVvMKdDjaQs91XiJm1pT8s1E4UXgpgFZv4sv
	fAbKKaprgPqzRXVIhCTI9OyfbDux56A+X+YC8B7jOq1JsPnZF4LaiUWRmxHDOb2QSTw85ewkEKq
	LNn/bVVhaAb5WBvtPWFSk3ht3Nqkmr3GPnywrdNW+xB7Ae/7+NJliC/tmtAn+vJqsdwGb87s2ea
	l7A6S+bGlzCqImOcb4TjSVdiDPhDf2ab/926c8C5s4MlLjAVfPJhNbO4yQ27s6Z9Lnc5uXFhny
X-Received: by 2002:a05:6830:6995:b0:7e9:e5c0:e0a with SMTP id 46e09a7af769-7ed9aa4570amr10130321a34.5.1784626026131;
        Tue, 21 Jul 2026 02:27:06 -0700 (PDT)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edaf94a737sm10505207a34.15.2026.07.21.02.27.01
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 02:27:02 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6a376ad8fc0so3865622eaf.0
        for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 02:27:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RocW//KRiw5fS6nAI4TGeJ1OTFg3cbhUV6Dv2P5MYTFu4YLjMcbCK9g3BxPhqyl6Yil51JX0VhqxOk=@vger.kernel.org
X-Received: by 2002:a05:6820:2d03:b0:69d:f864:d35b with SMTP id
 006d021491bc7-6a5366c9239mr9033615eaf.23.1784626020645; Tue, 21 Jul 2026
 02:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-6-fourdollars@debian.org> <al81PmK1UMr2g8p-@wunner.de>
In-Reply-To: <al81PmK1UMr2g8p-@wunner.de>
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Date: Tue, 21 Jul 2026 17:26:49 +0800
X-Gmail-Original-Message-ID: <CAAT15mPuO71WbbS2ZpWjceCVj3FUTqHLi3wbbeV7B33JHbPRsQ@mail.gmail.com>
X-Gm-Features: AUfX_mzuuwPmHgyXw6Iyg2W8TacSMSalEGr-6q-lNvhwWPNzfRxZgwfUu10AhGs
Message-ID: <CAAT15mPuO71WbbS2ZpWjceCVj3FUTqHLi3wbbeV7B33JHbPRsQ@mail.gmail.com>
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
To: Lukas Wunner <lukas@wunner.de>
Cc: Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:18=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Tue, Jul 21, 2026 at 12:21:14AM +0800, Shih-Yuan Lee wrote:
> > On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller at
> > 00:15.4 suffers from hardware DMA handshake failures and interrupt
> > routing bugs, causing keyboard/touchpad transactions to fail when
> > DMA is enabled.
> [...]
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D108331
>
> In the bugzilla comments, Leif Liddy writes:
>
>    "I needed to modify drivers/dma/dw/pci.c to assign the DMA controller
>     irq value to 21 (which is what is listed in the ACPI table) for it
>     to work. The DMA controller was being assigned an irq value of 20
>     for some reason."
>
> It would seem better to fix up the incorrect interrupt number in a quirk,
> rather than disabling DMA wholesale.

This is a very good catch!

I appreciate the comment. Based on the Bugzilla feedback regarding the
incorrect interrupt assignment, it seems fixing the IRQ value via a
quirk is indeed a better approach than disabling DMA wholesale. While
I am not certain this will resolve the issue entirely, it looks very
promising. I will investigate the IRQ mis-assignment problem further.

Shih-Yuan
