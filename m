From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 6/7] spi: pxa2xx: Add support for multiple LPSS chip select
 signals
Date: Mon, 26 Oct 2015 11:35:04 +0200
Message-ID: <562DF3C8.1060401@linux.intel.com>
References: <1445521485-2029-1-git-send-email-jarkko.nikula@linux.intel.com>	<1445521485-2029-6-git-send-email-jarkko.nikula@linux.intel.com> <87bnbnkvg9.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87bnbnkvg9.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 10/25/2015 02:02 PM, Robert Jarzmik wrote:
> Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
>
>> LPSS SPI devices in a successor of Intel Sunrisepoint can have up to 4 chip
>                     is ?

Intel Low Power Subsystem SPI host controller(s) after Sunrisepoint can 
have multiple chip selects. I'll clarify this since patch 7/7 outdates 
the comment by adding support for two variants.

>> @@ -64,6 +65,10 @@ MODULE_ALIAS("platform:pxa2xx-spi");
>>   #define GENERAL_REG_RXTO_HOLDOFF_DISABLE	BIT(24)
>>   #define SPI_CS_CONTROL_SW_MODE			BIT(0)
>>   #define SPI_CS_CONTROL_CS_HIGH			BIT(1)
>
>> +#define SPI_CS_CONTROL_CS_SEL_SHIFT		8
>> +#define SPI_CS_CONTROL_CS_SEL_MASK		(3 << SPI_CS_CONTROL_CS_SEL_SHIFT)
>> +#define SPI_CAPS_CS_EN_SHIFT			9
>> +#define SPI_CAPS_CS_EN_MASK			(0xf << SPI_CAPS_CS_EN_SHIFT)
> This is intel specific, not pxa oriented, right ?
> If so, I'd like to have it namespaced, with LPSS or whatever you see fit.
>
Good point. I'll check also couple other existing defines as they are 
LPSS specific.

>> @@ -103,6 +111,7 @@ static const struct lpss_config lpss_platforms[] = {
>>   		.reg_general = -1,
>>   		.reg_ssp = 0x20,
>>   		.reg_cs_ctrl = 0x24,
>> +		.reg_capabilities = 0xfc,
> Immediate value ? I suppose a defines usage was not possible here ?
>
I removed register defines for these three registers earlier when code 
started accessing registers using this configuration data. There are 
differences in these registers between platforms and it didn't look much 
clearer to have separate defines for them.

>> @@ -271,15 +280,34 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
>>   static void lpss_ssp_cs_control(struct driver_data *drv_data, bool enable)
>>   {
>>   	const struct lpss_config *config;
>> -	u32 value;
>> +	u32 value, cs;
>>
>>   	config = lpss_get_config(drv_data);
>>
>>   	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
>> -	if (enable)
>> +	if (enable) {
>> +		cs = drv_data->cur_msg->spi->chip_select;
>> +		cs <<= SPI_CS_CONTROL_CS_SEL_SHIFT;
>> +		if (cs != (value & SPI_CS_CONTROL_CS_SEL_MASK)) {
>> +			/*
>> +			 * When switching another chip select output active
>> +			 * the output must be selected first and wait 2 ssp_clk
>> +			 * cycles before changing state to active. Otherwise
>> +			 * a short glitch will occur on the previous chip
>> +			 * select since output select is latched but state
>> +			 * control is not.
>> +			 */
>> +			value &= ~SPI_CS_CONTROL_CS_SEL_MASK;
>> +			value |= cs;
>> +			__lpss_ssp_write_priv(drv_data,
>> +					      config->reg_cs_ctrl, value);
>> +			ndelay(1000000000 /
>> +			       (drv_data->master->max_speed_hz / 2));
> That ndelay() looks weird, why delay and not sleep ?
> And wouldn't that be targeted at another patch ? If I got it right, this patch
> deals with capabilites, not chip select timings, doesn't it ?
>
Typically we are seeing input clock of SSP being around a few or tens of 
megahertz so sleep instead of <1 us delay would slow down the transfers 
needlessly.

That said, we may have a need to change this to use delay or sleep 
conditionally later. Andy has been looking at changing input clock 
according to transfer speed which means that needed delay can be up to 
milliseconds if we use really low transfer speed.

Actually this patch deals with output control and number of chip select 
detection. Maybe it calls for two patches. Output control prepares for 
multiple chip selects and detection adds actual support for them.

-- 
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
