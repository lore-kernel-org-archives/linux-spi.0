From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: spi: Document Renesas R-Car RPC-IF
 controller bindings
Date: Wed, 9 Jan 2019 08:51:53 +0100
Message-ID: <CAMuHMdW0vBrQm1_moRyTSa+1j5Nob83UNPu3phmrhZNECk7t2w@mail.gmail.com>
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw> <1546921020-20436-3-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546921020-20436-3-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Tue, Jan 8, 2019 at 5:17 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,37 @@
> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> +----------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "renesas,r8a77995-rpc"

Would it make sense to have a family-specific fallback "renesas,rcar-gen3-rpc",
bseides the SoC-specific compatible value?
</masonccyang@mxic.com.tw></masonccyang@mxic.com.tw>

> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area
> +- reg-names: should contain "regs" and "dirmap"
> +- clock-names: should contain "rpc"
> +- clocks: should contain 1 entries for the module's clock

Doesn't the driver have a need to access the RPCD2 clock?
At least on R-Car V3M, it needs to program the Divider Clock Register
(DIVREG).

> +- renesas,rpc-mode: should contain "spi" for rpc spi mode or
> +                                  "hyperflash" for rpc hyperflash mode.

Can't this be derived from the flash subnode?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
