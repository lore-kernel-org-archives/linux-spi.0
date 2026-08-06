Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF714C9579
	for <linux-spi@vger.kernel.org>; Thu,  6 Aug 2026 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044792; cv=pass; b=b9Or+HWLNv4j+Eqqe7x0DmTwgBBIUyz2akbSwfSJSWC+dN8FefQMYYbK5WJ7YJgavur2Z58Sx92AaVIz5JgcWco2mJuNMCmeZarHJAUoFlCMRL6aOKU2gl7QdV0vpc0xH+TN30KLsg5G13kQ/4TiMudD0BM4I+kFuOQFOQXhO2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044792; c=relaxed/simple;
	bh=mFDOjPwGZDFc6PbCyPa1fT2cRiIAZWrtnaU+b2kuGOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0C3EswhVLI3urbd0tCyquZzkAhSHApYQO0fheFmM5GRNAN9zeD5kx56YQqHaoufFMixRkHyd7lEbt48xe972tcLjhInCnKgJVfRFOr4gaTyxAoNjkWZ7PgeCfsFU+7eySveq7lonq8nGkqnj4QhWeN5WpB/680PjiXBfDPKWNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORZDNi/z; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORZDNi/z"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2055f5a993so163422166b.2
        for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 12:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786044790; cv=none;
        d=google.com; s=arc-20260327;
        b=lf9F9JO7ial0POINCjN+5zm5ITg8zf8EXdFz2/k6f20GtrZIUXxNhfSdqdA566Dbfy
         uFQ8YN4P1Ts7k7YLC58VSBxTQhzV8elPtlXcL7yW7aR55JD2dOKHml6PXWnIvkiI+6py
         JxX7EqC51ANQUiJdEc/zCHYVLeeJJcn9RM4pLf5VsVzlxuGHpqs1lJj+9Tdq5W4VD0KS
         LOQT9TMiyCpT02RW3Jf/o1nl2iV/kOXmg+NcvIM4uJ/a3mtqJ14SzmKlsPWC5JOVZzRJ
         p6X/tiYPhRSvJ+/p/g45ED6Mtk+WLceEKYgeC+qOZaaDytafIfXjrH912eDX0JNa6sRj
         1gEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ItYHsDfurYvZ5ceNkpYD86l11NBWSHQsSYdzzb3uODY=;
        fh=8j5V1MncUo6gWTK0zXgpWWE6jpISfLm8cop0oD2GhUA=;
        b=TEGDc3IrR2zqkRLvcTejpPpAyv7le0rHvjLkIE+tDOq1oEcEatj4VcMkJd8Ia43+aU
         jggKCPxH+YbHJ+9LUWNW8/9OHu+yygV3qVwefD0WeQMUZWqwimidclDq9e3blO1j4PWu
         aMOEqNZhHXsA7ehIJlhwC/Md3N8NB02yH8DsvzK5XNtYsGRp0RIGlNOBDZqg30/QwSnI
         VPCyagxRLljeGMKVQQx/QhcXSU58AQ6X95C0C9Q/2XWEA5eCm7ggZT1+PMcmBeyHKZfy
         xVclfTycy+p6FDfvvydMgh/PZ4fxJSzUPN8hu4rrxUWuHRp9cjTQcYANJAIgXlC143Z1
         2Vtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786044790; x=1786649590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ItYHsDfurYvZ5ceNkpYD86l11NBWSHQsSYdzzb3uODY=;
        b=ORZDNi/zBNoiz8iflCd8N4806zvzhRu5rzzmQbDjzbZBSh4Vqkjvdfaz53ZtSMFLty
         32/sIoFLfyYmFVfqwXDnCEQ/4Z/jgHtSOXsyW4KztKr5oe5izbTVJtFvWQ1/05yD6fvV
         /J8uO65C1ZUkpCcujK9eHyiwTjXM5mCq0y8ehd8vgo7SGq0b480d/8V3sq0zomnD3/lW
         vM8Xp5YJWWpOi1XC623fpP61RJbTzf992km8aeE5nDszbkoUobLyBmsahB4MurxOe5Gu
         vHebFknEAia13ImH7PpwxgyCAgak/41ZjvzGJQt6oWAcUPrv8YLPlIZpzcA/6RY1etzq
         vijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786044790; x=1786649590;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ItYHsDfurYvZ5ceNkpYD86l11NBWSHQsSYdzzb3uODY=;
        b=UCfzFSDfR0i9nvrwrLWcuGkHwmGUI14aBrWP+6DPNdfI51Y/WHFTMZFbN7sWUgbEr6
         9DygE3MrNRgVtjjeOCtoutr6HBpPwd4GPV1tqZk76bi2AW2AuLysSl0/CQC0ALGxs4JQ
         ZA6zXFU0FaZD7F5+hM2neqspWLv7vFGs/gtmIPc2C1lT3bUNZTz3gsUkVcOHdb9zM/mK
         6HLBmw2KkZ6+UbJqrPm7gragxEG4Oh5XwbywSxvu90lB2WSEbtFQq4ZEl1BsX2h7E/HC
         0qGIhiQzw9RnlQwywRv/uEA/Ge1FIgoW1Ar3qU2JyRztQR0X4d4eXV0Recw6AepTYQ9C
         9lMg==
X-Forwarded-Encrypted: i=1; AHgh+RoS+VW7RU/KFkkuiRDnDivtH6rB4RALGuzZyrcTOE+6MG7DC7oUTWyLmfhHjKpS1S6JiVyWTumdLuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo2JGsMo5/NvyNQnu25kRaXyDKqY3bcUznzuMiSqb29I8IVSIL
	049sHqLeOUWQiGyFnDr8ndXlXyMVj/KLtNqV8+y7JS1IJSpeDF28r0OLlEY4vrs7otESycI7OOY
	CtRtWk7g8NDdqH28jYRLRkKzm3tpQ25R/AlvH
X-Gm-Gg: AR+sD11lTfv0gTf6s1Jw9+A7/42K2KR+x64ruJaNlnfrDEOE+LOXy96DdJmOeslaGmE
	/LAASLN1COknFBAWLX0BeVqVWKEzkB+Z0S3B2HBD/wjkO9BM79BE969LxXOQyWpQytFxVv4sejh
	du8xtPZoxePB5j7AXP6sznDk+7eyynsjmuIIAXmbCg/BcyL2JAIMJOFlYmSjQ2eJOma7eAth+FE
	wr90Q8TqLbhtjmhNudfGuBo2fS7548QM3LMdwNZ1C+YF9mcUD9XChY4VoRcztNoURGtybsgPHPn
	xgedlWh6wLhbAn31Te8qASNxgXNYdgl373cqU31DZ121qLEsmmomF3aoZUVoFJ0sXXo3CJVHSth
	dRuky+pEaY1ChF3BNOE/lzNsLIzWK+ojHwDpJu2lDByoSyTkQ0PrA46nixkpzmqER+qnwtM2SB3
	UWp8P2JX7e9xMPaf05ICNzd2r2awkTEw==
X-Received: by 2002:a17:907:7ba8:b0:c12:a469:c with SMTP id
 a640c23a62f3a-c2039b348cdmr855071966b.9.1786044789372; Thu, 06 Aug 2026
 12:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805151456.756579-1-jiang_hh2019@163.com> <20260805151456.756579-3-jiang_hh2019@163.com>
 <fbc72384-2f47-4577-859f-719d55a2a66a@sirena.org.uk>
In-Reply-To: <fbc72384-2f47-4577-859f-719d55a2a66a@sirena.org.uk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 6 Aug 2026 22:32:32 +0300
X-Gm-Features: AUfX_mwNi0CUOGPz5WPL121FGV3gRLCTBq9zD5-EpZ0kM7_M3Y5AsND2WZceNRk
Message-ID: <CAHp75Vdhu9QC5D56ZDDYx_x6TqU+FR4KfZP_fdoBDxP7-YuaAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: Add KUnit coverage for DMA mapping error paths
To: Mark Brown <broonie@kernel.org>
Cc: Honghui Jiang <jiang_hh2019@163.com>, andy@kernel.org, 
	andriy.shevchenko@linux.intel.com, fancer.lancer@gmail.com, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 12:57=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
> On Wed, Aug 05, 2026 at 11:14:56PM +0800, Honghui Jiang wrote:

...

> >  postcore_initcall(spi_init);
> > +
> > +#ifdef CONFIG_SPI_KUNIT_TEST
> > +#include "tests/spi_kunit.c"
> > +#endif
>
> If this is just so we can peer into the internals it'd be better to add
> a local header for internals and build as a separate translation unit
> like normal rather than doing this sort of bodge.

Yep, and we have kunit/visibility.h in case it is needed.

> > diff --git a/drivers/spi/tests/spi_kunit.c b/drivers/spi/tests/spi_kuni=
t.c
>
> Everywhere else we use - as a separator.

I think for kunit tests there is a pattern which is xxx_kunit.c.

--=20
With Best Regards,
Andy Shevchenko
