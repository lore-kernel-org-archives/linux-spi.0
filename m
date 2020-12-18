Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE463C2BBCF
	for <linux-spi@archiver.kernel.org>; Fri, 18 Dec 2020 02:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB3F233F6
	for <linux-spi@archiver.kernel.org>; Fri, 18 Dec 2020 02:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgLRCzL (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 17 Dec 2020 21:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732638AbgLRCzK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 21:55:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84937C0611CA
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 18:54:25 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z12so521075pjn.1
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 18:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=rrllBpnp4dHH66IT17U+etvLo5A8oP1vD6jgIF9ao0g=;
        b=gor3akWuo+7cprqkN4N3iqs/ZgKCP/R1OxvXJ8vU/zhLhX5plRELQlSB2XPDENU705
         KqCKsAoJraegllfTGscnNcM+9R0yqHCgFhM8jZVSGuRsnTBOr+Uj9xBR0vg0U9OVV6o/
         YdojdU9tE2EGO38kzM26X2WhQ8sqzh5tB7JqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=rrllBpnp4dHH66IT17U+etvLo5A8oP1vD6jgIF9ao0g=;
        b=ezymlcB2rh+r72GVbT3NR6sIJBNYP5dL+uj6Tl2POSF/KZfJpRpGJEzFOqGcDh2OpF
         iFxGog5jhFd0IIYCcpTOvTgFXXpHC1EQDhglUsqVUZlH50gzHZN2yrMtBHHsMvlb0uSV
         4roFnkkxZjvdatNYl8068n5ML5+fGmImgn+Y/CoSICswhshoBsl0H6XyXAgtsA7wZsbG
         SA/f3bvX/ToYCTWKOP1DUp6o5dnhZDumdUDUqZk1HG29vJm/8F/55Yneg4Pg4pHeLitT
         +/8Z1Pq3KRXy/1JkgythSkrLVr0IDa2qmRJZdhT1Cw1VOY0jXQYil0XKuJoxx97ni//X
         J9Iw==
X-Gm-Message-State: AOAM530+PS8uv78LQ7WJA3S9GUT4BEf5cr+MGifCn/hgRhFVZCtFMo4S
        EMaIqnXvPhCt8KZRE9PY2tCHUXl1vGlSiw==
X-Google-Smtp-Source: ABdhPJyBKW3LOBc6pAdOTSVesIwljaCWcgND1kVIUwdAQj2dhzwUYKQllv/N0PCNy+r5HHQkb7bx2A==
X-Received: by 2002:a17:90a:5887:: with SMTP id j7mr2136307pji.79.1608260065154;
        Thu, 17 Dec 2020 18:54:25 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id mq8sm5543268pjb.13.2020.12.17.18.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 18:54:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201217142842.v3.3.I07afdedcc49655c5d26880f8df9170aac5792378@changeid>
References: <20201217142842.v3.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid> <20201217142842.v3.3.I07afdedcc49655c5d26880f8df9170aac5792378@changeid>
Subject: Re: [PATCH v3 3/4] spi: spi-geni-qcom: Don't try to set CS if an xfer is pending
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     msavaliy@qti.qualcomm.com, akashast@codeaurora.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Date:   Thu, 17 Dec 2020 18:54:23 -0800
Message-ID: <160826006320.1580929.12847315427212664109@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Douglas Anderson (2020-12-17 14:29:13)
> If we get a timeout sending then this happens:
>=20
> spi_transfer_one_message()
>  ->transfer_one() AKA spi_geni_transfer_one()
>   setup_fifo_xfer()
>    mas->cur_xfer =3D non-NULL
>  spi_transfer_wait() =3D> TIMES OUT
>  if (msg->status !=3D -EINPROGRESS)
>   goto out
>  if (ret !=3D 0 ...)
>   spi_set_cs()
>    ->set_cs AKA spi_geni_set_cs()
>     # mas->cur_xfer is non-NULL
>=20
> The above happens _before_ the SPI core calls ->handle_err() AKA
> handle_fifo_timeout().
>=20
> Unfortunately that won't work so well on geni.  If we got a timeout
> transferring then it's likely that our interrupt handler is blocked,
> but we need that same interrupt handler to run and the command channel
> to be unblocked in order to adjust the chip select.  Trying to set the
> chip select doesn't crash us but ends up confusing our state machine
> and leads to messages like: Premature done. rx_rem =3D 32 bpw8
>=20
> Let's just drop the chip select request in this case.  We can detect
> the case because cur_xfer is non-NULL--it would have been set to NULL
> in the interrupt handler if the previous transfer had finished.  Sure,
> we might leave the chip select in the wrong state but it's likely it
> was going to fail anyway and this avoids getting the driver even more
> confused about what it's doing.
>=20
> The SPI core in general assumes that setting chip select is a simple
> operation that doesn't fail.  Yet another reason to just reconfigure
> the chip select line as GPIOs.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
