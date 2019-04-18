From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v10 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Thu, 18 Apr 2019 19:55:59 +0300
Message-ID: <9bc4847f-8e7e-3627-5394-6f2b5c5972bc@cogentembedded.com>
References: <1555313834-15107-1-git-send-email-masonccyang@mxic.com.tw>
 <1555313834-15107-4-git-send-email-masonccyang@mxic.com.tw>
 <907f2e87-1cb4-fa37-5406-82bf2bf71188@cogentembedded.com>
 <OF2F61A6E6.AA7717A3-ON482583DE.0005C1EE-482583DE.00061474@mxic.com.tw>
 <8720224d-76f4-c620-9e3f-91605d6fa1e3@cogentembedded.com>
 <OFCBCE0527.706EB4F2-ON482583E0.00200707-482583E0.00208EAD@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFCBCE0527.706EB4F2-ON482583E0.00200707-482583E0.00208EAD@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 04/18/2019 08:55 AM, masonccyang@mxic.com.tw wrote:

>> >  > > Document the bindings used by the Renesas R-Car Gen3 RPC-IF
>> MFD controller.
>> >  > >
>> >  > > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> >  > > ---
>> >  > >  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt  | 37 +++++++++
>> >  > +++++++++++++
>> >  > >  1 file changed, 37 insertions(+)
>> >  > >  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-
>> >  > renesas-rpc.txt
>> >  > >
>> >  > > diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-
>> >  > rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>> >  > > new file mode 100644
>> >  > > index 0000000..bfb3d29
>> >  > > --- /dev/null
>> >  > > +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>> >  > > @@ -0,0 +1,37 @@
>> >  > > +Renesas R-Car Gen3 RPC-IF MFD controller Device Tree Bindings
>> >  > > +-------------------------------------------------------------
>> >  > > +
>> >  > > +Required properties:
>> >  > > +- compatible: should be an SoC-specific compatible value, followed by
>> >  > > +      "renesas,rcar-gen3-rpc" as a fallback.
>> >  > > +      supported SoC-specific values are:
>> >  > > +      "renesas,r8a77995-rpc" (R-Car D3)
>> >  > > +- reg: should contain 2 entries, one for the base address of rpc-
>> >  > if registers,
>> >  > > +   and one for the direct mapping area
>> >  > > +- reg-names: should contain "regs", and "dirmap"
>> >  >
>> >  >    The device tree describes the hardware, not the driver. Why
>> did you remove
>> >  > the "wbuf" area?
>> >
>> > I don't think we should describe the hardware that driver did not
>> implement it
>> > because there are still many RPC registers we don't use them.
>>
>>     I have to repeat: we describe the hardware, not the driver capabilities.
> 
> how about:
> 
> - reg: should contain three register areas:
>           first for the base address of rpc-if registers,
>           second for the direct mapping read mode and
>           third for an optional write buffer area.
>  - reg-names: should contain "regs", "dirmap" and "wbuf"(optional).
> 
> is it OK ?

   No, the write buffer area is always there, at least on the gen3 chips.
(I forgot which other Renesas SoC has RPC-IF as well).

> thanks & best regards,
> Mason

MBR, Sergei
