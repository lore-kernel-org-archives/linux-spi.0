Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBCDC433B4
	for <linux-spi@archiver.kernel.org>; Wed,  5 May 2021 16:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FF3613C3
	for <linux-spi@archiver.kernel.org>; Wed,  5 May 2021 16:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhEEQcy (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 5 May 2021 12:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbhEEQco (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 May 2021 12:32:44 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E21C06174A
        for <linux-spi@vger.kernel.org>; Wed,  5 May 2021 09:31:46 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 82so3459915yby.7
        for <linux-spi@vger.kernel.org>; Wed, 05 May 2021 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRVzwOgIfTSllO4Wpxq3+JkI0Hw7DPEdTGB0dVwqKjQ=;
        b=IdOv2ekLdGnchPslFlPDDzQiNQdeseK4Ba8Jyex9e0ZFkwjpS4vHnqmVAKgQTY4Gs0
         NJT584bOfjuJOoiyeiXEW7Ye04nzU7Wg05vXbQ7n1aHfhK2Dz0h3UgaSdtBBPsz4piKu
         m7kweSyABh3p1UstIv2J4EG8ONKIqc5KyQq2aNsLCYNggHpxtDQkm+4LUdufaoJy8fJ+
         actO6D4HK2Jxc+8GMuLCE4T29bS3bvtgDyLpnmgZQHaPzefJhYbRYW5jdPCPzd9O/LoW
         P0qozxlmQeqTeumDGcjo87Xn7ECtPN18FDvfeQCc1DSCBDytP5ANKykaR5rL/4WOB1wL
         fzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRVzwOgIfTSllO4Wpxq3+JkI0Hw7DPEdTGB0dVwqKjQ=;
        b=I5dtKiuB9qFxDkIVCKO8OE61X2mGr0CRc38misPCG4kfHLHgRn1M9ckDpZxI8j7WKm
         IUX4VPyfmaL7Hs6NDirQ1iANOyYPwxeNCa1Yoksd340DCTM0FHvHjckWKfM3tHDNbqGP
         DRjyOZ8svOF3l2+37VkrB9h4LNxoqUgyzl2/vsR8Aw6ifksSzjiJbeoN1IXVnFy3tI1E
         KgZiIWjHC6Opix1B3yXx/4cjcd/hcz3lwzpVphEIQxevP/nLsV9VceC9jadAIGWpipWh
         DkbFNHGTeNTqUL463tWePJQF9Zn0Mq2e2Z8hkNLlfZjgyFKmN8ahX9KyDj4M7earZN89
         tXcw==
X-Gm-Message-State: AOAM530CXEMxhnyRYH3LkVG4lDv7EPjAPPwQLAysPphb91qrmF/O547I
        cytei3AoltbGBTlj3iRXxsXDSqtd1dovtqFhjVcwdQ==
X-Google-Smtp-Source: ABdhPJyknOwqxU5ETkne37G2eSRG0nmQg+LKD3m8TppD3zQF2UMZipDo/13yR1+ALt0EXhxSdbYpM3t9JhYZLky4VX0=
X-Received: by 2002:a25:2d64:: with SMTP id s36mr40509310ybe.412.1620232305426;
 Wed, 05 May 2021 09:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210505031416.30128-1-saravanak@google.com> <20210505054838.GA22603@wunner.de>
In-Reply-To: <20210505054838.GA22603@wunner.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 5 May 2021 09:31:09 -0700
Message-ID: <CAGETcx9EnNKwq-KQ5dDifAV25jsJ3WCv6iqs7TqsAgXaUfFgbg@mail.gmail.com>
Subject: Re: [PATCH v1] spi: Don't have controller clean up spi device before
 driver unbind
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 4, 2021 at 10:48 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Tue, May 04, 2021 at 08:14:16PM -0700, Saravana Kannan wrote:
> > @@ -415,6 +421,7 @@ static int spi_remove(struct device *dev)
> >                                ERR_PTR(ret));
> >       }
> >
> > +     spi_cleanup(to_spi_device(dev));
> >       dev_pm_domain_detach(dev, true);
> >
> >       return 0;
>
> Unfortunately this doesn't look right:  spi_remove() is run on
> driver unbind of the spi_device.  With the above change,
> ->setup is called on spi_device addition and ->cleanup is called
> on unbind, which is obviously assymetric.  What can happen
> here is that a slave-specific controller_state is allocated on
> spi_device addition, then on unbind that controller_state is freed
> and on a subsequent rebind it won't be recreated because ->setup
> isn't run on spi_device ->probe.

Good point!

>
> As I've written yesterday, calling spi_cleanup() in
> spi_unregister_device() should be fine if you move it to the end
> of the function, but before the final put_device().  For that,
> you need to open code the calls to device_del() and put_device()
> that happen in device_unregister() so far.

Yeah, I saw that email after I sent out this patch. I'll send out a v2.

-Saravana
