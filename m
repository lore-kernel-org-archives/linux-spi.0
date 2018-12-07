From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v3 2/2] dt-binding: spi: Document Renesas R-Car Gen3 RPC
 controller bindings
Date: Fri, 7 Dec 2018 17:31:14 +0100
Message-ID: <8564903b-b162-a451-296e-be3ec199e248@gmail.com>
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
 <1544181199-3373-3-git-send-email-masonccyang@mxic.com.tw>
 <b89fb13a-4fe2-d3ca-7e12-7ac6b11455f6@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b89fb13a-4fe2-d3ca-7e12-7ac6b11455f6@cogentembedded.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/07/2018 05:03 PM, Sergei Shtylyov wrote:
> Hello!
> 
> On 12/07/2018 02:13 PM, Mason Yang wrote:
> 
>> Document the bindings used by the Renesas R-Car Gen3 RPC controller.
>>
>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> ---
>>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 38 ++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> new file mode 100644
>> index 0000000..a191f70
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> @@ -0,0 +1,38 @@
>> +Renesas R-Car Gen3 RPC controller Device Tree Bindings
>> +------------------------------------------------------
>> +
>> +Required properties:
>> +- compatible: should be "renesas,r8a77995-rpc"
>> +- #address-cells: should be 1
>> +- #size-cells: should be 0
>> +- reg: should contain 2 entries, one for the registers and one for the direct
>> +       mapping area
>> +- reg-names: should contain "rpc_regs" and "dirmap"
> 
>    Please drop this "rpc_" thing, I think "regs" should be enough.
> 
>> +- interrupts: interrupt line connected to the RPC controller
>> +- clock-names: should contain "clk_rpc"
> 
>    Please drop this "clk_" thing. BTW, what's with the RPCD2 clock?
> 
>> +- clocks: should contain 1 entries for the module's clock
>> +- rpc-mode: should contain "rpc-spi-flash" for rpc spi mode or
>> +			   "rpc-hyperflash" for rpc hyerflash mode.
> 
>    I think the prop should be called "renesas,rpc-mode" and the values should be
> just "spi" and "hyperflash". 

Like I said before, you can determine the mode from the subnode attached
to the controller, we don't need special prop for that.

-- 
Best regards,
Marek Vasut
