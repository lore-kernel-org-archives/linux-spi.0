From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/8] spi: sh-msiof: Add sleep before master transfer for test
Date: Thu, 7 Sep 2017 10:11:02 +0200
Message-ID: <CAMuHMdV5vQsS5RgykMptRxDb1wgS9YryBQu7xgGHXactjGGWFA@mail.gmail.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com> <20170906070507.26223-2-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170906070507.26223-2-dirk.behme@de.bosch.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Dirk,

On Wed, Sep 6, 2017 at 9:05 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
>
> This patch is for debug of transfer between master and slave.
> Since the slave needs to complete a preparation in data transfer
> before the master working, the sleep wait is put before
> the data transfer of the master.
>
> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

IMHO this is a pure debug patch, not intended for upstream.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
