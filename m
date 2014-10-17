From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: [PATCHv3] arm: dts: socfpga: Add SPI nodes to SOCFPGA DT.
Date: Fri, 17 Oct 2014 10:05:31 -0500
Message-ID: <5441303B.4070905@opensource.altera.com>
References: <1413497251-21954-1-git-send-email-tthayer@opensource.altera.com> <1413497251-21954-2-git-send-email-tthayer@opensource.altera.com> <20141017065233.GA10262@pengutronix.de> <54411FC9.3050109@opensource.altera.com> <20141017142713.GV1820@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	<dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>,
	<axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141017142713.GV1820-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On 10/17/2014 09:27 AM, Mark Brown wrote:
> On Fri, Oct 17, 2014 at 08:55:21AM -0500, Thor Thayer wrote:
>
>> I didn't see it documented in the dw-spi bindings but I did see a reference
>> to .bus_num in the static structure (spi_board_info) shown in
>> spi-summary.txt. If the bus-num isn't defined or used, the bus ends up as
>> 32766 (0x7FE). However, the main point is that this isn't used in the code
>> so I should remove it.
> Defining the bus number is important for use in board files to allow
> devices to be referenced but should never have any practical effect for
> DT systems.
Thank you for the explanation, Mark. I'll make the change and resubmit.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
