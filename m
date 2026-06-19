Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62878372EF3
	for <linux-spi@vger.kernel.org>; Fri, 19 Jun 2026 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781864694; cv=pass; b=EllOMO4foHvYwfE2McHZyNsrKQNksMRU3dkZXtFFHnlmZmPgJOT7x2IOm0YHtpfXo5vgKkNK12NfKyPcah+O/L02mdeVPWa4E6E0Ym5N3wG6zDFExKVNpvB5ZehelpXYQ60l51D0TKb6JNhDL8eQDORBvRICWJF4zxSGEZVsxMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781864694; c=relaxed/simple;
	bh=ni/12ceZsW/f1/rf10e0NeNiqZaIvmVbzOgM9UdT9bo=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIl6jXXbJFe1w1TIUpSNkq0IJSSJikYRThn88SajLjBBjBLEx7KFMIcXGxIjLjw2VfYFwvQa/sd2wYvyp81zpP/l4hFWylFezmewRA5gglQZNl15JH8UcgOHDiCmd7Aena2z0hpVJsyTNWWBfwTRQ+0a8qIIgLO8APEtmsYz+FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DVuV13ZJ; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="DVuV13ZJ"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c0c15bd6b8fso202766b.0
        for <linux-spi@vger.kernel.org>; Fri, 19 Jun 2026 03:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781864687; cv=none;
        d=google.com; s=arc-20240605;
        b=ga9CMyIpQmMCtEYxKHWyf2Oy3korkoAdO6hwOmoH0udTwuR7E5GSQWOMhmO7P1tgQz
         goobCIRWvu83mUdYeDElSTrdMQqqhPzoBx1Dos+LFI3qLYWPfW/BL4PR0I8I+bwsJTlk
         kK2RFTxFypEVqiVlSrCBBCiwNYo0yAZXgXnSyA6y/K0wpIkUB6CC3hgOFMCMBoXPB9wE
         IscZnjmo1yXrED0SAn5Q+1dc9N8BntprHabj28XceAO8Gpmvbo647Xiqlpd7UkMHr7Fb
         gUakGyMLR/XxSPWTxq0wqkRebCwYOC6Hc3EZoTonJ+CSKboxaZjHV9GA5IQYk+UqihXh
         wODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=EqKnecBtz91u9GFBS0SkA37VjcFvmopZ2JwgbXFMYUM=;
        fh=Mx1s3NKewz8Qv5zqLXAcxaluiPNDXd/hmttzdwjYvZU=;
        b=LYCaHZrj3iE0iAb80cdoVAYs/grhIBGBV3nQUe6GTQ38HhtaTpzxSlgNgGQhmFPlZk
         UktCWPkXaC3dLmAh9Ki5jhnI3cxmcZLct5VsxmgC4qPobvlqSbDw88+8qBwkV0Xj8bUa
         gKT7i0JXeBCPTtID88LnqdLM4awQzeTNeQaOj85LTTPjAAZiApjrfcr1oEvX6Ws+ehtC
         lzNng85ZpwEVvcldfP+GwYcDoRb9TCOi8FRJ9VXn+1A/9TJHiURtE/hE8oiHFHcknp/B
         1yX/0X3O2SHLhG/a+LRWxDnADQi2gh/9Q/0QaarzQ3j3nZc2aIYO3mJwy0J/1xaCZtKT
         k1YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781864687; x=1782469487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EqKnecBtz91u9GFBS0SkA37VjcFvmopZ2JwgbXFMYUM=;
        b=DVuV13ZJQA4cwjxq5qn5w+4fYtykWO7KQnr5FcmRgeOerrN4yQWr68pqhbw8W92+4m
         Irc1EwZS1CTi412HTYPErXss2meyHGeXjEZwu9JsfE/tpu8zqpqTipylsssCP1K9k85r
         HMY9Cg7VUp+jVhhoUJtRsl/zBf7vQWSxVNjJe/ROl34txpn1e964Yz1N/DEvFa/MSzN8
         uR8/gNdi/kQNZNC8o+/0PjmC9IEr+9wQQHDGPfggJlo3dVLjC1z3d2DUIhq9bM9Gv9di
         edYIOqTRtvSuNlu8LQRBfSwqeRnU7gwabLMW1l6jvP+YNmsB4gXCK6E51eqKZCwgdpaW
         kOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781864687; x=1782469487;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqKnecBtz91u9GFBS0SkA37VjcFvmopZ2JwgbXFMYUM=;
        b=qwFTiAWT8Aa24yXRd1IJNNzPo5gyjazQEbKDvtzKetipE7hq45GuwvKEBYMG3Xp4r1
         dMahCL7hxrcGwpnabQ/GGSrud8mBJ/6x2MBCcXen2k+bnku3QNHDsUYZlkf2oZMquyJg
         mS2ftHhgKHRaVR8yxsx0sIWjsqQC2foHCKwJV/boT97hR/0t99HAcH1YrfgKpF48hZMm
         9Zmp9I2cnugZ6DQgHVRlOFJ2CKjr9QrZt23N9nFKlYvoYDsyzJLE6sbArJnxgPlyg4ZR
         7thmKL1lfpcGVjASuyfBnQ79ZeHXkyFTP+zsO5CAUpZXjcSRt2G+AHlujQm3Xlw0MqT1
         Evww==
X-Forwarded-Encrypted: i=1; AFNElJ+GsUSSh27QC/blfNphj/DxquoBNb6EEaD4OBVuJlBPlqz58C1aCMa3p/njuJO+gtrsuhxn4BMXwRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+ZX/Tfm4oeDHoRighFOz1R8ORcVsbUfE4EbilmI/+fqEbT5l
	f7j9jwQzZfI940RWhSayG2k5F7ktHfvrCy9lW7wWNEMdyx+051pxLgz8Oy1+d8VP2OGz0xJ3J3S
	r7OGW4TqLpRj5qCgOu1MDjuw+KGDd6UqBcHFpdUhP5Q==
X-Gm-Gg: AfdE7cllsUap2r2KfiwFBsH6g7D1o7yND76c9qL9G3gY3s8PbpJ96zvxmg+gKyTxrKg
	y9z1egtu8InHEBd+OU1uwA+8CmrapfqMbWnuYwMQz7pxfotvih0LmEDunWuQSYa3JrhYrUgoLHO
	8wsv+NS/9aUuE81QDZGFNgrROd+ZlelwvdQTf8nGZlgzcS4Fa6iSdUCbpXmUOPtSPsbIEm40f5B
	AM3i+PB/Qhn3CsplFLCUWvzH2UFRVDRmfEK5lLsL2sq65LxMXLkpU6/La/wpiQ7LI4Q0Zr1fflz
	NenNIfU0+b0UG6ev32ByLd38vg==
X-Received: by 2002:a17:907:a786:b0:bfe:ed74:526 with SMTP id
 a640c23a62f3a-c09901bd9ddmr153293866b.53.1781864687277; Fri, 19 Jun 2026
 03:24:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jun 2026 03:24:46 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jun 2026 03:24:46 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260609142139.1563360-1-gerg@linux-m68k.org> <20260609142139.1563360-5-gerg@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260609142139.1563360-5-gerg@linux-m68k.org>
Date: Fri, 19 Jun 2026 03:24:46 -0700
X-Gm-Features: AVVi8Cf5uu_-jErGjE81PbtvCv_YT7XlmD0BhPjrXgKYB7qRKbzp8TAf4rZ-9HE
Message-ID: <CALSJ-wBLOaQ69+Hy5sgYoBr=fx654sfcfw7du1O1p89B=1gF0A@mail.gmail.com>
Subject: Re: [PATCHv2 3/4] mmc: sdhci-esdhc-mcf: do not use readl()/writel()
 on ColdFire
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	arnd@kernel.org, wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com, 
	imx@lists.linux.dev, netdev@vger.kernel.org, nico@fluxnic.net, 
	adureghello@baylibre.com, ulfh@kernel.org, linux-mmc@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, olteanv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

the driver behaves as before, and it is not using "edma",
but his internal dma interface, no new issues are introduced.

Over testing btw i noticed a possible issue, totally unrelated
with your changes. Will fix it eventually.

Tested-by: Angelo Dureghello <adureghello@baylibre.com>
Acked-by: Angelo Dureghello <adureghello@baylibre.com>

On Wed, Jun 10, 2026 at 12:13:00AM +1000, Greg Ungerer wrote:
> The implementation of the readX() and writeX() family of IO access
> functions is non-standard on ColdFire platforms. They check the supplied
> IO address and will return either big or little endian results based on
> that check. This is non-standard, they are expected to always return
> little-endian byte ordered data. Unfortunately this behavior also means
> that ioreadX()/iowroteX() and their big-endian counter parts
> ioreadXbe()/iowriteXbe() are wrong. This is now in the process of being
> cleaned up and fixed.
>
> Change the use of the readX() and writeX() access functions in this driver
> to use the recently defined specific ColdFire internal SoC hardware IO
> access functions mcf_read8()/mcf_read16()/mcf_read32() and
> mcf_write8()/mcf_write16()/mcf_write32().
>
> There is no functional change to the driver. Though it does have the
> effect of making the IO access slightly more efficient, since there is
> no longer a need to do the address check at every register access.
>
> Acked-by: Angelo Dureghello <adureghello@baylibre.com>
> Tested-by: Angelo Dureghello <adureghello@baylibre.com>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> ---
> v2: moved from RFC to PATCH
>
>  drivers/mmc/host/sdhci-esdhc-mcf.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
> index 375fce5639d7..6853521e8b2c 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -55,7 +55,7 @@ static inline void esdhc_clrset_be(struct sdhci_host *host,
>  	if (reg == SDHCI_HOST_CONTROL)
>  		val |= ESDHC_PROCTL_D3CD;
>
> -	writel((readl(base) & ~mask) | val, base);
> +	mcf_write32((mcf_read32(base) & ~mask) | val, base);
>  }
>
>  /*
> @@ -71,7 +71,7 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
>  	if (reg == SDHCI_HOST_CONTROL) {
>  		u32 host_ctrl = ESDHC_DEFAULT_HOST_CONTROL;
>  		u8 dma_bits = (val & SDHCI_CTRL_DMA_MASK) >> 3;
> -		u8 tmp = readb(host->ioaddr + SDHCI_HOST_CONTROL + 1);
> +		u8 tmp = mcf_read8(host->ioaddr + SDHCI_HOST_CONTROL + 1);
>
>  		tmp &= ~0x03;
>  		tmp |= dma_bits;
> @@ -82,12 +82,12 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
>  		 */
>  		host_ctrl |= val;
>  		host_ctrl |= (dma_bits << 8);
> -		writel(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
> +		mcf_write32(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
>
>  		return;
>  	}
>
> -	writel((readl(base) & mask) | (val << shift), base);
> +	mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>  }
>
>  static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
> @@ -110,24 +110,24 @@ static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
>  		 * As for the fsl driver,
>  		 * we have to set the mode in a single write here.
>  		 */
> -		writel(val << 16 | mcf_data->aside,
> +		mcf_write32(val << 16 | mcf_data->aside,
>  		       host->ioaddr + SDHCI_TRANSFER_MODE);
>  		return;
>  	}
>
> -	writel((readl(base) & mask) | (val << shift), base);
> +	mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>  }
>
>  static void esdhc_mcf_writel_be(struct sdhci_host *host, u32 val, int reg)
>  {
> -	writel(val, host->ioaddr + reg);
> +	mcf_write32(val, host->ioaddr + reg);
>  }
>
>  static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
>  {
>  	if (reg == SDHCI_HOST_CONTROL) {
>  		u8 __iomem *base = host->ioaddr + (reg & ~3);
> -		u16 val = readw(base + 2);
> +		u16 val = mcf_read16(base + 2);
>  		u8 dma_bits = (val >> 5) & SDHCI_CTRL_DMA_MASK;
>  		u8 host_ctrl = val & 0xff;
>
> @@ -137,7 +137,7 @@ static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
>  		return host_ctrl;
>  	}
>
> -	return readb(host->ioaddr + (reg ^ 0x3));
> +	return mcf_read8(host->ioaddr + (reg ^ 0x3));
>  }
>
>  static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
> @@ -149,14 +149,14 @@ static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
>  	if (reg == SDHCI_HOST_VERSION)
>  		reg -= 2;
>
> -	return readw(host->ioaddr + (reg ^ 0x2));
> +	return mcf_read16(host->ioaddr + (reg ^ 0x2));
>  }
>
>  static u32 esdhc_mcf_readl_be(struct sdhci_host *host, int reg)
>  {
>  	u32 val;
>
> -	val = readl(host->ioaddr + reg);
> +	val = mcf_read32(host->ioaddr + reg);
>
>  	/*
>  	 * RM (25.3.9) sd pin clock must never exceed 25Mhz.
> @@ -245,7 +245,7 @@ static void esdhc_mcf_pltfm_set_clock(struct sdhci_host *host,
>  	 * fvco = fsys * outdvi1 + 1
>  	 * fshdc = fvco / outdiv3 + 1
>  	 */
> -	temp = readl(pll_dr);
> +	temp = mcf_read32(pll_dr);
>  	fsys = pltfm_host->clock;
>  	fvco = fsys * ((temp & 0x1f) + 1);
>  	fesdhc = fvco / (((temp >> 10) & 0x1f) + 1);
> --
> 2.54.0
>
