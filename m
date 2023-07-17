Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9356C001E0
	for <linux-spi@archiver.kernel.org>; Mon, 17 Jul 2023 09:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjGQJuG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 17 Jul 2023 05:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjGQJuG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jul 2023 05:50:06 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2ED123;
        Mon, 17 Jul 2023 02:50:04 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5700b15c12fso42988687b3.1;
        Mon, 17 Jul 2023 02:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689587404; x=1692179404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QamgJcpJX+0EPK7nNbsMFG2BdXvGZpu2smwa9LegFAM=;
        b=Rz3delMOIq31VA09K9i3x7KU72Ii6zHa/DLqhkzjmCJ32pB5nBCdY6s8iLyntBKbD2
         YG2CtBVXMmM0lOq6C6DWLMvVBy4pc0LhyczGXPOS47Z0W3ksQEXd9tRvIo5bsSGlikaO
         ZJ+mjNBzYEsq2e+vqow231MNc+wFNchAnaOybxo/hvUz6UHl0Dt7bs01iCpMoLcWXyUx
         Px1XgYP8Y2q4rvIKQvyGFcZr0+Itd5d4CHkeb76U9l0mpp3gs+md7jVJ8kt4/UIHJzcu
         h9Gn/x+QjhI8zltplxDblMAWX2DPdi289stlnzphUIB6dm6RWJEQIBCed2Py573JZogG
         5b4Q==
X-Gm-Message-State: ABy/qLaK3FOtvkolGFvoFYcyyA+A9RPKksuDJcw08Wmld9zGHOmLeT9s
        O3Z+tRrhj1DKcs2aIZOr+P9j5AU8bHwApw==
X-Google-Smtp-Source: APBJJlG/+FjJqBqZSd1KAOeh8I8lrjzqJvtwXQuF4nrQebRa0M6egdxsgoAYtJ/bNOfRyCo6OQGxLg==
X-Received: by 2002:a0d:cc94:0:b0:579:fd23:5946 with SMTP id o142-20020a0dcc94000000b00579fd235946mr11984329ywd.22.1689587404013;
        Mon, 17 Jul 2023 02:50:04 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id w184-20020a817bc1000000b0055a07e36659sm3704731ywc.145.2023.07.17.02.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 02:50:03 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so4366643276.0;
        Mon, 17 Jul 2023 02:50:03 -0700 (PDT)
X-Received: by 2002:a5b:c4c:0:b0:cab:e9f8:a150 with SMTP id
 d12-20020a5b0c4c000000b00cabe9f8a150mr10039205ybr.60.1689587403593; Mon, 17
 Jul 2023 02:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com> <20230715010407.1751715-10-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230715010407.1751715-10-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 11:49:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV7KioHHXNBw-gaL1MFfqaXbYwUQrrtz9W0ynwi5RBWYQ@mail.gmail.com>
Message-ID: <CAMuHMdV7KioHHXNBw-gaL1MFfqaXbYwUQrrtz9W0ynwi5RBWYQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] spi: rzv2m-csi: Get rid of the x_trg{_words} tables
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Jul 15, 2023 at 3:04 AM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> Table x_trg can be replaced with ilog2(), and table x_trg_words
> can be replaced with rounddown_pow_of_two().
> Replace the tables usage with the corresponding macros.
> While at it, remove a couple of unnecessary empty lines.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
