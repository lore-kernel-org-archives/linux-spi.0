Return-Path: <SRS0=L3Og=BA=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED45C433E4
	for <linux-spi@archiver.kernel.org>; Tue, 21 Jul 2020 21:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BF0206E3
	for <linux-spi@archiver.kernel.org>; Tue, 21 Jul 2020 21:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVgXcOyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgGUVuP (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgGUVuO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jul 2020 17:50:14 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19875C061794
        for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2020 14:50:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o1so10846380plk.1
        for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2020 14:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rLFvuK+kzarLWaTzGm5PbHM5taHdTY+muXHU6FdT6q8=;
        b=oVgXcOyghOpASzJt7LbZZoUOY16Q3hh0/O/tSaE/WKs1B1R8D7/QA3FWYyUjC844lR
         wGMwLShNKPNYfjhWkJEzJHR8Z+HHgOVHdbAIIoKM8IcEA2zBXpXG22l+GJRCKLc3YXn1
         04GCdMEBqrRHmRK5Ynv2eYR+9qS2WPxlPNDdwtBC6//aF8SmKjncRbqL7vlMYwZTzOM6
         w8+5LvIjbM+mOcAzpmEFxxaj4cgISHysMoZwF8QoeGZZnkdvFUealAGw5yWFtayIB2BK
         7vMVbQhFnItuHeYocmngnlzamnhd1h0vSDQM9aC6bP6rnqB+SOrIBhabOxu6aWAgS2X/
         eP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rLFvuK+kzarLWaTzGm5PbHM5taHdTY+muXHU6FdT6q8=;
        b=cdEKZ1FRTcGyQrEZ4ljFXX3dAm6xOB+vw4b/x7n1x8ZtZKmUSEnjNwKso8lMoa55xP
         Qn4UT4+5ZIlaV0ezNrGXX+tGVCCUJtv9SKRVsssnaqycugN1KyA6ADGf0aW2nDYnCoQ3
         IHbQvB4RR5yMuxp5KN1M0JleCfHn2X8+IBVCsyg4ENPi+IZq/g26KPiQYAjp6ZCuTQxt
         JqHXvM42d4IAzPxl2G+mvAaMBIG+sRn6aIWofp0RjxTZsmizVPA30rfmxfReEIYi+psV
         vW8hEvJX5zkJLh9MQBEdxoeH8tce/iUYE6IsD9lHJl1Jda7cuL3CLPqzG6Kv1pmBVIOG
         d11A==
X-Gm-Message-State: AOAM532kqn42bM5ufXQjui7aK4yGvc/9Reit0ttgxSTojcvg0f2ohBPz
        ZsPLel4r8jdpEQvTFwUweYfymlOqIVXTpoPqfvA=
X-Google-Smtp-Source: ABdhPJyZjaTDJ/I+coTbcNv0105/svblqBvtbeSIewdiZUHz6O48iKVQnLeh8QIqvaLaeWWBVyw47d+wrCAss7kWtV0=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr7032563pjp.228.1595368213628;
 Tue, 21 Jul 2020 14:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200519163353.20c03286@windsurf.home> <4c5c972b-c8b8-4326-a1f9-438d88217a4a@cesnet.cz>
 <20200721155139.40fdb835@windsurf.home> <070e2fa9-bacf-4d6e-a62a-63b3db55c25e@cesnet.cz>
In-Reply-To: <070e2fa9-bacf-4d6e-a62a-63b3db55c25e@cesnet.cz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Jul 2020 00:49:57 +0300
Message-ID: <CAHp75VfoTTsnr-700SZoL+wV-0zv00u4Q9AvNoRPYXc=5kJZpQ@mail.gmail.com>
Subject: Re: High CPU load when using MAX14830 SPI UART controller
To:     =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jul 21, 2020 at 5:32 PM Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz> wr=
ote:

> I have no code, but according to the datasheet, it's the "RTimeout" bit
> (Line Status Register, bit 0). If properly configured (RxTimeOut set and
> the interrupt routing enabled via LSRIntEn[0], the "RTimeoutIEn" bit),
> we're supposed to get ISR[0] set upon this timeout.

And usually timeout condition means no data for the time equal to
receive 4 more words at given baudrate and bits.
(For 8-bit words on 115200 it will be time as 10*4 / 115200 ~=3D 360us)

--=20
With Best Regards,
Andy Shevchenko
