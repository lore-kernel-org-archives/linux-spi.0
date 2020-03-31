Return-Path: <SRS0=YG3D=5Q=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15069C43331
	for <linux-spi@archiver.kernel.org>; Tue, 31 Mar 2020 20:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD26E2173E
	for <linux-spi@archiver.kernel.org>; Tue, 31 Mar 2020 20:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585688262;
	bh=cZUq7aaNQWWsd7nujXKdGojgy9Xn5BD3Y6JU9Kd2Mwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H/d7r5YotnpbnhjTZJnvbQH33wePWFWfqIIJWkgeZH5kKSSf5zRYG5ltcwxxtte3+
	 /DJ6tC1LziLTxsTAtVKM+vBz4W2DZQXwKza3/S4mPHC7aO4JAZVn4OihXDfav5kgmF
	 EFLEwFfEAIm1DhRh7C6LkxLp9lJ2A76q2LmgCYt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgCaU5m (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgCaU5m (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 31 Mar 2020 16:57:42 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEAE4208E4;
        Tue, 31 Mar 2020 20:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585688261;
        bh=cZUq7aaNQWWsd7nujXKdGojgy9Xn5BD3Y6JU9Kd2Mwo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CNAgVPOG2kU8wA8iP+Bzok2rh/UxvzMgzdMFqG/gQ1EBJBPuUFtdHGtwMCeFyL+f2
         16pbR89Ns7T9UiweJC3IRgssi7s3UEZCBUQLdz/OF7qYUTkjo7qQW3EQYcVr/iThMo
         1kvlc1qgT1LyhGozvcK3C5sn3uvVoOYmyXIIWXrk=
Received: by mail-qk1-f171.google.com with SMTP id 139so14818560qkd.9;
        Tue, 31 Mar 2020 13:57:41 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0Cy3acOvfA1C6ErLXjFk7UzzCc22AssnVLrYG7oQXQh9iTAM21
        l6z2/Zi2rvNQQptWn2nILc3oyRXKYQi7uYNAeQ==
X-Google-Smtp-Source: ADFU+vvq34TxHm4hqjlR/CY7tWkOnMzotYoHbjOsldxdZa66U+ehdQSMRAA7wRqGNd9dlPqxDXPM0hTjMOhNo5FqmBY=
X-Received: by 2002:a37:aa92:: with SMTP id t140mr6375840qke.119.1585688260747;
 Tue, 31 Mar 2020 13:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200315134416.16527-1-sam@ravnborg.org> <20200315134416.16527-33-sam@ravnborg.org>
 <20200319030734.GH29911@bogus> <20200329190352.GA21479@ravnborg.org>
 <CAL_JsqJGpCBohddU+h3366rzGVw6mgn5H9YMqq-MF4Ka=mVkzw@mail.gmail.com> <20200331191353.GA14267@ravnborg.org>
In-Reply-To: <20200331191353.GA14267@ravnborg.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 31 Mar 2020 14:57:29 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+S1yjX3aH7jYiMGUsgvwCju2KgCvn57Pv9DYZ4LfHa7Q@mail.gmail.com>
Message-ID: <CAL_Jsq+S1yjX3aH7jYiMGUsgvwCju2KgCvn57Pv9DYZ4LfHa7Q@mail.gmail.com>
Subject: Re: [PATCH v1 32/36] dt-bindings: display: convert sharp,ls037v7dw01
 to DT Schema
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org,
        Alexandre Courbot <acourbot@nvidia.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Brian Masney <masneyb@onstation.org>,
        Chris Zhong <zyw@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guido Gunther <agx@sigxcpu.org>, Heiko Schocher <hs@denx.de>,
        Nikolaus Schaller <hns@goldelico.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lin Huang <hl@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marco Franchi <marco.franchi@nxp.com>,
        Marek Belisko <marek@goldelico.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Peter Rosin <peda@axentia.se>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Werner Johansson <werner.johansson@sonymobile.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 31, 2020 at 1:14 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Rob.
>
> On Tue, Mar 31, 2020 at 11:20:13AM -0600, Rob Herring wrote:
> > On Sun, Mar 29, 2020 at 1:04 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > >
> > > Hi Rob.
> > >
> > > > > +
> > > > > +  mode-gpios:
> > > > > +    description: |
> > > > > +      GPIO ordered MO, LR, and UD as specified in LS037V7DW01.pdf
> > > >
> > > > 3 or...
> > > >
> > > > > +      change configuration between QVGA and VGA mode and the
> > > > > +      scan direction. As these pins can be also configured
> > > > > +      with external pulls, all the GPIOs are considered
> > > > > +      optional with holes in the array.
> > > >
> > > > minItems: 3
> > > > maxItems: 5
> > >
> > > This binding can specify up to three GPIOs like this:
> >
> > So it should be:
> >
> > minItems: 1
> > maxItems: 3
> >
> > > > > +        mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH        /* gpio154, lcd MO */
> > > > > +                      &gpio1 2 GPIO_ACTIVE_HIGH         /* gpio2, lcd LR */
> > > > > +                      &gpio1 3 GPIO_ACTIVE_HIGH>;       /* gpio3, lcd UD */
> > >
> > > They are in the linux kernel driver accessed like this:
> > >
> > >     devm_gpiod_get_index(&pdev->dev, "mode", 2, GPIOD_OUT_LOW);
> > >
> > > The following is OK in the DT file:
> > >
> > >     mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH>;
> > >
> > >     mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH
> > >                   &gpio1 2 GPIO_ACTIVE_HIGH>;
> > >
> > >     mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH
> > >                   &gpio1 2 GPIO_ACTIVE_HIGH
> > >                   &gpio1 3 GPIO_ACTIVE_HIGH>;
> >
> > With the above, the 2nd 2 should fail...
> >
> > > But the following is not OK:
> > >     mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH>, <&gpio1 2 GPIO_ACTIVE_HIGH>;
> >
> > And this should pass. We want phandle+arg type properties to be
> > bracketed like this.
>
> OK, so if I get you right you say that we should accept the:
> <phandle+arg>, <phandle+arg> ... syntax.
>
> And then ignore that current DT files uses:
> <phandle+arg phandle+arg>
>
>
> A binding like this:
>  mode-gpios:
>     minItems: 1
>     maxItems: 3
>     description: |
>       GPIO ordered MO, LR, and UD as specified in LS037V7DW01.pdf
>       This panel can have zero to three GPIOs to configure to
>
>
> Do not error out when the example looks like this:
>
>         mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH        /* gpio154, lcd MO */
>                       &gpio1 2 GPIO_ACTIVE_HIGH         /* gpio2, lcd LR */
>                       &gpio1 3 GPIO_ACTIVE_HIGH>;       /* gpio3, lcd UD */

That's because we can't distinguish between this and 1 entry as the
schema doesn't have visibility of what #gpio-cells value is. dtc does
check that the cell sizes are correct. We'll need to somehow combine
that and the schema to check this form correctly.

>
> So if I get you right this is a bug in the tooling.

Limitation I guess. I thought you where saying the bracketed form was
not working.

Rob
