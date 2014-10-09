From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: [PATCHv2] arm: dts: socfpga: Add SPI nodes to SOCFPGA DT.
Date: Thu, 9 Oct 2014 14:19:09 -0500
Message-ID: <5436DFAD.2010902@opensource.altera.com>
References: <1412796428-3255-1-git-send-email-tthayer@opensource.altera.com> <20141008200515.GK4609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>,
	<axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141008200515.GK4609-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On 10/08/2014 03:05 PM, Mark Brown wrote:
> On Wed, Oct 08, 2014 at 02:27:08PM -0500, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:
>
>> +			spidev@0 {
>> +				compatible = "spidev";
>> +				reg = <0>;	/* chip select */
>> +				spi-max-frequency = <100000000>;
>> +			};
> No, if you're putting spidev into the DT that's broken - describe the
> hardware, not the software you're using to control it.
Hi Mark,

There are quite a few instances of the spidev as a child of a spi node 
in the arch/arm/dts directory
- imx6qdl-tx6.dtsi
- imx53-tx53.dtsi
- tegra30-apalis-eval.dts
- spear1340-evb.dts

I believe the reason these are added to the device tree is that they are 
automatically probed.

If there is a different or better way to handle spidev, I'll be happy to 
do it. This seemed to be the cleanest way and had precedent.

Thanks for reviewing this and I appreciate your input.

Thor
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
