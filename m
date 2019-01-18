From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Fri, 18 Jan 2019 09:08:38 +0100
Message-ID: <dc043bfe-7a56-9810-1e5e-802f8b6beee2@gmail.com>
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
 <CAMuHMdXiW=4qgZGFqvwGHL7V3ZHfQ2EJ2B96dG14B-jh5+XqOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXiW=4qgZGFqvwGHL7V3ZHfQ2EJ2B96dG14B-jh5+XqOw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 1/18/19 9:03 AM, Geert Uytterhoeven wrote:
> Hi Mason,
> 
> On Fri, Jan 18, 2019 at 6:55 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
>> Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
>>
>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> 
> Thanks for the update!
> 
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> @@ -0,0 +1,37 @@
>> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>> +----------------------------------------------------------
>> +
>> +Required properties:
>> +- compatible: should be
> 
>     compatible: should be an SoC-specific compatible value, followed by
>     "renesas,rcar-gen3-rpc" as a fallback.
> 
>     Examples of the latter are:
>       - "renesas,r8a7795-rpc" (R-Car H3).
> 
> This makes it future-proof, in case the RPC on a specific SoC version needs
> to be handled specially. We already know that is the case for R-Car V3M.
> 
>> +- #address-cells: should be 1
>> +- #size-cells: should be 0
>> +- reg: should contain three register areas:
>> +       first for the base address of rpc-if registers,
>> +       second for the direct mapping read mode and
>> +       third for the write buffer area.
>> +- reg-names: should contain "regs", "dirmap" and "wbuf"
>> +- clock-names: should contain "rpc"
>> +- clocks: should contain 1 entries for the module's clock
>> +
>> +Example:
>> +
>> +       rpc: rpc@ee200000 {
>> +               compatible = "renesas,rcar-gen3-rpc";
> 
> compatible = "renesas,r8a7795-rpc," renesas,rcar-gen3-rpc";

Without the extra comma after r8a7795-rpc, of course ;-)

-- 
Best regards,
Marek Vasut
