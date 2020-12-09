Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1145CC4361B
	for <linux-spi@archiver.kernel.org>; Wed,  9 Dec 2020 17:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC28823D1C
	for <linux-spi@archiver.kernel.org>; Wed,  9 Dec 2020 17:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbgLIRhc (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 9 Dec 2020 12:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732511AbgLIRhc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 12:37:32 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17981C0613D6;
        Wed,  9 Dec 2020 09:36:52 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id h6so1332765vsr.6;
        Wed, 09 Dec 2020 09:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcJtMb//+EPfBx4dkxoUg6Ti+FH+RqCACCceANTeFy8=;
        b=Y78dYeBP7Q3T+CZ7oPp1D3rcvQi/waVMWIF+w3pAi7brg3wNNafn8JIS67BxeVwv2K
         7lZVmVk1jL61cfm9Ik/fYSk/77szyAdSK70gZTl3Eue2yR2ULQAsdBGM0ryZGM20Z60W
         OnQr5uUuUCk9zwtUSyL309h5D3zbynTXImgBulKek4ur6L6ySOeVSpmfjHuBYLkHbq4q
         x51Ho944IUqt/5oVe9NQ+582Jrl2wP4oa9IW4X0BkDOXrmN4kGz50waz9H0QcrK4nH8n
         61jvylCVQF0cXalElntPiknOj1NUC2RhxjpKrlWl6AZ66HTdf2bNRo36zDkT/SOVv/Fg
         g4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcJtMb//+EPfBx4dkxoUg6Ti+FH+RqCACCceANTeFy8=;
        b=kPBxqlXqWTqFFnf7lVmFRDbCNgPJ9l+9LuHU3WDf4vmDkfXOIIeWpe9ddHMJRM59U+
         Q1ojWvHuh225UODnUiUSh59XUA3/x2SluSvKCJdILOyNscXllDer2au51Hhv1QOR99hS
         8/NlGs12ODgYcDxTCiWQaSf8LVkjvdeygLehq1MCWIgMUuOiR6OBsZVlTdG93YlYdT6I
         vC2DHAkdXEfwalkoukvy7mvrOwkCvd35rDB4dmJOqmwb6/n+VtLVrsqzcgEew9yDr7R5
         9mvrl1Zgx80wlk9RSS/bK6sPIykVkl5CPrTY95Vn4RUyUi2xW+qTn5/0unkwiZWUxS6i
         gvyg==
X-Gm-Message-State: AOAM530709D4SeejG9UVSxQg2C4rs7EBD0RIW0w8ibLXfO2NuBjNORrx
        AnzOSsCZ1lBPxic9rTVsbRUBMbUwDmRs4ZPnjyg=
X-Google-Smtp-Source: ABdhPJwdex5HVUanotpQ+6UbaDV8Uz9CWq3GGsSLjV+gUdwtL3LLT+5Ll6mHB/s2OioozhetwkqYJSZSytkssiQo26U=
X-Received: by 2002:a67:d319:: with SMTP id a25mr3032095vsj.57.1607535411238;
 Wed, 09 Dec 2020 09:36:51 -0800 (PST)
MIME-Version: 1.0
References: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com>
In-Reply-To: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 9 Dec 2020 12:36:40 -0500
Message-ID: <CAGngYiVKHoXPGxmScCnb-R6xoo9GNw5pG8V8Cpyk3meoJbskiw@mail.gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: clarify CS behavior for spi-cs-high and
 gpio descriptors
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lukas Wunner <lukas@wunner.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 9, 2020 at 4:57 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> +
> +      device node     | cs-gpio       | CS pin state active | Note
> +      ================+===============+=====================+=====
> +      spi-cs-high     | -             | H                   |
> +      -               | -             | L                   |
> +      spi-cs-high     | ACTIVE_HIGH   | H                   |
> +      -               | ACTIVE_HIGH   | L                   | 1
> +      spi-cs-high     | ACTIVE_LOW    | H                   | 2
> +      -               | ACTIVE_LOW    | L                   |
> +

Doesn't this table simply say:
- specify   'spi-cs-high' for an active-high chip select
- leave out 'spi-cs-high' for an active-low  chip select
- the gpio active high/active low consumer flags are ignored
?

If so, then I would simply document it that way.
Simple is beautiful.
