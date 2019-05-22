From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
Date: Wed, 22 May 2019 19:32:05 +0300
Message-ID: <5e718d9f-3aeb-c2ef-0723-400497b2b98f@cogentembedded.com>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus>
 <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
 <20190507125730.GD29524@dell>
 <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw>
 <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com> <20190508061119.GB7627@dell>
 <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw>
 <a05cff8f-7df2-1938-c0e7-f9366bece607@cogentembedded.com>
 <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw>
 <CAMuHMdUP8KU3Dbv6cwOvrY0hWOcm1xqVcsi20+GvazYMDLGGZg@mail.gmail.com>
 <OFD932ABFC.E3FFCEB8-ON482583F9.003412B1-482583F9.0034D5CA@mxic.com.tw>
 <b51d1cb7-b3b5-208f-ab4c-145ecb57805d@cogentembedded.com> <OFAD9AA573.86373
 <44bc8f0a-cbdc-db4a-9a46-b8bae5cc37a2@cogentembedded.com>
 <OF5AF00898.3CE87C98-ON48258400.00259B16-48258400.0028A4F5@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, zhengxunli@mxic.com.tw,
        Miquel Raynal <miquel.raynal@bootlin.com>
To: masonccyang@mxic.com.tw, Geert Uytterhoeven <geert@linux-m68k.org>,
        Lee Jones <lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF5AF00898.3CE87C98-ON48258400.00259B16-48258400.0028A4F5@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 05/20/2019 10:23 AM, masonccyang@mxic.com.tw wrote:

>>>>> -------------------------------------------------------------->
>>>>>
>>>>> Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>>>>> ---------------------------------------------------------
>>>>>
>>>>>   RPC-IF supports both SPI NOR and HyperFlash (CFI-compliant flash)
>>>>>
>>>>>   Required properties:
>>>>>   - compatible: should be an SoC-specific compatible value, followed 
> 
>>> by
>>>>>                   "renesas,rcar-gen3-rpc" as a fallback.
>>>>>                   supported SoC-specific values are:
>>>>>                   "renesas,r8a77995-rpc"  (R-Car D3)
>>>>>   - reg: should contain three register areas:
>>>>>           first for the base address of RPC-IF registers,
>>>>
>>>>    I'd drop "the base address" here.
>>>
>>> okay.
>>>
>>>>>           second for the direct mapping read mode and
>>>>>           third for the write buffer area.
>>>>>   - reg-names: should contain "regs", "dirmap" and "wbuf"
>>>>>   - clocks: should contain 1 entries for the module's clock
>>>>>   - clock-names: should contain "rpc"
>>>>
>>>>    I suspect we'd need the RPC/RPCD2 clocks mentioned as well (not 
> sure 
>>> yet)...
>>>
>>> Need it ?
>>
>>    You seem to call clk_get_rate() on the module clock, I doubt that's
>> correct topologically...

   clk_set_rate(), sorry.

> 
> I think it's correct but just like Geert mentioned that there is no any 
> patch
> in drivers/clk/renesas/r8a77995-cpg-mssr.c adding RPC-related clocks.
> 
> 
> I patched dt-bindings/clock/r8a77995-cpg-mssr.h for some simple testing
> 
> -#define R8A77995_CLK_RPC               29
> -#define R8A77995_CLK_RPCD2             30
> +#define R8A77995_CLK_RPC               31
> +#define R8A77995_CLK_RPCD2             32

   Hm, what does this do?

> by clk_prepare_enable() & clk_disable_unprepare() with CPG_MOD 917 
> on D3 draak board, it is working fine.

>>>>>   - SPI mode:git
>>>>>
>>>>>           rpc: rpc-if@ee200000 {
>>>>
>>>>    The node names should be generic, based on the device class. And in 
>>>> this
>>>> case I'd like to use "spi@ee200000" as otherwise dtc keeps bitching like 
>>>> below:
>>>
>>> okay, patch to
>>>
>>> rpc_if: spi@<...>
>>
>>    That, or just keep the node label.
> 
> okay.
> 
>>>>>   - HF mode:
>>>>>           rpc: rpc-if@ee200000 {
>>>>
>>>>    Again, spi@<...>.
>>>
>>> what about rpc_if: hf@<...>
>>
>>    Can't change the node name, as it's declared in the .dtsi files, not *.dts
>> ones. And "spi" works for the HF case as well -- no complaints from dtc. 
> :-)

   Maybe it's possible using the "name" prop, don't know...

> okay,
>  
> Patch DTS to
> ===============================================================> 
> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> +---------------------------------------------------------
> +
> +RPC-IF supports both SPI NOR and HyperFlash (CFI-compliant flash)
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +                                "renesas,rcar-gen3-rpc" as a fallback.
> +                                supported SoC-specific values are:
> +                                "renesas,r8a77995-rpc"          (R-Car 
> D3)
> +- reg: should contain three register areas:
> +                first for RPC-IF registers,
> +                second for the direct mapping read mode and
> +                third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clocks: should contain 1 entries for the module's clock

   1 entry (clock node phandle and specifier).

> +- clock-names: should contain "rpc"
> +- power-domains: should contain system-controller(sysc) for 
> power-domain-cell

   What's "power-domain-cell"? I know "#power-domain-cells". I'd like this
to be "the power domain node's phandle and specifier".

> +- resets: should contain clock pulse generator(cpg) for reset-cell,

   It's "#reset-cells" again. I'd like this to be "the reset node's phandle
and specifier".

> +                  power-domain-cell and clock-cell

   Why mntion clock-cell at all here?

> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +
> +Example:
> +- SPI mode:
> +
> +                rpc: spi@ee200000 {
> +                                compatible = "renesas,r8a77995-rpc", 
> "renesas,rcar-gen3-rpc";
> +                                reg = <0 0xee200000 0 0x200>, <0 
> 0x08000000 0 0x4000000>,
> +                                      <0 0xee208000 0 0x100>;
> +                                reg-names = "regs", "dirmap", "wbuf";
> +                                clocks = <&cpg CPG_MOD 917>;
> +                                clock-names = "rpc";
> +                                power-domains = <&sysc 
> R8A77995_PD_ALWAYS_ON>;
> +                                resets = <&cpg 917>;
> +                                #address-cells = <1>;
> +                                #size-cells = <0>;
> +
> +                                flash@0 {
> +                                                compatible = 
> "jedec,spi-nor";
> +                                                reg = <0>;
> +                                                spi-max-frequency = 
> <40000000>;
> +                                                spi-tx-bus-width = <1>;
> +                                                spi-rx-bus-width = <1>;
> +                                };
> +                };
> +
> +- HF mode:

   HyperFlash, please.

> +                rpc: spi@ee200000 {
> +                                compatible = "renesas,r8a77995-rpc", 
> "renesas,rcar-gen3-rpc";
> +                                reg = <0 0xee200000 0 0x200>, <0 
> 0x08000000 0 0x4000000>,
> +                                      <0 0xee208000 0 0x100>;
> +                                reg-names = "regs", "dirmap", "wbuf";
> +                                clocks = <&cpg CPG_MOD 917>;
> +                                clock-names = "rpc";
> +                                power-domains = <&sysc 
> R8A77995_PD_ALWAYS_ON>;
> +                                resets = <&cpg 917>;
> +                                #address-cells = <1>;
> +                                #size-cells = <0>;

   And I don't think duplicating the same device node is a good idea...

> +                                flash@0 {
> +                                                compatible = 
> "cypress,hyperflash", "cfi-flash";
> +                                                reg = <0>;
> +                                };
> +                };
> ===============================================================<
> 
> thanks & best regards,
> Mason
[...]

MBR, Sergei
