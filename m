Return-Path: <SRS0=ABY1=76=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6500C433DF
	for <linux-spi@archiver.kernel.org>; Wed, 17 Jun 2020 20:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983F721582
	for <linux-spi@archiver.kernel.org>; Wed, 17 Jun 2020 20:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UUkaBxwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgFQU4J (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQU4I (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Jun 2020 16:56:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C57FC06174E
        for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2020 13:56:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v14so1881925pgl.1
        for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2020 13:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=lyZJziQzzP4b5ndqsln6PR/ze9CmlmKyWOv9+1Wwqxo=;
        b=UUkaBxwarvyUz8chpn1JF7SSiQn2UkaFFz3E5R0kokx7j8jEjbpsNYyQEKfgU+o4qe
         T2Sdp6mI30KCKdG7RLaMcxh5hNb34xsGeGwyohEVcASG3zIdBRq5vDRII50e2HiJyExK
         5oPKmJ0I9qKyRgs6bheAZjo0IrNXJIoGrPyOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=lyZJziQzzP4b5ndqsln6PR/ze9CmlmKyWOv9+1Wwqxo=;
        b=YWDHNCJTGO7XFqqypH79b/D8Clpq7O93jsdsVWtBa5Wmh+2+7oyhzHDmcOD6G3vyTE
         t35mFvWsOwc+2e0uDrk+5bxWTr9K8IyEKeirDP4x3K31+O7glySLXnTzog+2RpN0ybRK
         gDOLRPrYb4kYMDFY70WNLHtNBTIRK2OtA/ASHH71J9lu+2uL2Qtgu1O6CgKREhSDUzb1
         Yl6sWHwRj4M3kJ4hOvI8M0tLazPjavWAGM3g7mA6sNjeKVJNq06rT9FkkFGy9NLa0Aus
         RHvSrndgUY7cUignaiOgsk8rQt8OoNGP3WR4/YyLcgPtP8tvWIVeiXhTN1DGiXOMXfND
         NJGw==
X-Gm-Message-State: AOAM5330HuAJov1JMS/TOtn3lGLXD1FmYuqFaYgb0m8jLtmVJAhnr0oj
        yNtCuBdA8aaaYqanJbptmdOnhw==
X-Google-Smtp-Source: ABdhPJzjaJdHqvLdNxXLND/5deAqoi1Q7B9L9AQScf8t11WtgyZgn1pllJ/maHehWSndAABRUnU0VA==
X-Received: by 2002:aa7:8651:: with SMTP id a17mr581745pfo.144.1592427368101;
        Wed, 17 Jun 2020 13:56:08 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j13sm680259pfe.48.2020.06.17.13.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:56:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200616034044.v3.4.I988281f7c6ee0ed00325559bfce7539f403da69e@changeid>
References: <20200616104050.84764-1-dianders@chromium.org> <20200616034044.v3.4.I988281f7c6ee0ed00325559bfce7539f403da69e@changeid>
Subject: Re: [PATCH v3 4/5] spi: spi-geni-qcom: Actually use our FIFO
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Date:   Wed, 17 Jun 2020 13:56:06 -0700
Message-ID: <159242736681.62212.65181596887239100@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Douglas Anderson (2020-06-16 03:40:49)
> The geni hardware has a FIFO that can hold up to 64 bytes (it has 16
> entries that can hold 4 bytes each), at least on the two SoCs I tested
> (sdm845 and sc7180).  We configured our RX Watermark to 0, which
> basically meant we got an interrupt as soon as the first 4 bytes
> showed up in the FIFO.  Tracing the IRQ handler showed that we often
> only read 4 or 8 bytes per IRQ handler.
>=20
> I tried setting the RX Watermark to "fifo size - 2" but that just got
> me a bunch of overrun errors reported.  Setting it to "fifo size - 3"
> seemed to work great, though.  This made me worried that we'd start
> getting overruns if we had long interrupt latency, but that doesn't
> appear to be the case and delays inserted in the IRQ handler while
> using "fifo size - 3" didn't cause any errors.  Presumably there is
> some interaction with the poorly-documented RFR (ready for receive)
> level means that "fifo size - 3" is the max.  We are the SPI master,
> so it makes sense that there would be no problems with overruns, the
> master should just stop clocking.
>=20
> Despite "fifo size - 3" working, I chose "fifo size / 2" (8 entries =3D
> 32 bytes) which gives us a little extra time to get to the interrupt
> handler and should reduce dead time on the SPI wires.  With this
> setting, I often saw the IRQ handler handle 40 bytes but sometimes up
> to 56 if we had bad interrupt latency.
>=20
> Testing by running "flashrom -p ec -r" on a Chromebook saw interrupts
> from the SPI driver cut roughly in half.  Time was roughly the same.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Nice improvement. Maybe it can still have a Fixes tag because it's a
performance problem?
