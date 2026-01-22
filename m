Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39040F8EB
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079573; cv=none; b=eOzv23L4xedMKdD28qPAwmo0nKPBu9+tN5BdSVIBXfEAq7agWQy+42nhq5HxtzyNZJRsGi1lfxLc19xuq2N+rA4ofJfQIud9rDV1sQe9jvYvbNqIMcK4xY7yC19WEzYoAPqKeraoq5yoopAymQzsnyd50f0sC3W5MLqjSv8FEGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079573; c=relaxed/simple;
	bh=ksDGpOXCJytcfazjq7qr0daJEsBAjKRTbOfGaNZY/zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpnWU2YvI8qmYSih4Ii7pxiNZnSBR4dwMHDO5NNeIPPnlaJxUkv7JuwK0SoXvUm976jksKOsP6Uo9rzkfkYVTPT1/QnH1ecbK3F0H4cZdWmACwoqbS3rHPv4hxY/i2eZsTDEVwmQz10CA0PvB5I5xB0tWZ2YZvLp++9/OxC87j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5636784883bso636318e0c.3
        for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 02:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769079569; x=1769684369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/e1/pm7FOREOhCEowWrv0t0/89zmVnX1GYt8i07R30=;
        b=BSXZc5ggXvwEt5WGgheVb3umHgi8YkjtDCFbvyYwUQQkaoMT17OUrhIUbQlTM0/XH7
         vN5nRW1j54fqM3trC7sewLI7jtOXPC749oinl0aAUNLtOMwKJDfA/hjE2/hK8y5xzBWt
         Qcbhc0Tcw4KROiOWgRlK6r3OSuNloRYN5nVadjZ9WoWQUBD00m+YOUZsLeDknI9YmkTS
         N8Gk898knADusUZyeP412zvbiPOTWe7gHE+gxcX56sGcqRbQ4cELcw3bUzHpj1l/of6y
         Fh8aSwCVJfe+K3oVnU4fziNSuhpP1zZQWa7i6t/vcdMsqtxLrdY5L1of7nmPCUjyMJhX
         uw/w==
X-Forwarded-Encrypted: i=1; AJvYcCWiWMCdLN72uEuPS+fI+kKwrGQlsBoqXnQUSRVmW8yzKm3dFcEoQRxZ16iT2MNjirS7IX8ZR7X998I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLr3mwcypcJKch1eTmtNcvHaKhrwsEGDRN+oSEu2kXFEaMpEmG
	Arjlc6avSu/9vB1ojLt0h257elw9IgAVCYW4SY+j1H2G95Z05za73t3uP33IQk8R
X-Gm-Gg: AZuq6aKyAnA6Cvmv46ndBwi7u9uf261ofxhVPd8z6mbiOHZcDPIeXCmcR2Io2fhjNii
	rZuwurKHlLgBT4wKxRl8rBQxRg/srg6qB+zHVvFwcPWG4rtJuQAvrh3Qy1eJfi0lSgpsgPKtod/
	v0Ddz29BanzQZ8sfa8bAJL6xN2OqOXYAWhfHIaO1nk2MnvaBSaBnc6SsBPk8+2eBwUC23HnegJF
	hzzuy8983G7PGCFS9MlQuLEnwIuS9KLFxlh1LkoeuXT6sGkrVRTpuUI46BwRBnVroEMyROlC03P
	6H15ih+fu75+WfZx4AcxQusBZfgl8FuNxIwyrYwe5bSIR23G3HzMNX/Z62RsqL4F/xQkZkYXwZh
	G578cvTNLuyqRPcSSRtZWL2RRnp93iKvKV0uTBTreOvww3AKabO+P9IDFam7Mj0ame+ZSgAGV/w
	wozdTB0ig5f1bfTjL9DhVJrHPVDWqd0EcmZ7Q20lpP08Kdp9q/ls9E
X-Received: by 2002:a05:6122:20ac:b0:559:6b7f:b110 with SMTP id 71dfb90a1353d-563b72be161mr5786302e0c.2.1769079569562;
        Thu, 22 Jan 2026 02:59:29 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b6eae96asm4889177e0c.0.2026.01.22.02.59.28
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 02:59:28 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5662bb8c72aso615582e0c.2
        for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 02:59:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJbDc/F0Bo0Z1glFIZIkuud6MAnD/3/NiixJMHMifOtQJmqlbdVQ8Sb885sUmbMzxIKHYUbSlmrE0=@vger.kernel.org
X-Received: by 2002:a05:6122:2187:b0:563:68c4:16fc with SMTP id
 71dfb90a1353d-563b73d9bc4mr7241710e0c.21.1769079568171; Thu, 22 Jan 2026
 02:59:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121-schneider-6-19-rc1-qspi-v3-0-43e70fab4444@bootlin.com> <20260121-schneider-6-19-rc1-qspi-v3-17-43e70fab4444@bootlin.com>
In-Reply-To: <20260121-schneider-6-19-rc1-qspi-v3-17-43e70fab4444@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Jan 2026 11:59:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW=Ynyf=7r0GBv8g+-xi_3=fojnsmOC5AGWxrhcuTM2rg@mail.gmail.com>
X-Gm-Features: AZwV_QhU4HozNdnPn6smEIMJwpT1ZjcHd77zCQWsK-t2ckEMR3Gs7RNY1xtm8Ys
Message-ID: <CAMuHMdW=Ynyf=7r0GBv8g+-xi_3=fojnsmOC5AGWxrhcuTM2rg@mail.gmail.com>
Subject: Re: [PATCH v3 17/17] ARM: dts: r9a06g032: Describe the QSPI controller
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

Hi Miquel,

On Wed, 21 Jan 2026 at 18:05, Miquel Raynal (Schneider Electric)
<miquel.raynal@bootlin.com> wrote:
> Add a node describing the QSPI controller.
> There are 2 clocks feeding this controller:
> - one for the reference clock
> - one that feeds both the ahb and the apb interfaces
> As the binding expect either the ref clock, or all three (ref, ahb and
> apb) clocks, it makes sense to provide the same clock twice.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>

Thanks for the update!

> --- a/arch/arm/boot/dts/renesas/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
> @@ -66,6 +66,20 @@ soc {
>                 #size-cells = <1>;
>                 ranges;
>
> +               qspi0: spi@40005000 {
> +                       compatible = "renesas,r9a06g032-qspi", "renesas,rzn1-qspi";
> +                       reg = <0x40005000 0x1000>, <0x10000000 0x10000000>;
> +                       interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&sysctrl R9A06G032_CLK_QSPI0>, <&sysctrl R9A06G032_HCLK_QSPI0>,
> +                                <&sysctrl R9A06G032_HCLK_QSPI0>;
> +                       clock-names = "ref", "ahb", "apb";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       cdns,fifo-width = <4>;
> +                       cdns,fifo-depth = <4>;

These two should be dropped, as per the updates to v3 of 04/17.

> +                       status = "disabled";
> +               };
> +
>                 rtc0: rtc@40006000 {
>                         compatible = "renesas,r9a06g032-rtc", "renesas,rzn1-rtc";
>                         reg = <0x40006000 0x1000>;
>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
