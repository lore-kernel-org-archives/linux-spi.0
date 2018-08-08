From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: Re: [PATCH] spi: dw: support 4-16 bits per word
Date: Wed, 8 Aug 2018 13:58:35 +0200
Message-ID: <CAAh8qswXPmcT94x69qDmf8RumT4+uRBwQEvJSu9agaq_e7FH-Q@mail.gmail.com>
References: <20180808071421.32707-1-simon.k.r.goldschmidt@gmail.com> <CAHp75VdmrwZ4P0xrOOqpJaU7iuKS8zXGcRTg4zLrofZLdcb=8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: andy.shevchenko@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdmrwZ4P0xrOOqpJaU7iuKS8zXGcRTg4zLrofZLdcb=8Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 8, 2018 at 11:45 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Aug 8, 2018 at 10:14 AM, Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com> wrote:
> > The spi-dw driver currently only supports 8 or 16 bits per word.
> >
> > Since the hardware supports 4-16 bits per word, adapt the driver
> > to also support this.
> >
> > Tested on socfpga cyclone5 with a 9-bit SPI display.
>
> > +       if ((transfer->bits_per_word < 4) || (transfer->bits_per_word > 16))
> > +               return -EINVAL;
>
> > +       if (transfer->bits_per_word <= 8) {
> >                 dws->n_bytes = 1;
> >                 dws->dma_width = 1;
> > -       } else if (transfer->bits_per_word == 16) {
> > +       } else {
> >                 dws->n_bytes = 2;
> >                 dws->dma_width = 2;
> >         }
>
> Now these can be just
>
> n_bytes = round_up(8);
> dma_width = round_up(8);

I guess you mean:

n_bytes = round_up(transfer->bits_per_word, 8);

But that would yield 8 or 16 where we need 1 or 2.

Reading spi-imx.c, this might work:

n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);


Simon
