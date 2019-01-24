From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
Date: Thu, 24 Jan 2019 10:12:54 +0100
Message-ID: <CAMuHMdU7wOzG4T5DZoNOhmcspTsGQ7Rd6T6fQjB6o0CeZ5yxhg@mail.gmail.com>
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
 <12af2632-491d-0e01-66c9-0ead4f9d985a@cogentembedded.com> <OFC86383C3.5347178A-ON4825838C.00093E95-4825838C.000B9D6F@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>, zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFC86383C3.5347178A-ON4825838C.00093E95-4825838C.000B9D6F@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Thu, Jan 24, 2019 at 3:07 AM <masonccyang@mxic.com.tw> wrote:
> > "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
> > 2019/01/24 上午 02:04

> > > +static const struct of_device_id rpc_spi_of_ids[] = {
> > > +   { .compatible = "renesas,r8a77995-rpc", },
> >
> >    Why (if it has no differences with the generic gen3 value below)?
> > Please remove.
>
> By Geert's comments in dts,
>
>          rpc: rpc@ee200000 {
>                 compatible = "renesas,r8a7795-rpc", "renesas,rcar-gen3-rpc";
>                 reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
>                       <0 0xee208000 0 0x100>;
>
> I modified it to "renesas,r8a77995-rpc" because this is Soc I developed and validated.

There's a difference between compatible values in DT and in drivers:
  - DT should list all compatible values that are applicable, from
    most-specific to least-specific,
  - Drivers should match against the least-specific compatible value that
    is sufficient to get the job done.
    In this case, that's "renesas,rcar-gen3-rpc".

The driver will probably have to be extended to match against
"renesas,r8a77970-rpc" when R-Car V3M support is added, as RPC on V3M
has an extra register that must be set, and thus cannot be declared
compatible with "renesas,rcar-gen3-rpc".

I hope this explanation makes it clearer.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
