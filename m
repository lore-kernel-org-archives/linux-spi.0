From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH -next] spi: Fix double IDR allocation with DT aliases
Date: Tue, 21 Aug 2018 19:42:03 +0200
Message-ID: <CAMuHMdVUomvhM=ag2n4DKf6hwX+J+YL+stA2Z3dQeod2RAwKKQ@mail.gmail.com>
References: <20180821095303.27664-1-geert+renesas@glider.be> <20180821134044.GA18693@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        kirill.kapranov@compulab.co.il,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
To: Greg KH <greg@kroah.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180821134044.GA18693@kroah.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Greg,

On Tue, Aug 21, 2018 at 3:40 PM Greg KH <greg@kroah.com> wrote:
> On Tue, Aug 21, 2018 at 11:53:03AM +0200, Geert Uytterhoeven wrote:
> > If the SPI bus number is provided by a DT alias, idr_alloc() is called
> > twice, leading to:
> >
> >     WARNING: CPU: 1 PID: 1 at drivers/spi/spi.c:2179 spi_register_controller+0x11c/0x5d8
> >     couldn't get idr
> >
> > Fix this by moving the handling of fixed SPI bus numbers up, before the
> > DT handling code fills in ctlr->bus_num.
> >
> > Fixes: 1a4327fbf4554d5b ("spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Seen on e.g. r8a7791/koelsch, breaking both RSPI and MSIOF.
> > ---
> >  drivers/spi/spi.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>

I know.

I only CCed stable because the acceptance email for the original patch was
CCed to stable, and I wanted to prevent that one from being backported early.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
