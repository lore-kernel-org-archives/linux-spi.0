Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB82C433F5
	for <linux-spi@archiver.kernel.org>; Mon,  2 May 2022 15:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbiEBPk0 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 2 May 2022 11:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiEBPk0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 May 2022 11:40:26 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A1B1013;
        Mon,  2 May 2022 08:36:57 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id y3so11339159qtn.8;
        Mon, 02 May 2022 08:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDoz5j+pxxlLo8BZzNVeFJ18NZpMv98cHB+e5SciXrI=;
        b=YlXXX6SwETQr4cO4SWEtRNL23hpOufVuDqmQODbAPFXVW7t91dnBlQIXsoBRMye4Ob
         l2CELWbxZERLKzVFdXsxks2TR/lVUz/OjvLdCU+56wOEbSF+NhDl4B6fLd9zRNwxqRhS
         BGESwfJqgtgMokUc9hiLzNsjstnbvBbG06kZQSI6okYDzxAixGAwqY8c+rOHYfSEXbVu
         Mo5ye3/G7Bri9FcGc82Fu2DqGWmmKeBF0H9etK0Qq8o+BF3L9DEx8g86ruarOpPmkcqC
         1JEWqJnnRQX+DSWdfPe5s1qGWfRYM7WE8CXosFvDdbI+AjFpJICqC2Mxpx9GvVQbq4RW
         WlSw==
X-Gm-Message-State: AOAM5319V66UbdsWpqIzZu4K+KZVGIB+4y3/RPWwTOnx5O2JRIa95vjB
        8wbwBos2doQcggYcyOzd5ObHiL9doAa3ew==
X-Google-Smtp-Source: ABdhPJwpy8PIOwnZjUxgUGnaF5I6e3yBHOWnZaCARHj7giqBxS1ZEhZgndDu5d4gNG+HR82uUoNHFg==
X-Received: by 2002:a05:622a:1906:b0:2f3:a3f2:c50b with SMTP id w6-20020a05622a190600b002f3a3f2c50bmr5341388qtc.391.1651505816361;
        Mon, 02 May 2022 08:36:56 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id l20-20020ac84a94000000b002f39b99f676sm4358068qtq.16.2022.05.02.08.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 08:36:56 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2f7d19cac0bso151631197b3.13;
        Mon, 02 May 2022 08:36:55 -0700 (PDT)
X-Received: by 2002:a05:690c:84:b0:2f1:9caa:e4f7 with SMTP id
 be4-20020a05690c008400b002f19caae4f7mr12285991ywb.384.1651505815633; Mon, 02
 May 2022 08:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220501082150.24662-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220501082150.24662-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 May 2022 17:36:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV3sGMxYRSKay=7oM07H2EBW1zeOH090jfaQxhEX9DGHw@mail.gmail.com>
Message-ID: <CAMuHMdV3sGMxYRSKay=7oM07H2EBW1zeOH090jfaQxhEX9DGHw@mail.gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: renesas,rspi: Document RZ/G2UL SoC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, May 1, 2022 at 10:22 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Add RSPI binding documentation for Renesas RZ/G2UL SoC.
>
> RSPI block is identical to one found on RZ/A, so no driver changes are
> required. The fallback compatible string "renesas,rspi-rz" will be used
> on RZ/G2UL.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
