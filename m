From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 2/2] dt-binding: spi: Document Renesas R-Car RPC
 controller bindings
Date: Tue, 20 Nov 2018 13:57:21 +0100
Message-ID: <e7fd0653-75a7-249a-462a-18a7bf4616d1@gmail.com>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
 <629a5d6f-5c13-9b24-1c21-461d09f1aa8a@gmail.com>
 <OFDD04CD59.10199EDD-ON4825834B.001E1390-4825834B.001F65DD@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, tpiepho@impinj.com,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFDD04CD59.10199EDD-ON4825834B.001E1390-4825834B.001F65DD@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 11/20/2018 06:42 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,
> 
> Marek Vasut <marek.vasut@gmail.com> 已在 2018/11/19 下午 09:49:31 上寫入:
> 
>> Marek Vasut <marek.vasut@gmail.com>
>> 2018/11/19 下午 09:49
>>
>> To
>>
>> Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
>> tpiepho@impinj.com, linux-kernel@vger.kernel.org, linux-
>> spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman
>> <horms@verge.net.au>,
>>
>> cc
>>
>> boris.brezillon@bootlin.com, juliensu@mxic.com.tw, Geert
>> Uytterhoeven <geert+renesas@glider.be>, zhengxunli@mxic.com.tw
>>
>> Subject
>>
>> Re: [PATCH 2/2] dt-binding: spi: Document Renesas R-Car RPC
>> controller bindings
>>
>> On 11/19/2018 11:01 AM, Mason Yang wrote:
>> > Document the bindings used by the Renesas R-Car D3 RPC controller.
>> >
>> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> > ---
>> >  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 33 +++++++++
>> +++++++++++++
>> >  1 file changed, 33 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/spi/spi-
>> renesas-rpc.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-
>> rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> > new file mode 100644
>> > index 0000000..8286cc8
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> > @@ -0,0 +1,33 @@
>> > +Renesas R-Car D3 RPC controller Device Tree Bindings
>> > +----------------------------------------------------
>> > +
>> > +Required properties:
>> > +- compatible: should be "renesas,rpc-r8a77995"
>> > +- #address-cells: should be 1
>> > +- #size-cells: should be 0
>> > +- reg: should contain 2 entries, one for the registers and one
>> for the direct
>> > +       mapping area
>> > +- reg-names: should contain "rpc_regs" and "dirmap"
>> > +- interrupts: interrupt line connected to the RPC SPI controller
>>
>> Do you also plan to support the RPC HF mode ? And if so, how would that
>> look in the bindings ? I'd like to avoid having to redesign the bindings
>> later to handle both the SPI and HF modes.
>>
> 
> I patched this RPC SPI/Octa driver is for mx25uw51245g and you may also
> refer to Boris's patch. [1][2][3]

Does this mean the driver is specific to one particular kind of flash ?

> [1] https://patchwork.kernel.org/cover/10638055/
> [2] https://patchwork.kernel.org/patch/10638057/
> [3] https://patchwork.kernel.org/patch/10638085/


-- 
Best regards,
Marek Vasut
