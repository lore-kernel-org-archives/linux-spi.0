Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F7DC04A6A
	for <linux-spi@archiver.kernel.org>; Tue, 25 Jul 2023 17:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjGYR6d (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 25 Jul 2023 13:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjGYR6b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jul 2023 13:58:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC0E1FE6
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 10:58:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5223fbd54c6so2061059a12.3
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690307906; x=1690912706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaGwDr9AOa0YcSew23uPTw15yDAJZfLiLPUyBUI4SsE=;
        b=X7k/1bByTsLMMhsIwtBnrzwdTCTf1IwGXQYG+xZIdDX7M+VLZGYvQNswEkvA6mhFdV
         dL/LmPdIgTKidtd2KTNYb+ktJISP/CDARSUzo4MPWb8eNpO2eWxZnt13WvGEo9J+jSs5
         R4bek6Xcn3mh2cXlvPKHPZtc2I3bkF5Fz+IXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690307906; x=1690912706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaGwDr9AOa0YcSew23uPTw15yDAJZfLiLPUyBUI4SsE=;
        b=iEWb/izaZrxGJGpl+ujE0T36QkfYknefcNqeFCn5sthavsgjF3j0MDcn93RpBzA7PD
         sI+DPQNlLVx+qnFPgZON6KfW+W3Phw5Jpl3UO3KGq/NTzaMx1L1BIPFsc3hVdsORHEAo
         BbGq0hQ1UIcYeLLa8xi3pbK4G2KX+FsM67BlPG/ezcfHas0nJlPuwxuJo3vfFj5EYyd0
         FgPDjbSi29Jz2wMuALUNLMEe0EXUwvFajAU/0+LZBXneQbb27Yp5J8GWCubtWO2oyy2X
         GAty3VUkEUWXQX5sHnyIZOjjEgiw7XRozFvCRDs8xptmpnV81uSaX9q3uBapddm2kwyR
         GpxQ==
X-Gm-Message-State: ABy/qLbvZsvZF/srXzSPSp2JxPOQqBEwF83j84nFcLe8opiqkjtozBGF
        PpcojVZI+CrhLUq46dpVuBhQd6uPjeF/X+tEJAeJL4rf
X-Google-Smtp-Source: APBJJlEmH/YZvSV2wl5Ztc3gC2d/zx9j0pFJwP8ykAUA+mM4Q2HM/aRiFjD3N5NjQvPQhb9Hb2iGYQ==
X-Received: by 2002:a17:906:748f:b0:987:5147:7498 with SMTP id e15-20020a170906748f00b0098751477498mr13012545ejl.32.1690307906400;
        Tue, 25 Jul 2023 10:58:26 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709060dd600b00993a37aebc5sm8462809eji.50.2023.07.25.10.58.25
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 10:58:26 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so1524a12.1
        for <linux-spi@vger.kernel.org>; Tue, 25 Jul 2023 10:58:25 -0700 (PDT)
X-Received: by 2002:a50:d6de:0:b0:522:4741:d992 with SMTP id
 l30-20020a50d6de000000b005224741d992mr145884edj.4.1690307905506; Tue, 25 Jul
 2023 10:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com> <1690285689-30233-4-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1690285689-30233-4-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Jul 2023 10:58:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZFXiT6R=RBy=Mj4TEewHPYpz9cG6wE_SeE8=KrBVVVg@mail.gmail.com>
Message-ID: <CAD=FV=VZFXiT6R=RBy=Mj4TEewHPYpz9cG6wE_SeE8=KrBVVVg@mail.gmail.com>
Subject: Re: [PATCH 3/4] spi: spi-qcom-qspi: Call dma_wmb() after setting up descriptors
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Tue, Jul 25, 2023 at 4:48=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> After setting up dma descriptors and before initiaiting dma transfer, cal=
l
> dma_wmb() to ensure all writes go through.
> This doesn't fix any reported problem but is added for safety.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/spi/spi-qcom-qspi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

This looks right to me.

Fixes: b5762d95607e ("spi: spi-qcom-qspi: Add DMA mode support")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
