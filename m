From: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] dt-binding: spi: add bindings for spi-ar934x
Date: Fri, 7 Feb 2020 13:55:49 +0800
Message-ID: <CAJsYDVKXvAkQawwayX8JVrjvEKPuTyQXE8rw=BRiyVROKrdWrg@mail.gmail.com>
References: <20200206150626.708649-1-gch981213@gmail.com> <20200206150626.708649-3-gch981213@gmail.com>
 <20200206205551.GA15172@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200206205551.GA15172@bogus>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Feb 7, 2020 at 4:55 AM Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Thu,  6 Feb 2020 23:06:26 +0800, Chuanhong Guo wrote:
> > Add binding documentation for SPI controller in Qualcomm Atheros
> > AR934x/QCA95xx SoCs.
> >
> > Signed-off-by: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> > Changes since v1: none
> >  .../bindings/spi/qca,ar934x-spi.yaml          | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> Error: Documentation/devicetree/bindings/spi/qca,ar934x-spi.example.dts:20.28-29 syntax error
> FATAL ERROR: Unable to parse input tree
> scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/spi/qca,ar934x-spi.example.dt.yaml' failed
> make[1]: *** [Documentation/devicetree/bindings/spi/qca,ar934x-spi.example.dt.yaml] Error 1
> Makefile:1263: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
> See https://patchwork.ozlabs.org/patch/1234394
> Please check and re-submit.

It's caused by "clocks = <&pll ATH79_CLK_AHB>" where ATH79_CLK_AHB
isn't defined without a include of dt-bindings/clock/ath79-clk.h
I'll replace this with a bogus "clocks = <&spi_clock>" instead in v3.

Regards,
Chuanhong Guo
