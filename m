Return-Path: <SRS0=zXQu=77=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681D2C433E0
	for <linux-spi@archiver.kernel.org>; Thu, 18 Jun 2020 17:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471E520734
	for <linux-spi@archiver.kernel.org>; Thu, 18 Jun 2020 17:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RDyfYkhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgFRRx0 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgFRRxZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jun 2020 13:53:25 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573E0C0613EE
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 10:53:25 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x22so3126197pfn.3
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 10:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ir9UJL6qlzbqF/eoQrBQerXkNXIPx9dPATNwVgAx1No=;
        b=RDyfYkheyXJdVIK/z/D6LB/q5JWexOPGE5WWIJCxpEIfCjYdnq2EreQNJ27PQPhYl5
         VBH47pBulRMziC3dPK1eJfntFGRrP2OKIg5j44iuk1uHccC4rebxtXMH3JpToEkkRPe8
         pF6VLZDZgP4i35TU9NRIqxh3RZezEV5v5wax4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ir9UJL6qlzbqF/eoQrBQerXkNXIPx9dPATNwVgAx1No=;
        b=eqjJYLYq27EHcmN/hhWN+Kx/3nyDQK+If98cqsqIDuMxzll4dQjaTkDbpnRbTFXJD4
         CllDRyIXi6R8TVuChTG2BHuSUJinO/z+7G9D98VDy6wYW9tetN8z9gN5m30jTG4nFoUQ
         7w+yGVdULFUaMF1W+c5U8VZCMKONdMjcwdC6OCmWiJBAuA55xle+8/gl3y0ev86a1tKz
         e9oo8C06oAVirsiX2kKNUQ7whDZTLfwwgIG7joVpyNYGBXb2jJmg3obRqU5O1jmEqPyZ
         tb8DHtbod6cCEP7tXqlMXWwW5B1HjeJnpVwBUt8OgoCYbHT9+aU0okmtWicfOmCiKYEd
         tRvg==
X-Gm-Message-State: AOAM532KvezLYQvt2OUzYu4R4KONYGkogXStmyhv5x+OGlI1GS0pulr0
        1J59TyJjJWkMyvdXXnbqcTe7xQ==
X-Google-Smtp-Source: ABdhPJwLLfeG/qvIUQ0PkT1WAZBOJ+dODyW/t9naB+dy6SkrI+O1rtbXJs3ByChCWrB8DRiZBAsv+Q==
X-Received: by 2002:a63:4861:: with SMTP id x33mr4082379pgk.448.1592502804699;
        Thu, 18 Jun 2020 10:53:24 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c9sm3547470pfr.72.2020.06.18.10.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 10:53:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200618080459.v4.5.Ib1e6855405fc9c99916ab7c7dee84d73a8bf3d68@changeid>
References: <20200618150626.237027-1-dianders@chromium.org> <20200618080459.v4.5.Ib1e6855405fc9c99916ab7c7dee84d73a8bf3d68@changeid>
Subject: Re: [PATCH v4 5/5] spi: spi-geni-qcom: Don't keep a local state variable
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Date:   Thu, 18 Jun 2020 10:53:23 -0700
Message-ID: <159250280333.62212.11530324825257967473@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Douglas Anderson (2020-06-18 08:06:26)
> The variable "cur_mcmd" kept track of our current state (idle, xfer,
> cs, cancel).  We don't really need it, so get rid of it.  Instead:
> * Use separate condition variables for "chip select done", "cancel
>   done", and "abort done".  This is important so that if a "done"
>   comes through (perhaps some previous interrupt finally came through)
>   it can't confuse the cancel/abort function.
> * Use the "done" interrupt only for when a chip select or transfer is
>   done and we can tell the difference by looking at whether "cur_xfer"
>   is NULL.
>=20
> This is mostly a no-op change.  However, it is possible it could fix
> an issue where a super delayed interrupt for a cancel command could
> have confused our waiting for an abort command.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
