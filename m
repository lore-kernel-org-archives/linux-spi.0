From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: sprd: Use 'spi_master_put()' instead of 'spi_controller_put()'
Date: Fri, 26 Jan 2018 17:16:34 +0100
Message-ID: <CAMuHMdXMndPDnCYyfxJ8=mrJdWTdn-ANqwGHkY8+BAVUYBm4NA@mail.gmail.com>
References: <20180126155256.25956-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20180126155256.25956-1-christophe.jaillet@wanadoo.fr>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Christophe,

On Fri, Jan 26, 2018 at 4:52 PM, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> 'spi_alloc_master()' calls should be balanced by a 'spi_master_put()' call.
>
> 'spi_controller_put()' is equivalent (see include/linux/spi/spi.h) but it
> is cleaner and more logical to use 'spi_master_put()'.

My intention was to phase out the spi_master_* names, and remove them
when there are no users left.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
