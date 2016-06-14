From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 11/13] dt: spi: sun4i: merge sun4i and
 sun6i binding doc
Date: Tue, 14 Jun 2016 06:40:01 +0200
Message-ID: <CAOMqctTtpZ-kCJNUO7NZ855444LuAnsJewjK=nEOaoy0NOT3OQ@mail.gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com> <cccbd6c3f0a194ec6eecd6627c4874da7b936f37.1465490774.git.hramrach@gmail.com>
 <CAGRGNgWXG_d2ScrgehbSHguF-V0cXy-Vr1=zLE36v5rDu6pYtQ@mail.gmail.com>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
	Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Timo Sigurdsson <public_timo.s-fWgRPtSzPNU3WX+qO2AYSQ@public.gmane.org>, Jonathan Liu <net147-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Gerhard Bertelsmann <info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org>, Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>,
	devicet
To: Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBCQMLUOX54MBBSMV725AKGQEXU64HEY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGRGNgWXG_d2ScrgehbSHguF-V0cXy-Vr1=zLE36v5rDu6pYtQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On 14 June 2016 at 01:45, Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Michal,
>
> On Tue, Jun 14, 2016 at 3:46 AM, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  .../devicetree/bindings/spi/spi-sun4i.txt          | 21 ++++++++++---------
>>  .../devicetree/bindings/spi/spi-sun6i.txt          | 24 ----------------------
>>  2 files changed, 11 insertions(+), 34 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-sun6i.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-sun4i.txt b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
>> index de827f5..329e543 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-sun4i.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
>> @@ -1,7 +1,8 @@
>> -Allwinner A10 SPI controller
>> +Allwinner A10/A31 SPI controller
>>
>>  Required properties:
>> -- compatible: Should be "allwinner,sun4-a10-spi".
>> +- compatible: Should be one of "allwinner,sun4i-a10-spi" and
>> +                               "allwinner,sun6i-a31-spi"
>>  - reg: Should contain register location and length.
>>  - interrupts: Should contain interrupt.
>>  - clocks: phandle to the clocks feeding the SPI controller. Two are
>> @@ -9,16 +10,16 @@ Required properties:
>>    - "ahb": the gated AHB parent clock
>>    - "mod": the parent module clock
>>  - clock-names: Must contain the clock names described just above
>> +- resets: (sun6i only) phandle to the reset controller asserting
>> +         this device in reset
>>
>>  Example:
>>
>> -spi1: spi@01c06000 {
>> -       compatible = "allwinner,sun4i-a10-spi";
>> -       reg = <0x01c06000 0x1000>;
>> -       interrupts = <11>;
>> -       clocks = <&ahb_gates 21>, <&spi1_clk>;
>> +spi1: spi@01c69000 {
>> +       compatible = "allwinner,sun6i-a31-spi";
>> +       reg = <0x01c69000 0x1000>;
>> +       interrupts = <0 66 4>;
>> +       clocks = <&ahb1_gates 21>, <&spi1_clk>;
>>         clock-names = "ahb", "mod";
>> -       status = "disabled";
>> -       #address-cells = <1>;
>> -       #size-cells = <0>;
>> +       resets = <&ahb1_rst 21>;
>
> Why not have an example of each type?

How many binding docs have examples of all types?

There are actual DTs using these so you can look at those as well.

This driver covers 3 types of bindings which look different in the DT:

sun4i IP with some Chinese interrupt controller, sun4i IP with GIC,
and sun6i IP with GIC.

Thanks

Michal
