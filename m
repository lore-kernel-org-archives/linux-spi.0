From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Fri, 18 Jan 2019 09:10:52 +0100
Message-ID: <CAMuHMdWwvY=4NgoJmjfpOnetNwxPWqCsH-k-y5FqrbRif_PB7g@mail.gmail.com>
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
 <CAMuHMdXiW=4qgZGFqvwGHL7V3ZHfQ2EJ2B96dG14B-jh5+XqOw@mail.gmail.com> <dc043bfe-7a56-9810-1e5e-802f8b6beee2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mason Yang <masonccyang@mxic.com.tw>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Marek Vasut <marek.vasut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dc043bfe-7a56-9810-1e5e-802f8b6beee2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Marek,

On Fri, Jan 18, 2019 at 9:08 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 1/18/19 9:03 AM, Geert Uytterhoeven wrote:
> > On Fri, Jan 18, 2019 at 6:55 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt

> >> +Example:
> >> +
> >> +       rpc: rpc@ee200000 {
> >> +               compatible = "renesas,rcar-gen3-rpc";
> >
> > compatible = "renesas,r8a7795-rpc," renesas,rcar-gen3-rpc";
>
> Without the extra comma after r8a7795-rpc, of course ;-)

Let's move it after the closing double quotes. Would that be OK for you? ^-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
