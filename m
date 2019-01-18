From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Fri, 18 Jan 2019 08:46:04 +0100
Message-ID: <16bdae9c-bdef-b8eb-73e9-85bc8e724f20@gmail.com>
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
 <8367577a-9717-92e3-cbc8-8dee52876bcb@gmail.com>
 <OF914E6438.79205FE6-ON48258386.002973E8-48258386.002A41F0@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        zhengxunli@mxic.com.tw, Chris Brandt <chris.brandt@renesas.com>
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF914E6438.79205FE6-ON48258386.002973E8-48258386.002A41F0@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 1/18/19 8:41 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> "Marek Vasut" <marek.vasut@gmail.com>
>> 2019/01/18 下午 03:10
>>
>> > +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>> > +----------------------------------------------------------
>> > +
>> > +Required properties:
>> > +- compatible: should be "renesas,rcar-gen3-rpc"
>> > +- #address-cells: should be 1
>> > +- #size-cells: should be 0
>> > +- reg: should contain three register areas:
>> > +   first for the base address of rpc-if registers,
>> > +   second for the direct mapping read mode and
>> > +   third for the write buffer area.
>> > +- reg-names: should contain "regs", "dirmap" and "wbuf"
>> > +- clock-names: should contain "rpc"
>> > +- clocks: should contain 1 entries for the module's clock
>> > +
>> > +Example:
>> > +
>> > +   rpc: rpc@ee200000 {
>> > +      compatible = "renesas,rcar-gen3-rpc";
>> > +      reg = <0 0xee200000 0 0x7fff>, <0 0x08000000 0 0x4000000>,
>>
>> 0x7fff should be 0x8000 , right ?
> 
> RPC write buffer starts at 0xee208000 w/ 256 bytes size.

The size of the RPC-IF block is 0x8000 though, is it not ?

>> > +            <0 0xee208000 0 0x100>;
>>
>> Isn't the write buffer part of the RPC-IF register set ?
> 
> yep, but by Sergei and Geert's comments, we use a separate reg entry
> for this write buffer.
> ---- copy the replied email from Geert ---------------------------------
>> Maybe Geert or Marek could comment on it, thanks.
> 
> Given the writer buffer is separate from the other registers (it's in
> a different
> 4 KiB page, and thus may be at a different offset on future SoCs), and not
> present on RZ/A1, I think it's a good idea to use a separate reg entry
> for it.
> -----------------------------------------------------------------------

+CC Chris, the RZ/A1 has no write buffer for the RPC ?

-- 
Best regards,
Marek Vasut
