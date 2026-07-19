Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8609D3BB48
	for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784461292; cv=none; b=eHeUPINzlNP8RAkFKlR9BlY034aSYbLRckubm12ZtGKCVnbeZjmWcRcqC22Detc8a4rjtHlPKFEKqyTKhAWsaYgYN6grKN0cAGx99Ixx5LIka1ciX0genfQOuXmpBB6rhy674AjdAiYfdp+EKpUBhkxdXpgzYeiDtXdUl9M6kVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784461292; c=relaxed/simple;
	bh=sRT2am3xOop8OnHSnZsqPwkgcVUBYri3G67s+TcdN4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCmFSXAQXeptdv3MOKccbjprDHJhAJESYvyc3tVNOogu8THzTTTMcTswCmst8rf9ESP5lhZTpp7Qw+Eo2tdROZZKVS+n9fbONLN2OqNbuXog9qslKENFcIi3nH/dsCV5D2Z0LTBrxHvM5JkX02mJhXMh8UumptcxpaIi0rP4uL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ec49608332so1828432a34.3
        for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 04:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784461289; x=1785066089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/aAgtzH5hyZaDFyYZCCu13z3UuUmly5w10Q9by5VVHk=;
        b=oujX3gHDx6v3tIxEbi6owj83i1wR9nN6BiN80swpZ4y0NEZpZALRQ7REgLxbnY6xlt
         mGUUnskIrvn4Jjgjai0HVMvmWxr2ThFANiQmnCkjHI22/3SDK7bjCdCkXZJq7OGoKI72
         9v4iXU2P9Vl/tXZD5xYpYYbRDpwwiZQBpDg2GztTaIy2c5h9NAIsJ6NS2vmSj4/4/UQj
         k+wYwM4VxOWIo2LYTqQuOWHFechPjQumaAGLTGckPxXyY9j2xn+hLGeRA+9VtbAc+1eN
         mHOwA2xmNc2UinjGz4+xig9tMyDL3RLIfjQJllhY6DsvOT9NitAqMyOiylYmDFEtoEex
         aoOA==
X-Forwarded-Encrypted: i=1; AHgh+RpA08NGAYxJkiDvjMQKzT+W+iGqnQiE3DR/EpDTfwZ58Swnpl26t/N2IKtiLtwC1fv4pLzJcaqvy1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Wwb1G2kYw6pdn+mRYH/XDEx0zjiQ4W4wqI3XKhZ9xNVJ08MM
	UKtdvktEn47lB74qF2L58aMZjMFfU0UmA6vODCQYDg/kk1zbm2hjURP3w+RVctc=
X-Gm-Gg: AfdE7cnz12fgtVXRUFGImQNcpQJNQspjGUHNfbV1EW6LvHP8SqSrhh0GgNsQ8xKNTz9
	tYj9jLLwEwp73pJ/pQuE8bC3tBJw/gg2sdTIjQQX3x11eEes9Ru+Q3krq5gDlB63oDHxdBpJ+Fm
	LsPUKD0qa7UU+Eidgy3/FQUxs1zc+Bdg7uze/3/FJkXzD7etS1tBZzC1Zn13aEaVulCkUpjR/y1
	C3C6vAAv/InNKzdehz1JIGJ37K8z9jTEfs6lR904sCV2A72naDmOVIsCiiZUq3IZb/f61i/D6gy
	7ge55Q4YPpxUnukO/JGREceLBhawHCYJ/qrH5qT6t0iDhUeVs8grwrwmeQ4MQUgE072CwPoocEm
	TfLJh/2hKG1h3m2CRAEqA5eitsO6OFYsHYx8FWWk7WdBZE5r55weYlAAPJDoYiERQ2kQ4g4RtMe
	rbRkLYspRdmvqIvuZT3KB1q2me4Y8w9rH8jnAiB8uSFMzcuTL78DV5eI6RZj2mz9Xl4kWip54rO
	O4HRNOUTUI=
X-Received: by 2002:a05:6830:6f8f:b0:7e6:d384:459e with SMTP id 46e09a7af769-7ed9aa40ca3mr6356338a34.3.1784461289222;
        Sun, 19 Jul 2026 04:41:29 -0700 (PDT)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edaf94c13csm5761771a34.16.2026.07.19.04.41.28
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2026 04:41:28 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6a377223171so4266961eaf.2
        for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 04:41:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpQeDShWeBJOY4vi4oMTPCROv9Ua7WQkTfCFNjtIV1VG7OfLmK3PtLzGbRE6dy3Nd7dAEIgABGJamk=@vger.kernel.org
X-Received: by 2002:a05:6820:1805:b0:6a3:92f8:96ab with SMTP id
 006d021491bc7-6a53668295emr5312239eaf.1.1784461288526; Sun, 19 Jul 2026
 04:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718145209.6678-1-fourdollars@debian.org> <alyCbKAQh4jtZVDv@black.igk.intel.com>
In-Reply-To: <alyCbKAQh4jtZVDv@black.igk.intel.com>
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Date: Sun, 19 Jul 2026 19:41:16 +0800
X-Gmail-Original-Message-ID: <CAAT15mN3B4=7eaQUO9nmdP3SCN21ffKyK7VD4Vxck6gbH3izuw@mail.gmail.com>
X-Gm-Features: AUfX_mx3cu33VZIYFBwNxA8sKfMtJHkVIG_EH3YqaiqMPRus_LdypunA4jH6cro
Message-ID: <CAAT15mN3B4=7eaQUO9nmdP3SCN21ffKyK7VD4Vxck6gbH3izuw@mail.gmail.com>
Subject: Re: [PATCH v12 0/3] spi: pxa2xx: MacBook8,1 quirk, runtime PM, and
 LPSS S3 resume state fixes
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 3:53=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sat, Jul 18, 2026 at 10:52:06PM +0800, Shih-Yuan Lee wrote:
> > Hi Mark,
> >
> > This 3-patch series resolves issues in the spi-pxa2xx host controller d=
river
> > related to Intel LPSS SPI controllers and the Apple MacBook8,1.
> >
> > Patch 1 moves the forced PIO mode quirk for the Apple MacBook8,1 LPSS S=
PI
> > controller from the client driver (applespi) to the host controller PCI=
 glue
> > driver (spi-pxa2xx-pci) where it belongs.
> >
> > Patch 2 fixes runtime PM and interrupt handling in PIO mode: when DMA i=
s
> > disabled, aggressive runtime clock gating causes PCIe Completion Timeou=
ts on
> > subsequent MMIO accesses. It scopes autosuspend lockout strictly to LPS=
S controllers,
> > tracks clock state to avoid disable underflows, protects shared IRQ han=
dling,
> > preserves the if (!pm_runtime_suspended(dev)) check in suspend/resume t=
o avoid
> > PM state desynchronization on non-LPSS SoCs, and uses pm_runtime_put_sy=
nc() upon
> > driver remove to correctly synchronize the PM state machine to RPM_SUSP=
ENDED.
> >
> > Patch 3 fixes S3 suspend/resume for Intel LPSS SPI controllers. The LPS=
S
> > power domain is fully removed across S3, losing all private register st=
ate.
> > Accessing MMIO on resume while the block is held in reset causes a PCIe=
 Completion
> > Timeout and a watchdog system reset. To fix this, we save the LPSS priv=
ate
> > registers in struct driver_data during suspend, de-assert resets first =
on
> > resume, and restore the saved registers.
>
> > Changes in v12:
> >   - Addressed feedback from Sashiko review on the v11 patchset for Patc=
h 2:
> >   - Preserved the if (!pm_runtime_suspended(dev)) check prior to enabli=
ng/disabling
> >     the clock in pxa2xx_spi_suspend() and pxa2xx_spi_resume(). On non-L=
PSS platforms,
> >     if a device was runtime suspended prior to system sleep, unconditio=
nally enabling
> >     its hardware clock during system resume forced the clock ON while t=
he PM core
> >     retained RPM_SUSPENDED. Restoring this check prevents PM state desy=
nchronization,
> >     avoiding power leaks on non-LPSS platforms.
>
> What's going on here, please?
>
> It's v12 and you haven't even a thought to add the authors of the drivers=
, nor
> any one from Intel whose SoCs are under the question here.a Besides that =
the patches
> need more work.
Hi Andy,

Understood. I will add the required authors/Intel folks and address
the remaining issues for the next version.

Could you please help provide the email addresses for the relevant
Intel maintainers or authors I should include except the list below?

$ ./scripts/get_maintainer.pl drivers/spi/spi-pxa2xx-pci.c
drivers/spi/spi-pxa2xx.c drivers/spi/spi-pxa2xx.h
Daniel Mack <daniel@zonque.org> (maintainer:PXA2xx/PXA3xx SUPPORT)
Haojian Zhuang <haojian.zhuang@gmail.com> (maintainer:PXA2xx/PXA3xx SUPPORT=
)
Robert Jarzmik <robert.jarzmik@free.fr> (maintainer:PXA2xx/PXA3xx SUPPORT)
Mark Brown <broonie@kernel.org> (maintainer:SPI SUBSYSTEM)
linux-arm-kernel@lists.infradead.org (moderated list:PXA2xx/PXA3xx SUPPORT)
linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

Shih-Yuan
