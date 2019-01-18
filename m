From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Fri, 18 Jan 2019 09:03:49 +0100
Message-ID: <CAMuHMdXiW=4qgZGFqvwGHL7V3ZHfQ2EJ2B96dG14B-jh5+XqOw@mail.gmail.com>
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw> <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Fri, Jan 18, 2019 at 6:55 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

Thanks for the update!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,37 @@
> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> +----------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be

    compatible: should be an SoC-specific compatible value, followed by
    "renesas,rcar-gen3-rpc" as a fallback.

    Examples of the latter are:
      - "renesas,r8a7795-rpc" (R-Car H3).

This makes it future-proof, in case the RPC on a specific SoC version needs
to be handled specially. We already know that is the case for R-Car V3M.

> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain three register areas:
> +       first for the base address of rpc-if registers,
> +       second for the direct mapping read mode and
> +       third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clock-names: should contain "rpc"
> +- clocks: should contain 1 entries for the module's clock
> +
> +Example:
> +
> +       rpc: rpc@ee200000 {
> +               compatible = "renesas,rcar-gen3-rpc";

compatible = "renesas,r8a7795-rpc," renesas,rcar-gen3-rpc";

> +               reg = <0 0xee200000 0 0x7fff>, <0 0x08000000 0 0x4000000>,
> +                     <0 0xee208000 0 0x100>;
> +               reg-names = "regs", "dirmap", "<wbuf>;
> +               clocks = <&cpg CPG_MOD 917>;
> +               power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +               resets = <&cpg 917>;
> +               clock-names = "rpc";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               flash@0 {
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
