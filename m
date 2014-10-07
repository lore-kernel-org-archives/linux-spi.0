From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: dw: Initialize of_node to discover DT node children
Date: Tue, 7 Oct 2014 15:59:26 -0500
Message-ID: <5434542E.6020405@opensource.altera.com>
References: <1412711297-31857-1-git-send-email-tthayer@opensource.altera.com> <1412711297-31857-2-git-send-email-tthayer@opensource.altera.com> <20141007204026.GK4609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <jkosina-AlSwsSmVLrQ@public.gmane.org>, <pawel.moll-5wv7dgnIgG8@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<mark.rutland-5wv7dgnIgG8@public.gmane.org>, <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	<galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, <dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>, <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141007204026.GK4609-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


On 10/07/2014 03:40 PM, Mark Brown wrote:
> On Tue, Oct 07, 2014 at 02:48:16PM -0500, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:
>> From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
>>
>> 1. The of_node element must be initialized to enable discovery of node
>> children. The discovery takes place in the of_register_spi_devices() function.
>> 2. Grabbing the bus-num from the device tree.
>> 3. Update the SOCFPGA configuration.
> No, each of these should be in a separate patch - it's especially bad to
> be updating the defconfig in the same patch as the driver, these changes
> should be totally unrelated.
OK. I will split these and remove the defconfig.

Dinh pointed the defconfig issue out to me as well.

Thanks for reviewing,

Thor
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
