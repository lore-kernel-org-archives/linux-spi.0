From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Fri, 18 Jan 2019 11:39:57 +0100
Message-ID: <CAMuHMdXeYubQPJrDE_hUf-5hAVA7rMrDynbg3rCW3TpXEpVu+Q@mail.gmail.com>
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
 <CAMuHMdXiW=4qgZGFqvwGHL7V3ZHfQ2EJ2B96dG14B-jh5+XqOw@mail.gmail.com> <OFBD5366C8.433ADACB-ON48258386.00336667-48258386.00340E20@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFBD5366C8.433ADACB-ON48258386.00336667-48258386.00340E20@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Fri, Jan 18, 2019 at 10:28 AM <masonccyang@mxic.com.tw> wrote:
> I modified this dts to:
>
> Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>  --------------------------------------------------------------------
>
>  Required properties:
>  - compatible: should be an SoC-specific compatible value, followed by
>                "renesas,rcar-gen3-rpc" as a fallback.

Please list the supported SoC-specific compatible values, so
scripts/checkpatch.pl
can validate patches adding RPC device nodes to DTS files.

>  - #address-cells: should be 1
>  - #size-cells: should be 0
>  - reg: should contain three register areas:
>          first for the base address of rpc-if registers,
>          second for the direct mapping read mode and
>          third for the write buffer area.
>  - reg-names: should contain "regs", "dirmap" and "wbuf"
>  - clock-names: should contain "rpc"
>  - clocks: should contain 1 entries for the module's clock

Please revert the order of clocks and clock-names, cfr. reg and reg-names.

>  Example:
>
>          rpc: rpc@ee200000 {
>                  compatible = "renesas,r8a7795-rpc", "renesas,rcar-gen3-rpc";
>                  reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
>                        <0 0xee208000 0 0x100>;
>                  reg-names = "regs", "dirmap", "wbuf";
>                  clocks = <&cpg CPG_MOD 917>;
>                  power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
>                  resets = <&cpg 917>;
>                  clock-names = "rpc";

Please move clock-names just below clocks.

>                  #address-cells = <1>;
>                  #size-cells = <0>;
>
>                  flash@0 {
>                          compatible = "jedec,spi-nor";
>                          reg = <0>;
>                          spi-max-frequency = <40000000>;
>                          spi-tx-bus-width = <1>;
>                          spi-rx-bus-width = <1>;
>                  };
>          };
>
>
> If it is ok and I will submit it in [PATCH v7 2/2].

Looks good, with the above changes made.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
