From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v15 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Mon, 29 Jul 2019 11:36:20 +0200
Message-ID: <CAMuHMdXDJFWHaXk3KHQqhOqVhEGc3PL33f+HO2Ld8nYbvSpq7Q@mail.gmail.com>
References: <1564108975-27423-1-git-send-email-masonccyang@mxic.com.tw>
 <1564108975-27423-3-git-send-email-masonccyang@mxic.com.tw>
 <CAMuHMdWVuQa1LLXPqrdSw6wdRzwQapAkk6Est=XrjESPF9zQwg@mail.gmail.com> <OFFF9D8385.D8395BBD-ON48258446.0033FD62-48258446.00349608@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFFF9D8385.D8395BBD-ON48258446.0033FD62-48258446.00349608@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Mon, Jul 29, 2019 at 11:34 AM <masonccyang@mxic.com.tw> wrote:
> > On Fri, Jul 26, 2019 at 4:19 AM Mason Yang <masonccyang@mxic.com.tw>
> wrote:
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> > > @@ -0,0 +1,46 @@
> >
> > [...]
> >
> > > +- flash: should be represented by a subnode of the RPC-IF node,
> > > +        which "compatible" property contains "jedec,spi-nor", it
> presents
> > > +        SPI is used.
> >
> > Sorry, I failed to parse the last subsentence.
>
>
> Fix it to:
> - flash: should be represented by a subnode of the RPC-IF node,
>          its "compatible" property contains "jedec,spi-nor" presents
>          SPI is used.
>
> OK?

s/presents/if/?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
