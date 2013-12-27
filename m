From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/8] spi: rspi: Add prelimary support for RZ/A1H
Date: Fri, 27 Dec 2013 20:22:09 +0100
Message-ID: <CAMuHMdX=CX-vAmiJvo5M2ZNCb+Uga9x4KTTYVC920d5bMxqszQ@mail.gmail.com>
References: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 24, 2013 at 12:40 PM, Geert Uytterhoeven
<geert+renesas@linux-m68k.org> wrote:
> This patch series adds preliminary support for RSPI in the RZ/A1H aka
> R7S72100 SoC, which is found on the Genmai development board.
>
> It hasn't received much testing, so please don't apply yet.

In the mean time this has received some more testing on the Genmai
development board, using loopback mode, with the same outcome as
the SDK reference code.

>     [1/8] spi: rspi: Add more RSPI register documentation
>     [2/8] spi: rspi: Add more QSPI register documentation
>     [3/8] spi: rspi: Add support for more than one interrupt
>     [4/8] spi: rspi: Add support for 8-bit Data Register access
>     [5/8] spi: rspi: Add support for no TX only mode
>     [6/8] spi: rspi: Add support for missing SPCR2 register
>     [7/8] spi: rspi: Add support for specifying CPHA/CPOL
>     [8/8] spi: rspi: Add support for loopback mode

No changes needed to the code, one silly spelling typo in the summary
of [5/8] (s/nevers/never/). Anyway, will resend the series later.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
