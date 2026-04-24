Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8035AC3C
	for <linux-spi@vger.kernel.org>; Fri, 24 Apr 2026 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013250; cv=none; b=uz1HxC8MnhGZRCRvMMAKy/5Q31utdfwoYSx4j4vdLgmHEsKeIjfPqPd2t1pgvPg/1BcrT1x+FdtIUDJURFtoMv6DOddseGSySCbiW0rnBDrIEmVIc06k5wtH70OusgbMxkypHNC3EEPNP32h/MOyGa1xNW8Fy0joKBhTNC+MTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013250; c=relaxed/simple;
	bh=hPjbsKLyqV83oL2QS75IvKJ3APLZq8Ze2ke8fdqV9C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jxx6Ja2poW+Wi6b+7Bz2rotZ6WVWCn+8+FdQAW36zehsldd9+I9OqAV3ur1kekjGTycq5p7bGc2jZci3iOpnENxYYKQzAJfM9VmZQUyZ8cZbB9FIrUjBFEeeBmseEYsF0Aya0+Yzg1k1Z7fd1C/ahDOkJD+sw/3AWqiDlLkTtzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56a86f0a23bso7156852e0c.0
        for <linux-spi@vger.kernel.org>; Thu, 23 Apr 2026 23:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777013248; x=1777618048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bu0q45d2E7oLscYVPbeGMb4gT2YaXOimO9bdtwCxdfg=;
        b=kq0iVqTiO97KRlHDkylUu+0zZdkMecH1V3it7jbGRQfXIFoR1vxKCqWk4+LLAXuH5U
         WxPT0k3YKMZbMeipvprmN9Un/0B1/a7p9XyNociCZSqHH7LUe9UUYK859BjmMEfi4CeA
         b0KSl9mPrs4G9a3yKKJQRcdcI0wozQKOdolTbZ0Ot4YVYbsvVS0M3fbXy/p8ORYK8/hq
         1It3pQ6fFmnGdsMNQ8+w2B+4zlOc1xcsVLz5/Cvo5IrsIZI2BTCGJD1FbedpflNjYkjJ
         5FJLpgVry05WdsTMtxJ1dFTtVTygwrm2C37kebBAtpODKjMRuOyPamilApiPUZjiEduF
         7zJg==
X-Forwarded-Encrypted: i=1; AFNElJ97XAAUsJhglmLS9NO/I8os6QqAoPD3nU7ZqUn54xZd1iNE+iH/16AiE56Q1VewkVdPaUlKU9xIWrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2GKAUtFwl2BcRHn7ueVI48k4UZlVEj3LSOcggIAMiTYXCskBx
	gJsC7dveG/0dkSt3HpZ1ha/2ZkqnJqrrw8FeIxaurs9leqGmDUXqFglHbICCEPw56zk=
X-Gm-Gg: AeBDietW63F2zDa++s5kYiarCfe+/AT/z9Vgk/qGPW5K3FeD9QReHXAmaVWnxaz/pwT
	dCNDphsvrml6rprGd0d2RaHdSuPZnuksVxvkGKvQp8HAJfi6PMeJnMfj6/TT7vOb53ZAWHEkj4j
	FEthpkHL5mX6xACKCgYcL3EzDy6IqFnvq09FVMSO7DusTq/jNWZt671rhQfelAmjAtN+qU4XHdW
	EnjFzZsy9VjO8ccEudPtARloDx/EEk5cc8ci5RcOz4AIbKfiVGqUoL/o6nAaXBe/0Ho2YIEpkgT
	lHyCZjwL3kid4lxWbUwqjXJDei252lfutAGpR5VzXIb+aUlUPpAcLhLVLFChLwnJP/2lwF1Mx5u
	bBR22Nd3CAkIfzXgeJ2DTG3wRi1usIg3Zi+vRUWW8bofGSDf6TUez45+A/W3tsBHfpJsJ16o5Kp
	OxW18geZWwFlBMQckpNgVXtyGCcyHE9sdXDGLnqomPCFgeSz8jOaJhdePAJgcVKPkzxyZYPiwZX
	GQ=
X-Received: by 2002:a05:6122:2888:b0:56d:439d:d055 with SMTP id 71dfb90a1353d-56fa585ecf0mr17297776e0c.4.1777013248118;
        Thu, 23 Apr 2026 23:47:28 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91ed4e1sm14159829e0c.6.2026.04.23.23.47.26
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 23:47:27 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56db1b3626bso4888457e0c.1
        for <linux-spi@vger.kernel.org>; Thu, 23 Apr 2026 23:47:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8iztDLxtUGcRH2bZqIbP+p8ENX+ClgwKQQcqbGorhr0Z3kX0yTfDo7KRNF3xDEFUwf9QLoJFdbeoM=@vger.kernel.org
X-Received: by 2002:a05:6122:3a0b:b0:56b:7d4d:4d11 with SMTP id
 71dfb90a1353d-56fa5808124mr16742384e0c.1.1777013246536; Thu, 23 Apr 2026
 23:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402131020.143123-1-biju.das.jz@bp.renesas.com>
 <20260402131020.143123-2-biju.das.jz@bp.renesas.com> <177628854701.543173.16954025159083410550.robh@kernel.org>
 <TY3PR01MB1134691789E55E415E315658C862B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB1134691789E55E415E315658C862B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Apr 2026 08:47:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWh3gRhr7V632Mjn-feMrC8j8v8UvaywUtsEFFrKLjZ8A@mail.gmail.com>
X-Gm-Features: AQROBzC_m7I4rDcckretBHhnhJcFIfI0ico-cqvyKrDaP8xZGRyxWrRj0fSwhbA
Message-ID: <CAMuHMdWh3gRhr7V632Mjn-feMrC8j8v8UvaywUtsEFFrKLjZ8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: renesas,rzv2h-rspi: Document
 RZ/G3L SoC
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, "biju.das.au" <biju.das.au@gmail.com>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>, 
	"magnus.damm" <magnus.damm@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 24 Apr 2026 at 08:29, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Rob Herring (Arm) <robh@kernel.org>
> > On Thu, 02 Apr 2026 14:10:16 +0100, Biju wrote:
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > Document RSPI IP found on the RZ/G3L SoC. The RSPI IP is compatible
> > > with the RZ/V2H RSPI IP, but has 2 clocks compared to 3 on RZ/V2H.
> > >
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > v1->v2:
> > >  * Collected tag
> > > ---
> > >  .../bindings/spi/renesas,rzv2h-rspi.yaml      | 26 +++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > >
> >
> > Acked-by: Rob Herring (Arm) <robh@kernel.org>
>
> FYI, this patch is superseded based on Krzysztof's comment to avoid
> flexible dma names for single DMA and the patch hit on [1]

Sorry, I don't understand.  The patch LGTM and is already applied?

>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20260423&id=5277c291968d87c6a093f50ef489df9d52cb3ca9

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
