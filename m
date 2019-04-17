From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v10 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD controller
 driver
Date: Wed, 17 Apr 2019 23:26:51 +0300
Message-ID: <76e9c2a8-1537-04ad-17e0-ebd9fa9b7b91@cogentembedded.com>
References: <1555313834-15107-1-git-send-email-masonccyang@mxic.com.tw>
 <1555313834-15107-2-git-send-email-masonccyang@mxic.com.tw>
 <935046cc-e2e5-b9b8-0c94-1be5ae604276@cogentembedded.com>
 <OF8A9D093C.B3035121-ON482583DE.00065F23-482583DE.00074AC0@mxic.com.tw>
 <770002ab-7e08-b695-b5a5-fce772b600a5@cogentembedded.com>
 <OF2BD84B79.FBC5E822-ON482583DF.0020009F-482583DF.0022E315@mxic.com.tw>
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
In-Reply-To: <OF2BD84B79.FBC5E822-ON482583DF.0020009F-482583DF.0022E315@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/17/2019 09:21 AM, masonccyang@mxic.com.tw wrote:

>> >> Re: [PATCH v10 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD
>> controller driver
>> >>
>> >> The patch name is somewhat misleading -- there's no "MFD controller".
>> >
>> > Can't get your point ?
>> >
>> > RPC-IF support SPI and HF, it's a MFD controller and
>> > that's why I patch it to MFD as Marek's comments.
>>
>>    I'd like the "controller" word dropped, as MFD stands for multi-
>> function device
>> anyway. "Controller" seems to be superfluous here...
> 
> okay, will rename to:
> 
> [PATCH v11 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD driver

   Thanx!

>> >> On 04/15/2019 10:37 AM, Mason Yang wrote:
>> >>
>> >> > Add a driver for Renesas R-Car Gen3 RPC-IF MFD controller.
>> >> >
>> >> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> >> [...]
>> >> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> >> > index 26ad646..7914349 100644
>> >> > --- a/drivers/mfd/Kconfig
>> >> > +++ b/drivers/mfd/Kconfig
>> >> > @@ -978,6 +978,15 @@ config MFD_RDC321X
>> >> >       southbridge which provides access to GPIOs and Watchdog using the
>> >> >       southbridge PCI device configuration space.
>> >> >  
>> >> > +config MFD_RENESAS_RPC
>> >> > +   tristate "Renesas R-Car Gen3 RPC-IF MFD driver"
>> >> > +   select MFD_CORE
>> >> > +   depends on ARCH_RENESAS
>> >> > +   help
>> >> > +     This supports for Renesas R-Car Gen3 RPC-IF multifunction device
>> >>
>> >>    "For" node needed here.
>> >
>> > ?
>>
>>    Sorry, that was a typo: s/node/not/.
> 
> Oops, still don't know what do you mean to ?
> 
> Will change to:
>          help
>            This supports for Renesas R-Car Gen3 RPC-IF multifunction device
>            which provides either SPI host or HyperFlash.
>            You have to select individual components under the corresponding menu.
> 
> is it ok ?

   Should be "This supports Renesas..."

[...]

MBR, Sergei
