From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: spi: Document Renesas R-Car RPC-IF
 controller bindings
Date: Thu, 10 Jan 2019 14:43:46 +0100
Message-ID: <85882d18-9b05-5cc9-105d-093ae7cf0041@gmail.com>
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
 <1546921020-20436-3-git-send-email-masonccyang@mxic.com.tw>
 <05c8e4ac-a9c8-7c24-289f-ce7a089dbc1e@gmail.com>
 <OFD1D4749F.04B5A6A1-ON4825837E.00331D68-4825837E.00344CA0@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFD1D4749F.04B5A6A1-ON4825837E.00331D68-4825837E.00344CA0@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 1/10/19 10:31 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> "Marek Vasut" <marek.vasut@gmail.com>
>> 2019/01/08 下午 08:06
>> > diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-
>> rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> > new file mode 100644
>> > index 0000000..5f96532
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> > @@ -0,0 +1,37 @@
>> > +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>> > +----------------------------------------------------------
>> > +
>> > +Required properties:
>> > +- compatible: should be "renesas,r8a77995-rpc"
>> > +- #address-cells: should be 1
>> > +- #size-cells: should be 0
>> > +- reg: should contain 2 entries, one for the registers and one
>> for the direct
>> > +       mapping area
>> > +- reg-names: should contain "regs" and "dirmap"
>> > +- clock-names: should contain "rpc"
>> > +- clocks: should contain 1 entries for the module's clock
>> > +- renesas,rpc-mode: should contain "spi" for rpc spi mode or
>> > +                  "hyperflash" for rpc hyperflash mode.
>>
>> Why do we need this property ? I believe it is possible to detect the
>> configuration based on the type of child of the RPC node. If the driver
>> was properly designed, it could well behave as either CFI NOR driver or
>> SPI flash driver and all would be good, but it seems this is written
>> with it being SPI flash driver only and once the HF mode would need to
>> be added, it'd mean a tremendous undertaking to rework the entire driver.
>>
> 
> Except to check if there are any SPI NOR child nodes by "jedec,spi-nor"
> compatible, is any other way better ?
> 
> any suggestion is welcome.

That's the one. A MFD RPC driver can sanitize it's child nodes, verify
that the config is valid and configure the RPC accordingly. All of the
devices that can be connected to the RPC are either valid jedec-nor or
CFI NOR (HF), so this should work fine.

-- 
Best regards,
Marek Vasut
