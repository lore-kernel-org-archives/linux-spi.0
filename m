Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0952D1F44
	for <linux-spi@vger.kernel.org>; Tue, 30 Jun 2026 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814104; cv=pass; b=jR22qz8Tr+rFoHIqgPo+bW+rHWZQmJ+r7e3PXQlDlrQEXd+imhcHPnubVaztDwf8DuWCyBwo7BlxK0jxBQnduomLlBXBdkHGbWu5GUF+Qm51Z84T70FGIZyo8RTsVWgJSIloS0ogfuJlM7S78JjD7W1DcbvjijREgc47RhckxXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814104; c=relaxed/simple;
	bh=ImIp7ff7R+p3kOeF0z4nxDiC1ZOiuu9W7gXy3BE6q5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiKsGjxgyw+JXWrK7la78AxeKR+oVxxnJjnQ0UeA1xRuTdnxzOEg+NWpbqgcv8pISrzfBjb+nPDk3dQsygvSA7UMs2scJI48COKupSLKRgL5YjiBlnimH6s9eWjhWgscU/W87Vm5CuODcAovW8ZRU+oebID7LGNyd9VpY9rxW1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfHkWQ+4; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfHkWQ+4"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b966dd74so3442585e9.3
        for <linux-spi@vger.kernel.org>; Tue, 30 Jun 2026 03:08:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782814101; cv=none;
        d=google.com; s=arc-20260327;
        b=AYt00fVXC9cakTz+xci7iztE9/v1e+PI4w0vzaoylWhZUAZQddIXHhzEQhiwwNGWJH
         RE+Zo2D19kee9gh6oxkMWpGos+JOXE7CqUWAWSyKPeC21hCoRYp0eiZ7BcBVL8OntfhJ
         7GRNFXrHl3Ql8qs2w1rgtnhQOrUnqg7mS+D7Iun6yJ3lgzxeSyjfH+t0wKeHGSHEEitN
         3WPLjcYOsYDFcVK7o2sJ3EIrOP8NzTNAdUuglj8vp/+GJ0xkNWuM4sPJ/oi/t7pR84At
         yQU6Avh28cqI1QJWptdgRsJYoD8DwrhWZcPRy5JrCrjYPU0KbeT+5kL7dDK4Fo9IKVZV
         U8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zA254jSg7Mg/pmP5Hvzp8s8/v3sVmr5J11egd6Z5eK0=;
        fh=lfYtxnES/WpXBeuDZO09tAHwrFaiTSWqtvd7GA8L4eE=;
        b=pwLBjxTEa9ncGqNZvTeW3V98+z0sVUdxZTblJ867sT/ZZ0zyZcrqKv97vqTeSI4mdc
         PzZUirJ+qrsxJhYCY+ksXpMB+KO93L9aYc4v8QtyiDGDf6256fOJPERtPrO3BmSqJhWf
         NZcPBqT2y3w5NCrHbTAkaBGUFmegwxQAwjhXb8RdHYQAQYB3vgVVN6NIExVFSCLA1nHZ
         xReVudUaw9MIm+9z2OdLUlSix7zE1KLt9K724mg+uZ94pQv76HkgHTLL4mZ+a6KA5Bh3
         Y7nbd3a0RcQpoJMp4KfRB+u3v1niW+hY+55kHb5d9IoiOEiKaj6HdJli1Emq4fdoQMXz
         fitQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782814101; x=1783418901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zA254jSg7Mg/pmP5Hvzp8s8/v3sVmr5J11egd6Z5eK0=;
        b=AfHkWQ+4+dOgoqkmHcQUprrHPh+aL1fDXBe5mbKlRaLrc9EC15+p4PYgkyNs/hG0zA
         mtqDT9ikZBrEN1hiGrrsl2kVrMk59Gu42IbhF8Ojkj7jwo+obtLOBwJ+dA+0b2/Cfznn
         orVTdYe/jz7f8ZdB9zvR9+U6lbxAIrgeSHZWmoi4vJ4VLRZ5/R0iuladv/Z0/xUZz6OL
         gChPiAPkSp+SBGxwfiQkcYpABBVXCsGoxoMRZ95CxEAl5KbdtmUo/lDdMYy7JGpf3xK8
         +qX+wsF5atgBHUDODLGWRSwD9UvVpQdEFwbVDR3fmQsunkZpmvEqyLoEbGVcDAQmF6tB
         dQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814101; x=1783418901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zA254jSg7Mg/pmP5Hvzp8s8/v3sVmr5J11egd6Z5eK0=;
        b=oqN2eMKNzvRi57G+InG0m/CKYga1Gw/iJDDQwPhBBOvCPKrkb1CWSNoJZwjddE93lD
         EHD2sFo6zt9qA+ttp0cm7+nH3x/0BierWYEKnctut3jeG7JZWG2FPUsM1AC+ZHA1JS3L
         XQF5X061QiuRd0+at+t11qsmB1gPdJS/KrNda2Vy3BBjQMkIyawBCR88qo0pKhVt8+AR
         68dyjy7FxdDgw8bSOec4yz71H09o53nVZHn62RaVUePNx2gV7NqpgikwoLb6dBK2+j+5
         IaAv0MpWExXv6ryrlInu6VhYtlJ1YmRKjKpvtGBK0GxKv86i9843KWPmsSQ1nukZWWvn
         BhcA==
X-Forwarded-Encrypted: i=1; AFNElJ+gS5Pja4bKGtRHD3/wG4faQSxjOKU6R/SaRfUvG3cQpTRB4B6tcK6ZZUmy0EWrIa5bxYMWtv9fwFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAb5NrVTpXDRprhBu9ClI4I+PEB7Fie8uFO687AntpjL/m134
	2OeVkGWQ0XR7amgd+e1ciBx0J4JzL0HA78GIj11aBTdIGbvWq3GSV5+KJOvUsVPtiQg8LuwCM/j
	143rpTZ1nhAuWmKJxWu9DjAFqn4MbofY=
X-Gm-Gg: AfdE7cnCizrxiLahHSRvWFKa6wHy6irytQbF3JvwwNkEaWUiH+Nj/6CukDQvb3WRVPd
	m1gAyek8Rt0v5LBoZsD6mk8CAzWhwR6/lQcTV6z4Z7RnGuFv2Ve6/e5RtWZiClOSyG8+G3tzULd
	OoalH/ek79pRYd4fGLJnYW2Xr+bvktO/2bLSyRVYCw6p+PnXhooSA/eEgHooTRaqAOFLmLI6kNd
	skK9EkSFUiI3q0zWxOJjwX7pEaiJjCEsDbxlZAORpZHlasxrkr/uRkjaYLoxzZK0edPk2t7Rr8T
	APlYlk4TdEcQNn3uAWJeLbbw/68B/CPWSsq1/fw=
X-Received: by 2002:a05:600c:4991:b0:493:b730:8d78 with SMTP id
 5b1f17b1804b1-493b82c324bmr28731885e9.31.1782814100704; Tue, 30 Jun 2026
 03:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614083424.464132-1-mitltlatltl@gmail.com>
 <20260614083424.464132-2-mitltlatltl@gmail.com> <qwbda435on6rhsbf5o4jqijakanjmnmswnc6g6qsubuqbyvbok@fuoclv6u7tq5>
 <c29776b4-04b8-4c59-8f1e-d766bf982a2f@oss.qualcomm.com> <CAH2e8h75xeRVvo+jOjRuFaBko5NNCnBX0dawFFsWBaiTwNd4Xw@mail.gmail.com>
 <99eaf1d1-fbf9-4336-a13c-ae8ab789cc99@oss.qualcomm.com>
In-Reply-To: <99eaf1d1-fbf9-4336-a13c-ae8ab789cc99@oss.qualcomm.com>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Tue, 30 Jun 2026 18:06:50 +0800
X-Gm-Features: AVVi8CeXY2XXtKzC05jw7mqBTSZCDFNAWUTECad4JJzZvuIX-tBM3NerKDQFx-Y
Message-ID: <CAH2e8h6aWW_=pD6JAuFB-VqEZDj9x8gZVh9TdvTCRQakKzm3pA@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add property to force GSI mode
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 5:52=E2=80=AFPM Mukesh Savaliya
<mukesh.savaliya@oss.qualcomm.com> wrote:
>
>
>
> On 6/29/2026 1:33 PM, Pengyu Luo wrote:
> > On Mon, Jun 29, 2026 at 1:36=E2=80=AFPM Mukesh Savaliya
> > <mukesh.savaliya@oss.qualcomm.com> wrote:
> >>
> >> Hi Pengyu,
> >>
> >> On 6/15/2026 2:48 AM, Dmitry Baryshkov wrote:
> >>> On Sun, Jun 14, 2026 at 04:34:24PM +0800, Pengyu Luo wrote:
> >>>> Some devices (such as gaokun3) do not disable FIFO mode, causing the
> >>>> driver to fallback to FIFO mode by default. However, these platforms
> >>>> also support GSI mode, which is highly preferred for certain
> >>>> peripherals like SPI touchscreens to improve performance.
> >>>>
> >>>> Introduce the "qcom,force-gsi-mode" device property to hint and forc=
e
> >>>> the controller into GSI mode during initialization.
> >> Why to force ? You can directly configure in GSI mode. Note there are
> >> some configuration done prior to Linux bootup too.
> >
> > Sorry, I don't get it. how? I know there may be a qupfw, but it is
> > impossible for a normal user like me to generate one with GSI
> > preferred.
> >
> If firmware doesn't program in GSI, you can't have this working in GSI
> mode, its going to fail (and work with fallback). if it's programmed in
> GSI, anyway this will run in GSI mode. So why to add extra things
> without any usage ?
>

What I can confirm is that fifo is not disabled on my device, and gsi
is definitely enabled (under windows, check the register
SE_GENI_DMA_MODE_EN), forcing the device to enable GSI mode on linux
works well.

Best wishes,
Pengyu

> > Best wishes,
> > Pengyu
> >
> >>>
> >>> Ideally, this should be decided by the SPI controller based on the
> >>> requirements. Another option would be to prefer GSI for all transfers=
 if
> >>> it is available, ignoring the FIFO even if it is not disabled.
> >>>
> >> Yes, it should be decided in advance and configured accordingly for GS=
I
> >> vs non GSI mode. Because there would be limited set of GSI pipes, whic=
h
> >> will actually make must have GSI mode device run with FIFO mode.
> >>
> >> Why don't you decide prior and configure for GSI mode ? We don't need =
to
> >> change the current logic of deciding FIFO vs GSI.
> >>>>
> >>>> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> >>>> ---
> >>>>    drivers/spi/spi-geni-qcom.c | 7 +++++++
> >>>>    1 file changed, 7 insertions(+)
> >>>>
> >>>
> >>
>
