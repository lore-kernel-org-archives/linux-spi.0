From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Fri, 18 Jan 2019 11:23:40 +0300
Message-ID: <e3843856-fe6b-dfea-ffbe-07398aabc4cf@cogentembedded.com>
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
 <8367577a-9717-92e3-cbc8-8dee52876bcb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Marek Vasut <marek.vasut@gmail.com>,
        Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8367577a-9717-92e3-cbc8-8dee52876bcb@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 18.01.2019 9:16, Marek Vasut wrote:

>> Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
>>
>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> ---
>>   .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 37 ++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> new file mode 100644
>> index 0000000..9b5001e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> @@ -0,0 +1,37 @@
>> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>> +----------------------------------------------------------
>> +
>> +Required properties:
>> +- compatible: should be "renesas,rcar-gen3-rpc"
>> +- #address-cells: should be 1
>> +- #size-cells: should be 0
>> +- reg: should contain three register areas:
>> +	first for the base address of rpc-if registers,
>> +	second for the direct mapping read mode and
>> +	third for the write buffer area.
>> +- reg-names: should contain "regs", "dirmap" and "wbuf"
>> +- clock-names: should contain "rpc"
>> +- clocks: should contain 1 entries for the module's clock
>> +
>> +Example:
>> +
>> +	rpc: rpc@ee200000 {
>> +		compatible = "renesas,rcar-gen3-rpc";
>> +		reg = <0 0xee200000 0 0x7fff>, <0 0x08000000 0 0x4000000>,
> 
> 0x7fff should be 0x8000 , right ?

    Even 0x200.

> 
>> +		      <0 0xee208000 0 0x100>;
> 
> Isn't the write buffer part of the RPC-IF register set ?

    No, if you look into the manual.

MBR, Sergei
