Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FB3EB64DA
	for <linux-spi@archiver.kernel.org>; Wed,  5 Jul 2023 11:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjGELhS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 5 Jul 2023 07:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGELhR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jul 2023 07:37:17 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1686A198E;
        Wed,  5 Jul 2023 04:37:08 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bdd069e96b5so7281508276.2;
        Wed, 05 Jul 2023 04:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688557027; x=1691149027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIVoG4v17dHAi8V71wyhSONdUpfRCtIrSHRM3VwF7JI=;
        b=DmbdWb9ON38EkXpnF02SCfdiTySYvhgXR74dRlFl42rJtVhs+NAoEhq+0MxtybKmbc
         0r7AAqb7CGIiHtu68mZk8TC839xHab8LhQ37tCiYrY1T4LIVEqutgaYO3lvkaKoce2JP
         E25jNM9w+AMQVGUNgrCO8FDXX4Y5QRDHlSgLEy65dhLOF58HSB8M0w/cCD4sYNWCBD5f
         rBw9YH/0SdLR0y5EU6CJFV3PviiL4T+YUp9ED94rClr/qc1EJOG+04wlbl7QoH3D5bnI
         Ao46GdQj8zIIzHEiZbA+SZIMKs+fnZgHjbhc9mUYyNAA5BY6q79dNJczbx1znRzM6BNe
         CE5A==
X-Gm-Message-State: ABy/qLZofFwwNyVypWV0x2wvvOYNz0wLAakEMtQcxBlcCyylXqe/z5mj
        PSi7zzkBlF5oW6fOiyhtfRXRmWiCY3Milg==
X-Google-Smtp-Source: APBJJlGf6Oo6X2P+loC9JZgJVpAlVChmIdYgc1NWcGb3KGPvcsVgLtnrvfEm3JXFmYThz3B91w6K3Q==
X-Received: by 2002:a05:6902:28c:b0:c37:f855:cff4 with SMTP id v12-20020a056902028c00b00c37f855cff4mr13407380ybh.63.1688557026831;
        Wed, 05 Jul 2023 04:37:06 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id d13-20020a25e60d000000b00c4eec81ac9esm1743975ybh.11.2023.07.05.04.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 04:37:06 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-c50c797c31bso3951432276.0;
        Wed, 05 Jul 2023 04:37:06 -0700 (PDT)
X-Received: by 2002:a25:6fc6:0:b0:c16:859a:9633 with SMTP id
 k189-20020a256fc6000000b00c16859a9633mr14065137ybc.39.1688557025822; Wed, 05
 Jul 2023 04:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
 <20230622113341.657842-4-fabrizio.castro.jz@renesas.com> <CAMuHMdVsYohH5FVv6r4ha0AaHRoHjNF1ErjW1FNF7ZAQR9ntxg@mail.gmail.com>
 <ZKVE-AVDhvZyrJmj@surfacebook>
In-Reply-To: <ZKVE-AVDhvZyrJmj@surfacebook>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Jul 2023 13:36:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUzcc0HSyOwbN4mJPRfEKcLXBU3Op=T1CGR=pFbN619Pw@mail.gmail.com>
Message-ID: <CAMuHMdUzcc0HSyOwbN4mJPRfEKcLXBU3Op=T1CGR=pFbN619Pw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] spi: Add support for Renesas CSI
To:     andy.shevchenko@gmail.com
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andy,

On Wed, Jul 5, 2023 at 12:24 PM <andy.shevchenko@gmail.com> wrote:
> Mon, Jul 03, 2023 at 12:19:26PM +0200, Geert Uytterhoeven kirjoitti:
> > On Thu, Jun 22, 2023 at 1:34 PM Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com> wrote:
> > > +       if (csi->txbuf)
> > > +               /*
> > > +                * Leaving a little bit of headroom in the FIFOs makes it very
> > > +                * hard to raise an overflow error (which is only possible
> > > +                * when IP transmits and receives at the same time).
> > > +                */
> > > +               to_transfer = min_t(int, CSI_FIFO_HALF_SIZE, bytes_remaining);
> > > +       else
> > > +               to_transfer = min_t(int, CSI_FIFO_SIZE_BYTES, bytes_remaining);
> >
> > Why min_t(int, ...)? Both values are int.
>
> min_t() should be used with a great care.
>
> > It would be better to make both unsigned, though.
>
> I believe you are assuming 3 (three) values and not 2 (two) under "both"
> (one variable and two definitions).

:-)

I meant "both numerical parametric values of each minimum operation".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
