Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5CA2E11DC
	for <linux-spi@vger.kernel.org>; Fri, 27 Feb 2026 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204088; cv=none; b=KyESwNhIJC4CkhhTiF7J6ssjMcWzoM6c77SbMigBbNq40XwV6IVs2oDaRZnw3PDwTjPJiOVcZJ5obtfpmbqCNmnuThFYAGUVub2vpPWd+/nB85ZusXKOCVl97Vev4aqNavwKVkJvN1VkB00et7jOokcASzMzxPvjR5KF4JyuzqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204088; c=relaxed/simple;
	bh=IbjpYjPyt7LrSqOdqijcKxV1tTGpTa+DCJfx1+OEgl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvtGO4EN1zFKp9rrHBk6RAC2h/bPEv846FwwzwZIpJ3vSBONXrXUxiiHxyxVnJW7v4CuKOXISCmx3PYpeFVVEuRpQOKriaP2Eg4e0HgEMNUNXPXiaKvDi/uDILeKbvuLihHXKpHqPXiZtj1T6db1gFPa7voWxsr4m21mVjIRcZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5688b9e4e80so2099486e0c.1
        for <linux-spi@vger.kernel.org>; Fri, 27 Feb 2026 06:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772204086; x=1772808886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Aa1HeQGt1TkOvVVQBH3CIgad0zCtpC8qvA4TYkUZFM=;
        b=o0YKnArgFeuyGnv6TIxfpj6Vn5M82OGouxpJiDA5I8hzmbUNkzX9mUDHKd6wF+DFwc
         MPsZ0bkrP/pOw5HGRmZm++BhRFRCVTpfVkITgT+/fQfjz/T3ayNoCk8O+9o4YuevsCE0
         1ehJwjIKuzwHDwWeq8/T1QHarnq7PMzebepOlgeg91OYNmM9VFzRmgTybSextJbrQQ+1
         Bzm5pFy+4gtgH7uEL5PQMq4YVxUoK+4arKP+fjnnIVt96WtUuW/DoQ1PMivCwUtxjSo1
         fBJhwxwn8q4z6ctAkrsQDG6C+DYn8DDHPHi9zG69eM/e38Ms0ytngS4PdGFMIQRVw4DE
         AMtg==
X-Forwarded-Encrypted: i=1; AJvYcCXCvE13sY/rKKV29tCEWsWKmIlr0sywo813HieykD2wq8WAqBNxwFxiBIHZ3FQTOSsj44VMqYVA/5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwERZr0BjDEY0WHkI2KzgoUJPOF2x3oJy+DboV2N+9F7yFOVoqo
	O3YQyRbFSSoFNkGV3HI2Jz2d2HFTCsxrFJ/PtT/iEwVVCZSOLkuBtGnxcAoY9mH8cy0=
X-Gm-Gg: ATEYQzyqiqn+8oOGAAYutsuvfhSahrJPGxs6xwPz1ThomF19CrkWR4PduwPHROwDogq
	HsMQfWF2ADN+8Jl4wv1awlpaYDKeOIzMYdUevjPJtIkwcYY0PQhJMGNNf8bKEn1st9ush7XAEbV
	1/QXvqbgKZhggeWotdxJW0Jb1kaYPG9HwLkLlAckDmqZ/cPGKV4yUuoKUt0dbMPbyOCD0k520+L
	ZFq/0uW4W/qcaiYWUL7OamW7H9qgyhptW9gIfcL3xOVbeGArokHYLJkT+ISnG1SfAyiy4+GULwO
	OooVu7UOkNl/JOJgw4QgeEAPodugNckRI9nyath3pDIV8cAdnO0QVgFs1R+gs9ijEXImk7m3mzk
	qVaNgP1Ubt2DsQOBjXWbEIlrMfiylfIIddsOqdQRJbO9TJCMZFLAvq1CdYShTBjj2j5lfLTSD00
	jB8k8R+jz50fXCULO14sLaNY6/ZjtuIxK37ks6Wmyh3A74/u8z5N3RoBRerCJT
X-Received: by 2002:a05:6122:6588:b0:56a:9fdc:2139 with SMTP id 71dfb90a1353d-56a9fdc255fmr2034627e0c.1.1772204085741;
        Fri, 27 Feb 2026 06:54:45 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a9204b91esm6435889e0c.11.2026.02.27.06.54.45
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 06:54:45 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5fdf71f3327so2211337137.1
        for <linux-spi@vger.kernel.org>; Fri, 27 Feb 2026 06:54:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoRxIXuvvJx8lWCkKr8QYgK5t2/PEq3BMferF3QgSzxs2Ks8pbaGLm0yNFyPkZ7boG2kEP8zSiwYY=@vger.kernel.org
X-Received: by 2002:a05:6102:3a08:b0:5ee:a6f8:f93b with SMTP id
 ada2fe7eead31-5ff1cda999fmr3969088137.2.1772204085197; Fri, 27 Feb 2026
 06:54:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128215132.1353381-1-cosmin-gabriel.tanislav.xa@renesas.com> <20260128215132.1353381-3-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260128215132.1353381-3-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Feb 2026 15:54:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVeH3eWZH6-b4f-cTY4W3Tyi+ibfkJtE5A_-J=nwqNB1g@mail.gmail.com>
X-Gm-Features: AaiRm5123zFOGxobgOmfUt0Ahb4WpCv50faXTjLep6czwjGjFva_w8fossmC2MU
Message-ID: <CAMuHMdVeH3eWZH6-b4f-cTY4W3Tyi+ibfkJtE5A_-J=nwqNB1g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: renesas: r9a09g077: wire up DMA
 support for SPI
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jan 2026 at 22:52, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> RZ/T2H (R9A09G077) has three DMA controllers that can be used by
> peripherals like SPI to offload data transfers from the CPU.
>
> Wire up the DMA channels for the SPI peripherals.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
