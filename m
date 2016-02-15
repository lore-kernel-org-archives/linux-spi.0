From: Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] SPI/ACPI: DesignWare: Add ACPI support for Designware
 SPI driver
Date: Mon, 15 Feb 2016 16:27:51 +0800
Message-ID: <56C18C07.2030209@huawei.com>
References: <1454656280-130658-1-git-send-email-qiujiang@huawei.com>
 <20160205110900.GA12311@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	<charles.chenxin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, qiujiang <qiujiang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160205110900.GA12311-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2016/2/5 19:09, Mark Brown wrote:
> On Fri, Feb 05, 2016 at 03:11:20PM +0800, qiujiang wrote:
>
>> This patch added ACPI support for DesignWare SPI mmio driver. It
>> was based the corresponding DT driver and compatible for this two
>> way. This patch has been tested on Hisilicon D02 board. It relies
>> on the GPIO patchset.
> Intel are heavy users of this driver on their systems which also use
> ACPI.  Have you discussed this binding with them?  I've copied Andy and
> Jarkko who've worked on the driver recently.

There is no ACPI code in this driver yet, seems "PRP0001" is used to reuse
this driver directly.

[...]
>
>> +static const struct acpi_device_id dw_spi_mmio_acpi_match[] = {
>> +		{"HISI0171", 0},
>> +		{ }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, dw_spi_mmio_acpi_match);
> I really do wish ACPI had some more sensible system for allocating
> device IDs so the tables were a little more legible. :(

Hmm, I agree. but for now, every OEM can request ACPI or PNP ID with specific
prefixes, and they can manage it by themselves, that would flexible for OEM verdors
to develop firmware and driver.

For this driver in particular, if DesignWare provides the ACPI or PNP ID, that would
be great for all OEMs can reuse it.

Thanks
Hanjun


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
