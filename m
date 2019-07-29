From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v15 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Mon, 29 Jul 2019 11:15:40 +0200
Message-ID: <CAMuHMdWVuQa1LLXPqrdSw6wdRzwQapAkk6Est=XrjESPF9zQwg@mail.gmail.com>
References: <1564108975-27423-1-git-send-email-masonccyang@mxic.com.tw> <1564108975-27423-3-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, juliensu@mxic.com.tw,
        Simon Horman <horms@verge.net.au>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
To: Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1564108975-27423-3-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

Thanks for the update!

On Fri, Jul 26, 2019 at 4:19 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Dcument the bindings used by the Renesas R-Car Gen3 RPC-IF controller.

Document

>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Reviewed-by: Rob Herring <robh@kernel.org>

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,46 @@

[...]

> +- flash: should be represented by a subnode of the RPC-IF node,
> +        which "compatible" property contains "jedec,spi-nor", it presents
> +        SPI is used.

Sorry, I failed to parse the last subsentence.

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
> +                       compatible = "jedec,spi-nor";
> +                       reg = <0>;
> +                       spi-max-frequency = <40000000>;
> +                       spi-tx-bus-width = <1>;
> +                       spi-rx-bus-width = <1>;

Shouldn't those <1> be <4>, as this is QSPI?

> +               };
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
