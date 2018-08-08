From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] spi: dw: support 4-16 bits per word
Date: Wed, 8 Aug 2018 15:26:02 +0300
Message-ID: <CAHp75Vc24DM9jqBdKa1xjXfJjA_BpZq9H1PAwM36sQGfZ99zFw@mail.gmail.com>
References: <20180808071421.32707-1-simon.k.r.goldschmidt@gmail.com>
 <CAHp75VdmrwZ4P0xrOOqpJaU7iuKS8zXGcRTg4zLrofZLdcb=8Q@mail.gmail.com> <CAAh8qswXPmcT94x69qDmf8RumT4+uRBwQEvJSu9agaq_e7FH-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAh8qswXPmcT94x69qDmf8RumT4+uRBwQEvJSu9agaq_e7FH-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 8, 2018 at 2:58 PM, Simon Goldschmidt
<simon.k.r.goldschmidt@gmail.com> wrote:
> On Wed, Aug 8, 2018 at 11:45 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Wed, Aug 8, 2018 at 10:14 AM, Simon Goldschmidt
>> <simon.k.r.goldschmidt@gmail.com> wrote:

>> n_bytes = round_up(8);
>> dma_width = round_up(8);
>
> I guess you mean:
>
> n_bytes = round_up(transfer->bits_per_word, 8);
>
> But that would yield 8 or 16 where we need 1 or 2.

Indeed.

> Reading spi-imx.c, this might work:
>
> n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);

Yes.

-- 
With Best Regards,
Andy Shevchenko
