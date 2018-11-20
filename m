From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] dt-binding: spi: Document Renesas R-Car RPC
 controller bindings
Date: Tue, 20 Nov 2018 09:07:44 +0100
Message-ID: <CAMuHMdXhx2iudXaPQto-c1kYAYdKc1T9vMr5yYNqONJwoNmRCw@mail.gmail.com>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw> <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, Trent Piepho <tpiepho@impinj.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        juliensu@mxic.com.tw, Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Mon, Nov 19, 2018 at 11:02 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Document the bindings used by the Renesas R-Car D3 RPC controller.
>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

Thanks for your patch

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,33 @@
> +Renesas R-Car D3 RPC controller Device Tree Bindings

R-Car Gen3

> +----------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "renesas,rpc-r8a77995"

Please use "renesas,r8a77995-rpc".

> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area
> +- reg-names: should contain "rpc_regs" and "dirmap"
> +- interrupts: interrupt line connected to the RPC SPI controller
> +- clock-names: should contain "clk_rpc"
> +- clocks: should contain 1 entries for the CPG Module 917 clocks

... for the module's clock

> +
> +Example:
> +
> +       rpc: spi@ee200000 {
> +               compatible = "renesas,rpc-r8a77995";
> +               reg = <0 0xee200000 0 0x8100>, <0 0x08000000 0 0x4000000>;
> +               reg-names = "rpc_regs", "dirmap";
> +               clocks = <&cpg CPG_MOD 917>;
> +               clock-names = "clk_rpc";
> +               #address-cells = <1>;
> +               #size-cells = <0>;

power-domains?
resets?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
