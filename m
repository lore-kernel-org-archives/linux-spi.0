From: Shubhrajyoti Datta <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv4 2/2] bindings: spi: Add clock entries for spi-xilinx
Date: Sat, 12 Mar 2016 21:22:15 +0530
Message-ID: <CAKfKVtEJ=7z3UwjmoiVMH_Qsm2xCQ=4EEJCcRzG75d-AC0nFQg@mail.gmail.com>
References: <1457769637-5627-1-git-send-email-shubhraj@xilinx.com>
	<1457769637-5627-2-git-send-email-shubhraj@xilinx.com>
	<20160312100518.GT3173@xsjsorenbubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160312100518.GT3173@xsjsorenbubuntu>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, Mar 12, 2016 at 3:35 PM, S=C3=B6ren Brinkmann
<soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:
> On Sat, 2016-03-12 at 13:30:37 +0530, Shubhrajyoti Datta wrote:
>> Add clock description for spi-xilinx
>>
>> Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>> ---
>> v3
>> Add a clock name
>> v4
>> Correct the name
>>  .../devicetree/bindings/spi/spi-xilinx.txt         |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.txt b/=
Documentation/devicetree/bindings/spi/spi-xilinx.txt
>> index c7b7856..07ec09a 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-xilinx.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
>> @@ -7,6 +7,9 @@ Required properties:
>>  - interrupts         : Property with a value describing the interru=
pt
>>                         number.
>>  - interrupt-parent   : Must be core interrupt controller
>> +- clocks: Input clock specifier. Refer to common clock bindings.
>> +- clock-names: tuple listing input clock names.
>> +     Required elements: "s_axi_aclk"
>
> I thought there were too clocks? If the IP has two clocks, I think bo=
th
> should be added and supported here.
>
Ok sure

>>
>>  Optional properties:
>>  - xlnx,num-ss-bits   : Number of chip selects used.
>> @@ -14,6 +17,8 @@ Optional properties:
>>  Example:
>>       axi_quad_spi@41e00000 {
>>                       compatible =3D "xlnx,xps-spi-2.00.a";
>> +                     clocks =3D <&clkc 15>;
>> +                     clock-names =3D "spi_fclk";
>
> Doesn't match the binding documented above.

missed it will update thanks.

>
>         S=C3=B6ren
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
