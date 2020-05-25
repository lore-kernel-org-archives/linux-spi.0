Return-Path: <SRS0=1rUC=7H=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1A0C433DF
	for <linux-spi@archiver.kernel.org>; Mon, 25 May 2020 12:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B6D20812
	for <linux-spi@archiver.kernel.org>; Mon, 25 May 2020 12:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHchiWv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390539AbgEYMX4 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 25 May 2020 08:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390531AbgEYMX4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 May 2020 08:23:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F95BC05BD43
        for <linux-spi@vger.kernel.org>; Mon, 25 May 2020 05:23:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a25so8899245ljp.3
        for <linux-spi@vger.kernel.org>; Mon, 25 May 2020 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1neDSVvo2exAwO7XG1Q7asHC8C/uLbtbXAanu+QhUvY=;
        b=mHchiWv9d+bl7TypEyswUYJoJBznRNEzkaqNXJ6yZYcwVhCmDlHeQE5uaH/HclG1/A
         Bx4Cg9tDzYVicfaKmVDBhYVOUgLefRTuPj7YFVjqzZ8YnTP/1LLLJTykYqXl+FHN2pZL
         g8xP1m6SXMaHEiGtmqiEB2IP7G+kpZcs9VS8hZv85N+n3X6CdpddRhU6y1nCKsAQzFCY
         4rfmeLIz/oOwhxkepv8pd1oS85BdwpikntEpMCfo0gVE3d09pfC4AhwFL/nAFV+L4+Zb
         mwcQqn4CqSg3gj+nOH2kk2AibQMFcCPYOzlGhx/9SXJpErxweRkVif+GCa4LGQO8gvT9
         9trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1neDSVvo2exAwO7XG1Q7asHC8C/uLbtbXAanu+QhUvY=;
        b=L+HebafKNrdtXnsLMVPBH/GrUrBHL5a4z+xMiTpcnYBUhaNE96eJw4qVQpqaS9bG5r
         FZ5aFVTl572QR5EY+Ej3Y9rpnJ9iPcpxLme0GaOKzE825nSGqigY0UoJlyoN5v8AZk3n
         9+p3h4hh4sE6ey7/n/O+8H8yEKMUJXx7wz9/P/vWWXJUF0z8NlQffCBjHgkv0JBnDDrw
         n1NIQhsW2j8r1dG2ApDx7MHQaUVJAyzl/kkc4BjNI+/uKpOgBwpyKAgC81tDCTa56Xki
         Z1l51xcQhgCxhHU0jcZj9yazcIKZhg5Oh0v5e2yfZ9uses2lqCKfID04trvzdIKbHqd9
         kHMw==
X-Gm-Message-State: AOAM532A6/xJiib90N1q7sqyrmZZSA+4245zss4FvtKmMx4Fl+avmyK0
        TS26b6Pd4PLY2W2HqyQvsphi+W8GOHyztp8lS6lk3g==
X-Google-Smtp-Source: ABdhPJyf5wZA8Fh7xQjtaNnLLHBTpAkEbLAQIKhyb7JglaMhaJDSU7UOMtER0/cndL74Gsc/vcIt53XFGmKsX5AJ0t0=
X-Received: by 2002:a2e:711c:: with SMTP id m28mr13451102ljc.104.1590409434478;
 Mon, 25 May 2020 05:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com> <1590378348-8115-7-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1590378348-8115-7-git-send-email-dillon.minfei@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 14:23:43 +0200
Message-ID: <CACRpkda26eQZGMfbq-FL9X532mK=Z87GotjYMu2MWNGgNohp7A@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] drm/panel: Add ilitek ili9341 panel driver
To:     dillon min <dillon.minfei@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 25, 2020 at 5:46 AM <dillon.minfei@gmail.com> wrote:

> From: dillon min <dillon.minfei@gmail.com>
>
>     This driver combine tiny/ili9341.c mipi_dbi_interface driver
>     with mipi_dpi_interface driver, can support ili9341 with serial
>     mode or parallel rgb interface mode by register configuration.
>
> Changes since V3:
>
>     accoding to Linus Walleij's suggestion.
>     1 add more comments to driver.
>     2 reduce magic number usage in the driver.
>     3 move panel configuration from common place to system configuration.
>     4 reuse MIPI_DCS_* as more as possible.
>
> Signed-off-by: dillon min <dillon.minfei@gmail.com>

This looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
