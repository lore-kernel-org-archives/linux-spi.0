From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v13 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Mon, 3 Jun 2019 17:55:25 +0300
Message-ID: <02addf64-9f6e-ccc1-2f94-8983456e3ebc@cogentembedded.com>
References: <1558423174-10748-1-git-send-email-masonccyang@mxic.com.tw>
 <1558423174-10748-4-git-send-email-masonccyang@mxic.com.tw>
 <0e2994d6-6efc-9f36-f681-609199f20b9f@cogentembedded.com>
 <20190603130428.GX4797@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, juliensu@mxic.com.tw,
        Simon Horman <horms@verge.net.au>, miquel.raynal@bootlin.com
To: Lee Jones <lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190603130428.GX4797@dell>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 06/03/2019 04:04 PM, Lee Jones wrote:

>>> Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
>>>
>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>>> ---
>>>  .../devicetree/bindings/mfd/renesas-rpc-if.txt     | 65 ++++++++++++++++++++++
>>>  1 file changed, 65 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt b/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
>>> new file mode 100644
>>> index 0000000..20ec85b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
>>> @@ -0,0 +1,65 @@
>>> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>>> +---------------------------------------------------------
>>> +
>>> +RPC-IF supports both SPI NOR and HyperFlash (CFI-compliant flash)
>>> +
>>> +Required properties:
>>> +- compatible: should be an SoC-specific compatible value, followed by
>>> +		"renesas,rcar-gen3-rpc" as a fallback.
>>> +		supported SoC-specific values are:
>>> +		"renesas,r8a77995-rpc"	(R-Car D3)
>>> +- reg: should contain three register areas:
>>> +	first for RPC-IF registers,
>>> +	second for the direct mapping read mode and
>>> +	third for the write buffer area.
>>> +- reg-names: should contain "regs", "dirmap" and "wbuf"
>>> +- clocks: should contain 1 entries for the module's clock
>>> +- clock-names: should contain "rpc"
>>> +- power-domains: should contain system-controller(sysc) for power-domain-cell
>>> +- resets: should contain clock pulse generator(cpg) for reset-cell,
>>> +	  power-domain-cell and clock-cell
>>
>>    That's just some nonsense, sorry...
>>    I suggest that you stop reposting your patches as I'm going to post
>> my version of this patchset RSN (based on your patches, of course) and I'm
>> going to take care of fixing this file as well.
> 
> Why is this necessary?

   Because Mason doesn't want to develop the HyperFlash driver (or even move his code
in preparation to this driver being developed). I must develop this driver, and I'd
like to avoid the extra churn of mving the code between the MFD and SPI drivers.

> Why not just provide some constructive feedback instead?

   I was providing the feedback during these 13 revisions... unfortunately, it wasn't
fully considered.

>>> +- #address-cells: should be 1
>>> +- #size-cells: should be 0
>> [...]

MBR, Sergei
