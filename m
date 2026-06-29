Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3A3B6362
	for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2026 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782720295; cv=pass; b=q01E6sNGfmAqPln/BcMk7Q4bNcEHXzhhZ3u0R4UHyZU165eIRoU7NUfn8L/HlJmd1aupTHSNOVWTJqIjbtd3CjHlNVvW+OqMFJMjeiOaZyxEtgFEOViDaYkEUYI1sLB2VJdxAlDqAb6195LvWV6NJst4Bp11UdjESZ57fdFSrGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782720295; c=relaxed/simple;
	bh=qb/Jl8OBR7LsWp9RSeOT+le399If/gM44rjjvFuSEws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DD3WnIz2q6QpErnQqaYkSYGTkdG+GJS8NVktH4NR7sSBX7mehlUzDVq4iiiIq1IZpBxxvOwzIEvsHZZc4G8fWtZsVQXbze6ZLvvgpR0yBTcy2SO5UYhVSSmPCyX+riJ3IWAv9A6qr4imBf5S50f/EtzZvq/AjtayuvVf9WYgb7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXekYCG8; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXekYCG8"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9666739d3bcso521756241.0
        for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2026 01:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782720293; cv=none;
        d=google.com; s=arc-20260327;
        b=j4W2PCUpim90NRHqo78v85QNxZT6XWF779pStbFPMlzwjMFWvhJYMrbvG4AZ7y9OiD
         Zb76wixZ/BYcE8RslqRe8mPo3v2+Fl0UJo9l/jWxW7hMCMbRuh0qHAOtkQIxuOVXYqjq
         Rl0+lXaPiV6he5SI8QGY5OQKB+K9FVhnnebJS81MEkVVRKmGqbWYXyOtA6n8FCIb5uIh
         sXs5ZgUXVE/zlgZs7xKDdMqA5iNdqmBuEqXqGsUOYPtOOcIgtnhdU1mtL427gUmf9vwI
         H593j4ia2ZNc2rT/zSyR7cKO9jVnDOObYA6mdDbzSx4jLU2Kvg9acPKEo5xuXB4HnaW6
         0Mfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLafhBxn/syeb/3P4J0V6pVOYzw0kjPfQXRFzRJWndY=;
        fh=DoetVVmeYtUKDtH4m/ESzrmME77lGOvTyCsGFMZZbnE=;
        b=aeNg6wr74ItIj0sFrntPMJgK7wOM0EhgFaYQW+leiaGLYCZoutZqZv/o8FuD0jE+sc
         kfj+mSxQCt7Zwg9DIatHKLUlgzABQGifZASmUNcSeXqzQI0p010xdRdtW2mYlinerq3O
         FVRHhxEJSZpTU64stE9IfdLwQ86ZuYFdZQiXcaHb9lkUMUUw9DJJ28spScsL9NRK7LgC
         ruxZ1F4jQHQNOzIgaRfvUtu02NZh0sG11I0Qu42wvRgHzBGoeas4CY9leSe/4zgWqflr
         GENQwIxkGUdLE/V/XvIxwMxbEHjB12rFKAIBL+N/JTGeCgk0/pxdL2DfMMIjvIrckIBC
         rPug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782720293; x=1783325093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLafhBxn/syeb/3P4J0V6pVOYzw0kjPfQXRFzRJWndY=;
        b=ZXekYCG8O35/EsqE+32kkQ3P8Y2L6kwxoTExn/55zVTCrRDFOwmrL0rQPqu7j5fRU4
         l29+s2VhVyqag8BMO+9hD1RD+O4n5R86eVl79afKBSKWO/pL7eDc5XfcDecfnNmLQjOK
         WgM3S1ENYKonsCbA2sNlwLF6EU3BZOA3XsTaIGo7HjsZ7GPE/X1OJYpzbmpCJ2IC5mFE
         MY52XrIEHmoQ/XMVpZdy+R7g1oZB4s27tpsxEL5xGBHx+uTG7snnBCgbrk12pFlCIpdG
         KLcJ228E1PaInDiAlXPmqq52oqI0U/haa4KUxqRV9U9s80pz7nw/YQVOCKqSYgc6Tc+2
         Du9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782720293; x=1783325093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cLafhBxn/syeb/3P4J0V6pVOYzw0kjPfQXRFzRJWndY=;
        b=M22nGnLsz6rmno9cO/72K35RP131oASMmsFdv3D1vjaJ2Y0TTIkFODMEVGSirPZcx6
         BEQVF5S+Y9B5466/nAiQYUCyiJTRK5VZ2OIvz9BwZKtxiXNYUaR0VOTwdOo3us30sDLf
         nJuDUC5I8zvRuL3lzZZiY2/kJKrRlTS66dfro1y2WTI0lZ04e0todSGCZoirWdSF14ac
         ny2jQdUklwxlbhpv/KL2Mo51NFtmOYxL4UVgv9+TdMmznY4hNLIfsINrD5+4soU8uWIv
         057drsEi5PtFCDAa1R5A0ixFVqSgdRvFMecP6tBvuIyfaVZjIeWsA0SF4gKO7LUTF7js
         AT4w==
X-Forwarded-Encrypted: i=1; AHgh+Rq4PUKMRWDM1khZKGxXusjyUSVhRgraZjzvOYEkoyUWVaeheaCynhEi4u2yErbApvMKVrThqc0DDk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5t1rJHTi5uTOIjtpFMk+9fQdzMaAgH2vVTbqgwVvSrc7cdnK
	g/6rKcsC0ddXA0OwQwXGsOY016imxvj5SbImOaP6FwR/IbDhBoJP7Fe3ja60QJMijiT6mq8xj8S
	RpU4e6M4VrcdXTCmfGEuZAm3xZ0eQVLE=
X-Gm-Gg: AfdE7clo/QSfA2roS8DdbACPC/A0PJOmCI6lN1b2NiSf6UNXIwvh6qkcXA8gfOXhdnx
	DiFPm4pU2Yp8fwHBb7CJ0jZlihin/svymrevxJnMVGZhGFni9/4eby9UnauWESANAqkLNVtFmyn
	kQHck78bWN5hwbmp2aOO7CpALAYviirWqkuWiUVBkI6yshhOyb419+34sBqHJ5p0rfzBKfErpVT
	cAV8TRAyDP5Zal/s+UuO+VF3Y0WZvjqDTG0hFmBup864cKOqXobNewaO96aBmntyTMfd/z7ddEQ
	aSas5dshRUL+eYQMzdxoaBvahQc6PrACwAFQrqE=
X-Received: by 2002:a05:6102:32ca:b0:631:28c1:154c with SMTP id
 ada2fe7eead31-73434452a9fmr6446524137.9.1782720293340; Mon, 29 Jun 2026
 01:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614083424.464132-1-mitltlatltl@gmail.com>
 <20260614083424.464132-2-mitltlatltl@gmail.com> <qwbda435on6rhsbf5o4jqijakanjmnmswnc6g6qsubuqbyvbok@fuoclv6u7tq5>
 <c29776b4-04b8-4c59-8f1e-d766bf982a2f@oss.qualcomm.com>
In-Reply-To: <c29776b4-04b8-4c59-8f1e-d766bf982a2f@oss.qualcomm.com>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Mon, 29 Jun 2026 16:03:25 +0800
X-Gm-Features: AVVi8CfV0vTEuw_OaCQ_mBABpEVc3al20mAjIqLbvt3oZ-TrUI_bjF0BO6hQB-0
Message-ID: <CAH2e8h75xeRVvo+jOjRuFaBko5NNCnBX0dawFFsWBaiTwNd4Xw@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add property to force GSI mode
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 1:36=E2=80=AFPM Mukesh Savaliya
<mukesh.savaliya@oss.qualcomm.com> wrote:
>
> Hi Pengyu,
>
> On 6/15/2026 2:48 AM, Dmitry Baryshkov wrote:
> > On Sun, Jun 14, 2026 at 04:34:24PM +0800, Pengyu Luo wrote:
> >> Some devices (such as gaokun3) do not disable FIFO mode, causing the
> >> driver to fallback to FIFO mode by default. However, these platforms
> >> also support GSI mode, which is highly preferred for certain
> >> peripherals like SPI touchscreens to improve performance.
> >>
> >> Introduce the "qcom,force-gsi-mode" device property to hint and force
> >> the controller into GSI mode during initialization.
> Why to force ? You can directly configure in GSI mode. Note there are
> some configuration done prior to Linux bootup too.

Sorry, I don't get it. how? I know there may be a qupfw, but it is
impossible for a normal user like me to generate one with GSI
preferred.

Best wishes,
Pengyu

> >
> > Ideally, this should be decided by the SPI controller based on the
> > requirements. Another option would be to prefer GSI for all transfers i=
f
> > it is available, ignoring the FIFO even if it is not disabled.
> >
> Yes, it should be decided in advance and configured accordingly for GSI
> vs non GSI mode. Because there would be limited set of GSI pipes, which
> will actually make must have GSI mode device run with FIFO mode.
>
> Why don't you decide prior and configure for GSI mode ? We don't need to
> change the current logic of deciding FIFO vs GSI.
> >>
> >> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> >> ---
> >>   drivers/spi/spi-geni-qcom.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >
>
