Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FD4C432BE
	for <linux-spi@archiver.kernel.org>; Sun, 29 Aug 2021 21:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0C660F38
	for <linux-spi@archiver.kernel.org>; Sun, 29 Aug 2021 21:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbhH2VK0 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 29 Aug 2021 17:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbhH2VKZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 29 Aug 2021 17:10:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3437EC0613D9
        for <linux-spi@vger.kernel.org>; Sun, 29 Aug 2021 14:09:32 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s12so22469364ljg.0
        for <linux-spi@vger.kernel.org>; Sun, 29 Aug 2021 14:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxGuGUCOWFryUZD+MaZ59To0anU+4+sFudo5C46Dub0=;
        b=nfV4aILK8Dhh0ahV+TeoNvDhnE+SFerHJVlQxUxDjik6lEG0UgGuflyvtwuZM3YQdm
         4qQpuazJBdWnkrpt4pxqeGR2ZFUjui1ttQiGi0NSY0EcDZ4jZ3R/AQRXWUCIgJP7OVwK
         O45bi3/RbDPtmOwEU4zDvmLxZdYW0R+TNFfnmNx1w2z0ehUmRJXYhtjzBs7s/KsczncH
         QkM250uLLIMG0o3c+ZFspIKI8WbWDbWAIYHmTNRLyNh6FDls+xLNU4mhI437adrXa7+e
         IlBSD8RjKAm0Uyce5YAKTJcXYTWGPHLc5TE08oh4vmz/ETInqZxez23f0cGw8+TXNDTo
         OS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxGuGUCOWFryUZD+MaZ59To0anU+4+sFudo5C46Dub0=;
        b=NsTfDOwrTB7M/ibpepSHDt/WxSN3ZIUjFcgcekZMBbT1LZmqCbhfZKr6w9C09W7XQ2
         7wBI20k7M4UitpoxB00kQBet45W8OeAMAIZ/fboywt/Uvx0I+a1IkncTey8tPShaYavV
         +IVxnNvybg1ridZTi8Q5B4w9psat/wcIsdT0oNybWpl5ZST8ShokYWsMNBOKm26kytBT
         o0vkocw2u9U049ZQL3Im7m0WoU7fQFCqpscGlwNxJdvbhhajMblxtzqC+1Ytljc+B81x
         naFeT4aIaBR+1Igwl+HVCDmO4CCJtEnII9zquid5taobWJZnywMsSs4CCshCz9/dGqsu
         8t2Q==
X-Gm-Message-State: AOAM532M80Cpf6qKBjmQvtxAVRuVhnS3L6gglc0h/xMVW++plGw2RvPL
        UWMN7qR1ruiXlmTRwCB9ZOYilHjJk0T8T5Z9l6Plrw==
X-Google-Smtp-Source: ABdhPJyLBGZC3w/XZYPqVgq7E9XJqzge4fnt3b3JacxNwyWo1sRegJwGgEN+8tVF7EFU69+xMuu7WMDdF20ZdQXFkk0=
X-Received: by 2002:a2e:54f:: with SMTP id 76mr17978352ljf.326.1630271370403;
 Sun, 29 Aug 2021 14:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com>
 <20210304091025.ny52qjm7wbfvmjgl@mobilestation> <CACRpkdZroi+_oHqipS71MAGif190y7jWU5Myf55vz=_um4w5cQ@mail.gmail.com>
 <CAK9rFnzDZ4MNm68AJ75g7zegLD-7UMHyoVR-4ssitYTTEeQm5g@mail.gmail.com>
In-Reply-To: <CAK9rFnzDZ4MNm68AJ75g7zegLD-7UMHyoVR-4ssitYTTEeQm5g@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Aug 2021 23:09:19 +0200
Message-ID: <CACRpkdZEURRTe15HGf93SvyHej=_6qhfP9KWPSQbCM=SLUVKmA@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Brad Larson <brad@pensando.io>, Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Aug 23, 2021 at 3:06 AM Brad Larson <brad@pensando.io> wrote:

> The gpio pins being used for the Elba SoC SPI CS are dedicated to this
> function.  Are you recommending that the code in
> drivers/gpio/gpio-elba-spics.c be integrated into
> drivers/spi/spi-dw-mmio.c?

That makes most sense does it not?

Special purpose pins should be managed by that special purpose
hardware driver, DW SPI in this case.

The compatible string etc should be enough to determine that we
need some extra GPIO control here, possibly specify extra registers
for the SPI host etc.

The struct spi_master has a special callback .set_cs() and you
should make this behave special for your special hardware.
In the case of the DW driver it appears that even subdrivers can
pass a custom version of this call in struct dw_spi.

Yours,
Linus Walleij
