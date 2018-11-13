From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 2/6] spi: Deal with slaves that return from
 transfer_one() unfinished
Date: Tue, 13 Nov 2018 11:33:43 +0100
Message-ID: <CAMuHMdU0_CnXGzWNkb4q1dm1yoVOkG=Hhr0BnS3dYdjd-7A-+Q@mail.gmail.com>
References: <20181113102228.820214-1-lkundrak@v3.sk> <20181113102228.820214-3-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, quozl@laptop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113102228.820214-3-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Nov 13, 2018 at 11:23 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> Some drivers, such as spi-pxa2xx return from the transfer_one callback
> immediately, idicating that the transfer will be finished asynchronously.
>
> Normally, spi_transfer_one_message() synchronously waits for the
> transfer to finish with wait_for_completion_timeout(). For slaves, we
> don't want the transaction to time out as it can complete in a long time
> in future. Use wait_for_completion_interruptible() instead.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
