Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2EF346FC4
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111699; cv=pass; b=N4pz02mRor1RRfN3kJ89vaS+eDjgjUaMsxS89Q2GUZfQZh78dpHSP5s6+KPVvEtF0TFvddpAVu5hBWcv6FM2Ct+tM+b0B1Ad4MajSpvqbMnj69nELtd/gjO2AtPVdGrTEZ4+7jwiQYb35qz3g5lEMuiMjqv7L1SX+X92Fxi67HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111699; c=relaxed/simple;
	bh=Nvoc8y9Lk0r+Y/cgK6sK4+VybP8K1p7HAr2P3bKQpF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmhyQxFW+ioCvaZutKLKjWhEQiLWxn/puYBmDcwr60a+DyveV1bOFkwo0vhoE4YHSx+FUJwvIV+MakF+ESfGuskSwxagxeTqB1TpAeBK+miW3Ai53I61FJHjy7MtRBhJ2JN9rWyFsAiMAI21n/uPLd7qr4WBcGJZ7gMKQR1vyv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NA35RWAo; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NA35RWAo"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c85c531d4a9so2866916a12.2
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 10:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781111698; cv=none;
        d=google.com; s=arc-20240605;
        b=i1mkPGwlSRCaG/rAfsi9i55X8JodB5zTv6O4Wl8JlkBcyoYF2SOTFsTnuqSZZjyoOF
         S+wUgilWC+D4XJowCsDmYyruNlsGexXy7GATa5xYWJCKw88Sb6SONvJlWqfzrOjjkc6X
         zw+qsgm68MOvRJbzqvS3WkWepHipq50fFYUZS7zO4mwDDsGHfOXoXC4tGd0rHXrqC6ja
         Ha/ph+zur5r206kO1/kXbQLByIzSI4TkthK/ABUiIbjbnEoFpaixUsMPlB9Te2IS+8VO
         tO4RWJcVBaKk0Dzj1fnLLg1cUd6/9BhovthVxcWndYI8hQE8N7dOEmw4nhnmAud0QCGx
         G9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nvoc8y9Lk0r+Y/cgK6sK4+VybP8K1p7HAr2P3bKQpF8=;
        fh=sdBKO/KNdv53fgnfxCXF/DKp0I7KbCcwZ8TAiZvwkYY=;
        b=dK1cWe5QJ3JyVC8SP4bj5OZZ5+myt1tPMuSaOU93No44sTQbBYC7nLNcDOAOitm1qu
         chcf2ZyNz5lXGsqj1q/Htu6liCxsjJPheE3ccfLNecTVMvD50XXQUqybzQyhh6dHckQ4
         3NlliTcpe2qVyMm1fs3y0XE7fPRK/W118rNGFxJ3kLkYym8iRQAyzGOKVopFgSa89/Zj
         mgF3QREybLUoZcNb7jLOGNpu97DvMnzjwHqPJfeXpudWgxZvA6M2x1KmvvaaqCUHpJV2
         NeHE7NAR2KQFoXVAb9ZV2oybZN1F9WaIDDOJ8l6aTvmxinvz4M+ZKelfzPDWNx+WACiT
         5Izg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781111698; x=1781716498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nvoc8y9Lk0r+Y/cgK6sK4+VybP8K1p7HAr2P3bKQpF8=;
        b=NA35RWAowaTuEXRaC7KWWnxvFvWlrYy7CCNCBWbeazT0e2uCof5b1LGi87ngYji3Mc
         CIPSC/6+1ZTbPz251J6SflNkOs44f0yQOFCmGqUyunEBwoZQToB+3C5UoUwIg0OSD9Pf
         U4xrMySq62WznzL/BfM1giq9D6yxfB+fwvOmxUWLaygHDzdoKonRXSpjso5NxZEp81Qn
         mZKSheD375W65NQggsok5POQv7qOU5SJGcI7WBPMdHgsksX06iR4e3vXsXRcOZklYRHI
         OsRkA+xOGX1fw4iEKOTrwJS+XEy2WL4H54zHltJPCqCVY2Uv2xSukJPo1DdfbkTvaWw+
         ypAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781111698; x=1781716498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nvoc8y9Lk0r+Y/cgK6sK4+VybP8K1p7HAr2P3bKQpF8=;
        b=I5fjXdLES3jzSQYk43WAh5RYMwm0IiZrJ5RRSwIRVnv/6c0ogc2dO1qA1GNME1PEHV
         0c9KrQnBX3islLVRl+5wTzbWXPlF7hCQUt+4vYeiovdq70nMAIbzfBZ80DbaYuOXWebv
         QISdlc1uNYnEltE57ZfTqOnzYdjqxR6KkrxdtU8bi3Skcx4ex9JpTybKm34tAqrviiZS
         PPwDcmOR/zRYVzK05fSVcQtEGhva57boCPAUUGybhotQ6OKNn/3VULAoMhisDctmjGSy
         8/JkYf1OCSEeV8M0TzHxbRY+eF1TGL4Rv4UDgDjZ6cp7H4KFturgrsMAOz2fTeeHDM4k
         Rk7w==
X-Forwarded-Encrypted: i=1; AFNElJ8Rb1OK77cI+svtXizhfG10R/eCVcCd1EGDRPuXlC3j6/Esw4uwHopCjBx+hSUKHzPu7nZWuxLUJNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcjeMJt3vk03Hs3XoW/sUapYawmImw8NMcvd5SibwdsvG3wfg6
	ksGUspIJHa8bE/3IyZYwv4cG3khcgzb7mGV13geAW1rEojF3sLgucxdd4YYZMTLrxGD1YriN+NE
	SZo6shM1chC6JmFlTZ7Gm9HusK1ZuneM=
X-Gm-Gg: Acq92OGNtq7wsTZN6Cw0ebLHemV5jUKPJ0qf0+VruKT0gmwQGye71ZmTroRjdempatg
	DDVIsjneIGaRSW1Szwno6YjjWu0FEqXeAicwl1vRLUui2GyED0bw2f1/ner6XmwP7Jgws7kNCps
	YBe9WECsL/c4P90r5lV9YhvusI0Sftn2j1bcfAGqT0Z+M33g9gKTVAH0cB90xZbvL9aJtf+yPr/
	U6XH4MLwwIHGiCNG4JlkXvCiUU+hD+5ObQnZ9Kp0cdWryu8Ff6dcHkc2ryYz9v4chxnKCR4ASXB
	VYLpWrERaH0sn7XGFYJfPrJcwdmzqCVfynrjfEblY6NyI64l6w==
X-Received: by 2002:a05:6a00:2e23:b0:842:66f3:c51c with SMTP id
 d2e1a72fcca58-842b0fb6c50mr26210822b3a.40.1781111697796; Wed, 10 Jun 2026
 10:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+nLsRXTc=3LagGVdNiAPttL38tPVub_UOKuqJq91J9U0M+9w@mail.gmail.com>
 <806c1868-1c4c-4f53-a6ab-84b336fff7c0@packett.cool>
In-Reply-To: <806c1868-1c4c-4f53-a6ab-84b336fff7c0@packett.cool>
From: Carter <carterd1016@gmail.com>
Date: Wed, 10 Jun 2026 12:14:45 -0500
X-Gm-Features: AVVi8Ce_pqd_4RrI5jAQhTBKhH0W0Tt1eYiVn4hJbRju94hiUcioFaRw_R1M4Rc
Message-ID: <CAJ+nLsQOw4YPyRupo=6WK=7t2qPtHc+_FHOUENUzjC2Zu-KGOA@mail.gmail.com>
Subject: Re: spi: geni-qcom: any planned QSPI support?
To: Val Packett <val@packett.cool>
Cc: praveen.talari@oss.qualcomm.com, broonie@kernel.org, andi.shyti@kernel.org, 
	linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 11:58=E2=80=AFPM Val Packett <val@packett.cool> wrot=
e:
> On 6/5/26 1:43 AM, Carter wrote:
> > I hope I've found myself in the correct location; I haven't ever
> > officially participated in kernel shenanigans. I've been working on
> > enabling the trackpad on a Surface Laptop 7 (x1e80100, "romulus"). The
> > touchpad is an HID-over-SPI device (with a driver patched from
> > https://lore.kernel.org/all/20260402-send-upstream-v3-0-6091c458d357@ch=
romium.org/)
> > hanging off a GENI QUP serial engine (spi19 / qup2_se3), but it
> > requires QSPI transfers - the SE reports protocol 9 which is unknown
> > to the mainline spi-geni-qcom driver.
> >
> > I did find a patch for this driver online out of the linux-surface
> > community which may have even gotten it from another source. The patch
> > seems to work, however it is very low quality and I suspect it may
> > have been vibe-coded.
>
> This one, right?
>
> https://github.com/scuggo/x1e-nixos/blob/931cf9966ba3a213946329ce95b07635=
a34cd839/kernel/modules/qcom-qspi/spi-geni-qcom.patch
> https://github.com/scuggo/x1e-nixos/blob/931cf9966ba3a213946329ce95b07635=
a34cd839/kernel/modules/qcom-qspi/gpi.patch

Correct.

> I'm not sure what's "very low quality" about it tbh, and what are the
> tells to suspect it was vibe coded?

This is fair, it was a mistake to criticize so harshly. I have no real
grounds to call it vibe-coded beyond, well, my own vibes. I'll try to
be more specific below.

> > I wanted to ask: is there any active or planned
> > work to add a QSPI mode to qcom,geni-spi controllers? I was unable to
> > personally find any related patches or conversations on lore, but I
> > may not have been searching in the right places.
> >
> > If nothing exists, I'm happy to make an attempt myself. I worry about
> > getting in the way of more important matters as this would be my first
> > time submitting any patch work and I am bound to make mistakes, but I
> > will attempt it where that is welcome.
>
> I'd start with the existing series above, it looks almost ready for
> review to me?
>
> ~val

I think - and do bear in mind that I am new to this and provide no
authoritative feedback - it needs more work before it's ready for
review:

- It lacks devicetree binding documentation, which as I understand is
required for changes there.
- There are some areas that read more as guesses. The clearest is the
`msleep(10)` commented "without this the first command can hang."
Without QSPI docs I can't tell if that's a real settling requirement
or just what happened to work.
- Minor and more a personal preference: several comments restate what
the code already says.

That said, the patches do work, so if you consider them close, you may
well be right.

I do worry about the authorship and copyright aspects: as I understand
it, a patch to GPL code isn't automatically GPL itself, and
attribution is a separate matter. The only copy I can trace is in
scuggo's repo, but I can't confirm if it truly originated there.
