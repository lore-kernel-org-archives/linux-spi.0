From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v14 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Wed, 10 Jul 2019 09:22:47 +0200
Message-ID: <CAMuHMdUPmj0tAhJ18DhQEbYxP7g4MMBMe0U_2eQFQ7mOq4ZFLQ@mail.gmail.com>
References: <1561023046-20886-1-git-send-email-masonccyang@mxic.com.tw> <1561023046-20886-3-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, juliensu@mxic.com.tw,
        Simon Horman <horms@verge.net.au>,
        Miquel Raynal <miquel.raynal@bootlin.com>
To: Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1561023046-20886-3-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Thu, Jun 20, 2019 at 11:08 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Dcument the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

Thanks for your patch!

> index 0000000..e8edf99
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,43 @@
> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> +---------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +               "renesas,rcar-gen3-rpc" as a fallback.
> +               supported SoC-specific values are:
> +               "renesas,r8a77980-rpc"  (R-Car V3H)
> +               "renesas,r8a77995-rpc"  (R-Car D3)
> +- reg: should contain three register areas:
> +       first for the base address of RPC-IF registers,
> +       second for the direct mapping read mode and
> +       third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clocks: should contain the clock phandle/specifier pair for the module clock.
> +- clock-names: should contain "rpc"
> +- power-domain: should contain the power domain phandle/secifier pair.

power-domains

> +- resets: should contain the reset controller phandle/specifier pair.
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +
> +Example:
> +
> +       rpc: spi@ee200000 {
> +               compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
> +               reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
> +                     <0 0xee208000 0 0x100>;
> +               reg-names = "regs", "dirmap", "wbuf";
> +               clocks = <&cpg CPG_MOD 917>;
> +               clock-names = "rpc";
> +               power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +               resets = <&cpg 917>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               flash@0 {

The subnode is not documented above.

> +                       compatible = "jedec,spi-nor";
> +                       reg = <0>;
> +                       spi-max-frequency = <40000000>;
> +                       spi-tx-bus-width = <1>;
> +                       spi-rx-bus-width = <1>;
> +               };
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
