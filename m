Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA773168F7
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769694760; cv=none; b=L1wmhO3IcDXXKcBy2ARKgdveXUMkA3QYil85is6Dtr3zX/mHC+OCbdVGmKSqJwto5BM2L3H8GMJ7Mc/24VjUfxhLBYUQlRD1asvZLtqrC71YOBp9seuTwHqln8G/Hkv6Omg7VE8fOZp4u9G0zETlDyTYxIZbcxZrc3hGJIz1QX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769694760; c=relaxed/simple;
	bh=OXzBgdseIChVS+vJW71bIGbvoMjbawETEFTQgROB3B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekNpmOvHnIMDSmn7ZTlp5QcewS6cN5fecied6Y9NG7KRE/XhYXGZoXoCoT5Qmzt/WvEJs1c3D1qJO2bPmUAKfl39XFNE4hEOguelEAjyM3VmNLVWWeuTyEIxSGEPCR3H9DxTLzjl/IHHSsZ57iQj4/bY1oh66sR0/11Sfd1iYSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56376c3e866so699323e0c.3
        for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 05:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769694758; x=1770299558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Si+kB15qA+G+h2zKRmC1fubtEccV/Y2DT6Bt85BeRM0=;
        b=LL+Zr8I+4gAq0ch2+ui5AlbdPmCcoXUdRpXa3WO3vlIIVLnEmeLL04irbAGC4aSxpy
         Bnyz1YCWKpisI+pN6xgxAKGdby0Qs4dI4uVL5XB/NqkPSZFRAdap0DP/UX1xLrFiRBsz
         tOyy+9KuB8MFR+mstLDblgCqWdbf44A873tbRpQpOqW2t2hi2XswZso3MJ3wYqjxYL5Q
         NsJ2SkrnEUndT8+gb5emQis2vXvvUpu3rYpeeHRtNB+PmONkvjX4Ci326BfMiz7JGTZq
         JzIEk8SMGG282sxKzJ2FsC/XUGbc6PczGJVSl3jNP2EsN6eJRULII2yTrkp6wfXrTU5P
         QcYw==
X-Forwarded-Encrypted: i=1; AJvYcCWg9cjsoWiiXxLtkVUNj8OWYgoPpOWY1xS1nLK9iQjPrfPuPU2y+bz8bwIghoBp3ir+XlzWIQW3N4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY72bsPJNl2tdv33C+wo9cgQuXCVcYoA4iSYe4M6gwKQh7IWZl
	2s35ShwYWtCOWaFwo8BIfst7SFzumCZijA3MPg87WtZ9rvCVllSX3nqF13VA06DM
X-Gm-Gg: AZuq6aLyiP4bnqTZs3EvJXb1cVbWsgJixqvyR+qE3v13ZvfWzbJm3xWDf2tyuSQuldB
	RZKCh+JM3nkFA9tCuBIC7Jb5bwHKhhHf+FTnluKlToBokSSJoJyYOvfkYWAzdU9VgcQYFJR6bfP
	PvuIVw7lrSgPU2fkgLQSJaGJQAeCfd9QBk64MyaMu1qq0KCqKEId58Mti5zd/t+s4yi5U2zkXHK
	ZPsWbG9yFl1aL66kMRbnXJq486hdDPAeGfdSxZLcDigfO4yornx7XURVEaQ63Y4kMs8rfoOYR4B
	NR5I2Du8HFon0y+PkBBiz42JLZsBejpdmjpQoFnZosO+aWBtTt34h9+R/hbcsCcQxKd3v6Is50J
	zQv17oYrDhgchxXhVrnXojFi1jKomM5ApqGDstTSLjdtPihzvn+iTTtlB/LyC7v+Sq5ZQRR1kgx
	uZvXWt/58vhadm7flPN0PZISfz2AJmBKqCU9I0/BRB49/30e06
X-Received: by 2002:a05:6123:14b:b0:557:b52a:d553 with SMTP id 71dfb90a1353d-566794f2c4bmr2965368e0c.7.1769694757939;
        Thu, 29 Jan 2026 05:52:37 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685d09648sm1170143e0c.17.2026.01.29.05.52.37
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 05:52:37 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93f5761e09aso585803241.1
        for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 05:52:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1L2WYdnWHFCPSl2obNuh+KHu2qghSpEZSBRWtGRAgbJwZ3abVAs6dSl7f6+qh9Ci9U6/JktQHh10=@vger.kernel.org
X-Received: by 2002:a05:6122:4d89:b0:566:2fc9:6c89 with SMTP id
 71dfb90a1353d-5667959f794mr2859782e0c.10.1769694287318; Thu, 29 Jan 2026
 05:44:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com> <20260122-schneider-6-19-rc1-qspi-v4-14-f9c21419a3e6@bootlin.com>
In-Reply-To: <20260122-schneider-6-19-rc1-qspi-v4-14-f9c21419a3e6@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Jan 2026 14:44:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU1QV6Ww--D8kycUmL_sFen_Qf+SXHAZJnF31J0NRtsAA@mail.gmail.com>
X-Gm-Features: AZwV_QhJgRHOyRufUmk7eheHuZ8kMGAesh49iuPJzs_rWC6vXd0jVMaBYCvLTBM
Message-ID: <CAMuHMdU1QV6Ww--D8kycUmL_sFen_Qf+SXHAZJnF31J0NRtsAA@mail.gmail.com>
Subject: Re: [PATCH v4 14/15] spi: cadence-qspi: Add support for the Renesas
 RZ/N1 controller
To: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Vaishnav Achath <vaishnav.a@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Santhosh Kumar K <s-k6@ti.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miqu=C3=A8l,

Thanks for your patch!

On Thu, 22 Jan 2026 at 16:14, Miquel Raynal (Schneider Electric)
<miquel.raynal@bootlin.com> wrote:
> Renesas RZ/N1 QSPI controllers embed a modified version of the Cadence
> IP with the following settings:
> - a limited bus clock range
> - no DTR support
> - no DMA
> - no useful interrupt flag
> - only direct accesses (no INDAC mode)
> - write protection
>
> The controller has been tested by running the SPI NOR check list with a
> custom RZ/N1D400 based board mounted with a Spansion s25fl128s1 quad

"RZN1D-DB"?

> SPI.
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.=
com>

> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -110,6 +110,7 @@ struct cqspi_st {
>         bool                    apb_ahb_hazard;
>
>         bool                    is_jh7110; /* Flag for StarFive JH7110 So=
C */
> +       bool                    is_rzn1; /* Flag for Renesas RZN1 SoC */

RZ/N1


>         bool                    disable_stig_mode;
>         refcount_t              refcount;
>         refcount_t              inflight_ops;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
