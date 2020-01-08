From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] spi: sh-msiof: Do not redefine STR while compile testing
Date: Wed, 8 Jan 2020 08:18:50 +0100
Message-ID: <20200108071850.GA9762@pi3>
References: <1578416218-11112-1-git-send-email-krzk@kernel.org>
 <CAMuHMdXZGqqu+rWmemzxYtSNXofeCwLwerCeb-hEoubTvBqwXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXZGqqu+rWmemzxYtSNXofeCwLwerCeb-hEoubTvBqwXw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 07, 2020 at 09:10:37PM +0100, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Tue, Jan 7, 2020 at 5:57 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > STR is a well-known stringify macro so it should be avoided in drivers
> > to avoid warnings like this (MIPS architecture while compile testing):
> >
> >     drivers/spi/spi-sh-msiof.c:76:0: warning: "STR" redefined
> >      #define STR 0x40 /* Status Register */
> >     arch/mips/include/asm/mipsregs.h:30:0: note: this is the location of the previous definition
> >      #define STR(x) __STR(x)
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Thanks for your patch!
> 
> > --- a/drivers/spi/spi-sh-msiof.c
> > +++ b/drivers/spi/spi-sh-msiof.c
> > @@ -73,7 +73,7 @@ struct sh_msiof_spi_priv {
> >  #define RSCR   0x22    /* Receive Clock Select Register (SH, A1, APE6) */
> >  #define CTR    0x28    /* Control Register */
> >  #define FCTR   0x30    /* FIFO Control Register */
> > -#define STR    0x40    /* Status Register */
> > +#define STATR  0x40    /* Status Register */
> 
> The datasheets call this register "SISTR", so I prefer to use that instead.
> Actually all registers have this "SI" ("Serial Interface"?) prefix.
> Shall I add this to my TODO-list?

I can send a v2 changing all register names there to SISTR-like names.

Best regards,
Krzysztof
