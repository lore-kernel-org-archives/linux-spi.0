Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31C9EB64DD
	for <linux-spi@archiver.kernel.org>; Wed,  5 Jul 2023 10:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjGEK0H (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 5 Jul 2023 06:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjGEK0G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jul 2023 06:26:06 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Jul 2023 03:26:01 PDT
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B12210E2
        for <linux-spi@vger.kernel.org>; Wed,  5 Jul 2023 03:26:00 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 2fe35dd4-1b1e-11ee-abf4-005056bdd08f;
        Wed, 05 Jul 2023 13:24:57 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 5 Jul 2023 13:24:56 +0300
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v2 3/5] spi: Add support for Renesas CSI
Message-ID: <ZKVE-AVDhvZyrJmj@surfacebook>
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
 <20230622113341.657842-4-fabrizio.castro.jz@renesas.com>
 <CAMuHMdVsYohH5FVv6r4ha0AaHRoHjNF1ErjW1FNF7ZAQR9ntxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVsYohH5FVv6r4ha0AaHRoHjNF1ErjW1FNF7ZAQR9ntxg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Mon, Jul 03, 2023 at 12:19:26PM +0200, Geert Uytterhoeven kirjoitti:
> On Thu, Jun 22, 2023 at 1:34 PM Fabrizio Castro
> <fabrizio.castro.jz@renesas.com> wrote:

...

> > +       if (csi->txbuf)
> > +               /*
> > +                * Leaving a little bit of headroom in the FIFOs makes it very
> > +                * hard to raise an overflow error (which is only possible
> > +                * when IP transmits and receives at the same time).
> > +                */
> > +               to_transfer = min_t(int, CSI_FIFO_HALF_SIZE, bytes_remaining);
> > +       else
> > +               to_transfer = min_t(int, CSI_FIFO_SIZE_BYTES, bytes_remaining);
> 
> Why min_t(int, ...)? Both values are int.

min_t() should be used with a great care.

> It would be better to make both unsigned, though.

I believe you are assuming 3 (three) values and not 2 (two) under "both"
(one variable and two definitions).

-- 
With Best Regards,
Andy Shevchenko


