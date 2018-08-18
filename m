From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: Re: [PATCH v2] spi: dw: support 4-16 bits per word
Date: Sat, 18 Aug 2018 10:37:01 +0200
Message-ID: <CAAh8qszwWsSTPhK_aLziy8px9hOyixGN50m6YMA_5Rb2w23zaw@mail.gmail.com>
References: <20180808071421.32707-1-simon.k.r.goldschmidt@gmail.com>
 <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com> <1534523550.2283.397.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>
To: tpiepho@impinj.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534523550.2283.397.camel@impinj.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Aug 17, 2018 at 6:32 PM Trent Piepho <tpiepho@impinj.com> wrote:
>
> On Fri, 2018-08-17 at 09:01 +0200, Simon Goldschmidt wrote:
> > The spi-dw driver currently only supports 8 or 16 bits per word.
> >
> > Since the hardware supports 4-16 bits per word, adapt the driver
> > to also support this.
> >
> >
>
> > @@ -307,15 +307,13 @@ static int dw_spi_transfer_one(struct spi_controller *master,
> > +
> > +     if ((transfer->bits_per_word < 4) || (transfer->bits_per_word > 16))
> >               return -EINVAL;
> > -     }
>
> You don't need this check as the spi core validates the transfer
> against master->bits_per_word_mask.

Ok.

>
> >       master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
> > -     master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
> > +     master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(4, 16);
> >       master->bus_num = dws->bus_num;
> >
