Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342913B14D9
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094989; cv=none; b=QJDf0muhcKcmsYU/NUc7goZKmGrFU47DxopRUibabii43qTKJ6oPi+G05bmKzPofg1P/LNm54UxsbPbX0mB9zZGoWBIoFtaC1K2+ax+xjzKAVjW4CN6VN88bH1tRc5EXpVJEDvt3dbkJDeD/3WVDPh3qwpjCsTnogKCfi3cZjpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094989; c=relaxed/simple;
	bh=1jaQI/yXwfNl56dzYfed7eyhyT0Bb1rMZNDi1ewH0oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKtHNbxOkZNkViw6fJ6Rb2oSrnUtHKIFZu5P1HcSoz7auXFvcX1MYZpsCUtcoCaJw5KTlfp+NPAQjdH09ottviIsxHt7b8sZhkbSvXOl3OMH0pGKkbilD+T4Drl04CA2mTJs8SM1YWiGAnx2h4hTwkeZqry2/bPaOuJVpFmQw+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so13224423a12.1
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 05:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781094986; x=1781699786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnkRL9A9yLDp0586KseS3kXnfXEIgenVBxyMiwtAEuc=;
        b=MjYlikkjYzIhpo0zDTg0/krljAZr/OSLPS6jQAYdfYoKGnFHjmcpp6HRQMCav1WDDn
         bqpizzcen+1XBjJ29GWSWGjyBn0SgdsFsQLX51djJ9qffgbg4fG1EHQ5/Rm5iE22M4Qp
         BOkoWIzXINrCbvaVt2r7xayq7CcsAIAwSMBbNDyH0TlZxpp3FPOQbQ0LhUeKwsOJye61
         +8VeiiNhnv+zIp3Y1dNHruBKpmxjVeZykOmG3S0P4UNHPZp9utEs22RCpkUEHc0hDq6U
         Xpcqil8IXndDFWzhi3g0P55D3KEcxCgPMtteaAMR89vIDz3fDYV1r3Ws/zi886WqQwhK
         6h5g==
X-Forwarded-Encrypted: i=1; AFNElJ+UgDuhvBkBBXqBKVmSSOcNBgIo1hfmQll7GC0wf1NDRVUaGXRJl5biv3Ey5NbmkLJH/19lhJu9X30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTdw0SI4xEEqUKbzKGimcWD2rnFI7lzLnK7I06aGiUQWBCpsuu
	7jdtn/wWh9ikch7L1QBxJKLVTBwnbinvQAw0/cVsbt+qeOsW1r0pJgIkl+Om9iri8/8=
X-Gm-Gg: Acq92OHKwQ+w83Vz4AscUGFix7j7uX6tO764AMjfOV1hqTTrOk4UMsbvx/L7n9qci0w
	oHnVrcK/IajcnbmtDwxgMZ23m7KXcg76PDWRC8K9izv96YIIUMXa2m9e4E+LRNEHW7AMepm3l5i
	HQJVg9+j8Y1kD1rw2A8N2llJxCuF1rlM1dWklCCN5pQ/esVTCgI2H6mG69Q5wl4nig3ihdwgnlm
	Rzmmip7jPW+/ZxNuOSJiiie8qOFWE3sCvfr2Y44JHaqOeRyRRIMivMMDCrTc4XcUAufrj50dWRC
	smBq1I2n/50CTupx2XnLEUHFhVNL+RlhV8ad/jfSGPXt2a3kNjdJgYwMNkFfictsr0Sd5At0YsY
	n87YrgK6HXXHKietYZ5aeF/9WDP6cyeDQV52BJ9dpcx/++as/GUu8qT49q6w+Yk4nOOF1FTjww9
	mRkY+9cxxb8ihvgln1rdc5uglpzZRMvyoeyWPzl8O9Dg7DYZ91kFFVtx2tXxUtaOoaH/V+5rk=
X-Received: by 2002:a05:6402:1cc8:b0:670:8acb:e822 with SMTP id 4fb4d7f45d1cf-68fa5038772mr11121533a12.12.1781094986468;
        Wed, 10 Jun 2026 05:36:26 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-691afe82416sm4398481a12.13.2026.06.10.05.36.24
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 05:36:24 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68cec9f4c6cso9409784a12.0
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 05:36:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ85YKCOw4Zm+wyELdVPfsTmHaUMskk4kTAAP/+TtQhDDOjlRvfrzJ7GT2ImDPOKRHRBGVbdoddNHsQ=@vger.kernel.org
X-Received: by 2002:a17:907:6e9f:b0:beb:7979:47dd with SMTP id
 a640c23a62f3a-bf3738f1f81mr1412187766b.27.1781094984425; Wed, 10 Jun 2026
 05:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-rzv2h-rspi-v2-1-40c80b4a2c90@gmail.com>
In-Reply-To: <20260610-rzv2h-rspi-v2-1-40c80b4a2c90@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Jun 2026 14:36:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUyj-6zNhkZR4SRm_F-JK1QKnpPkSvzK0Z+TSE58yq3BA@mail.gmail.com>
X-Gm-Features: AVVi8CfbEH3Hc3J2sCeattAV0AJLSnQxbhugQPZSnzmY28ff2IF_tFxiTy0lV70
Message-ID: <CAMuHMdUyj-6zNhkZR4SRm_F-JK1QKnpPkSvzK0Z+TSE58yq3BA@mail.gmail.com>
Subject: Re: [PATCH v2] spi: rzv2h-rspi: Fix SPDR read access width for 16-bit RX
To: Felix Gu <ustc.gu@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jun 2026 at 14:08, Felix Gu <ustc.gu@gmail.com> wrote:
> The RZ/V2H hardware manual (section 7.5.2.2.1) specifies that read access
> size for the SPI Data Register (SPDR) are fixed at 32 bits. The

is fixed

> RZV2H_RSPI_RX macro for the 16-bit data path used readw(), violating
> this requirement.
>
> Switch to readl() for the 16-bit RX path to conform to the hardware
> specification.
>
> Fixes: 8b61c8919dff ("spi: Add driver for the RZ/V2H(P) RSPI IP")
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
> Changes in v2:
> - Fix comments from Geert.
> - Link to v1: https://patch.msgid.link/20260605-rzv2h-rspi-v1-1-c1d5ed562249@gmail.com

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
