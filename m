From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
Date: Thu, 17 Jan 2019 09:19:10 +0100
Message-ID: <CAMuHMdWQm1hFxS6ScUpP=xbPPQObuyzDoJLaNr1vpJuhtakasQ@mail.gmail.com>
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
 <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw>
 <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com> <OFBBA60D64.FFD34553-ON48258384.00315BB0-48258384.0034A5C7@mxic.com.tw>
 <30d678b9-2b49-1f82-3027-332d213b488e@cogentembedded.com> <OFFCBB6F75.77BB80DE-ON48258385.0020045C-48258385.0023EF3B@mxic.com.tw>
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
In-Reply-To: <OFFCBB6F75.77BB80DE-ON48258385.0020045C-48258385.0023EF3B@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Thu, Jan 17, 2019 at 7:32 AM <masonccyang@mxic.com.tw> wrote:
> > "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
> > 2019/01/17 上午 03:36
> > >>
> > >> [...]
> > >> > +#define RPC_WBUF      0x8000   // Write Buffer
> > >> > +#define RPC_WBUF_SIZE      256   // Write Buffer size
> > >>
> > >>    I wonder if the write buffer should be in a separate "reg" prop tuple...
> > >> Have you considered that?
> > >>
> > >
> > > I don't get your point!
> >
> >    I mean that the write buffer should be a separate "reg" property
> > address/size tuple,
> > so that the RPC device has 3 memory resources. Our SPI driver used
> > this scheme, and I
> > like it.
> >
>
> I got your point but I think this RPC_WBUF@0xEE20_8000 is in the same group
> and it's size only 256 bytes, not like external address space read mode
> @0x0800_0000 w/ 64K bytes.
>
> Maybe Geert or Marek could comment on it, thanks.

Given the writer buffer is separate from the other registers (it's in
a different
4 KiB page, and thus may be at a different offset on future SoCs), and not
present on RZ/A1, I think it's a good idea to use a separate reg entry for it.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
