From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: [RFC/PATCH 0/2] spi: spi-dw: Select 16b or 32b register access
Date: Thu, 5 Mar 2015 14:41:14 -0600
Message-ID: <54F8BF6A.70305@opensource.altera.com>
References: <1425501075-17081-1-git-send-email-tthayer@opensource.altera.com>	 <1425501868.14897.178.camel@linux.intel.com>	 <54F7809E.2010307@opensource.altera.com> <1425552233.14897.189.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <jkosina-AlSwsSmVLrQ@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	<linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	<galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425552233.14897.189.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Andy,

On 03/05/2015 04:43 AM, Andy Shevchenko wrote:
> On Wed, 2015-03-04 at 16:01 -0600, Thor Thayer wrote:
>> Hi Andy,
>>
>> On 03/04/2015 02:44 PM, Andy Shevchenko wrote:
>>> On Wed, 2015-03-04 at 14:31 -0600, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:
>>>> From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
>>>>
>>>> The Altera Arria10 SoC requires 32 bit accesses to peripherals. The
>>>> DesignWare SPI peripheral registers are on 32bit boundaries so this
>>>> patch is minimal. Function pointers are used to select 32bit access
>>>> or 16bit accesses.
>>>
>>>
>>> So, what is exactly the issue when we read only half of the register?
>>> Bus lock, or what?
>>>
>>
>> The read actually works on our chip but I changed both read and write to
>> be consistent. For Arria10, on a 16 bit write the data isn't written
>> into the DesignWare register.
>
> How did you exactly check this?
>

Sorry, I should have been more clear. The architecture of the Arria10 
SoC enforces 32 bit writes - even for the APB bus. The Arria10's 
interconnect only allows 32 bit writes.

As a result, the solution below doesn't work for us.

I do have a much cleaner patch to re-submit but I haven't applied it on 
top of your patches yet & tested yet.

>>
>> In reply to your other email, yes it does support the DW_apb_ssi but the
>> Arria10 architecture requires 32 bit access (actually as you point out,
>> 32 bit writes). We're using the original driver on our older chips but
>> Arria10 requires upstream changes.
>
> Can you check if the following helps in your case:
>
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -170,6 +170,8 @@ static inline u16 dw_readw(struct dw_spi *dws, u32 offset)
>   static inline void dw_writew(struct dw_spi *dws, u32 offset, u16 val)
>   {
>          __raw_writew(val, dws->regs + offset);
> +       mmiowb():
> +       __raw_readw(dws->regs + offset);
>   }
>
>   static inline void spi_enable_chip(struct dw_spi *dws, int enable)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
