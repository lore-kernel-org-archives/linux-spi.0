From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: rockchip: add debug interface support
Date: Tue, 16 Feb 2016 09:32:23 +0800
Message-ID: <56C27C27.8090108@rock-chips.com>
References: <1455524848-2646-1-git-send-email-shawn.lin@rock-chips.com>
 <1455524902-2780-1-git-send-email-shawn.lin@rock-chips.com>
 <20160215172632.GQ18988@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, shawn.lin-NgiFYW8Wbx6Ta72+1OMJgUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160215172632.GQ18988-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On 2016/2/16 1:26, Mark Brown wrote:
> On Mon, Feb 15, 2016 at 04:28:22PM +0800, Shawn Lin wrote:
>
>> +#ifdef CONFIG_DEBUG_FS
>> +#include <linux/debugfs.h>
>> +#endif
>
> Just include the header.  Only add ifdefs if they do something.
>
>> +static int rockchip_spi_debugfs_init(struct rockchip_spi *rs)
>> +{
>> +	rs->debugfs = debugfs_create_dir("rockchip_spi", NULL);
>> +	if (!rs->debugfs)
>> +		return -ENOMEM;
>> +
>> +	debugfs_create_file("regs", S_IFREG | S_IRUGO,
>> +		rs->debugfs, (void *)rs, &rockchip_spi_dbg_ops);
>> +	return 0;
>> +}
>
> This is completely separate to the core debugfs support for SPI, if
> we're adding new debugfs stuff that's per device we should be extending
> the core debugfs stuff so everything is in one place.

yes, I will check the spi core debugfs to see how we can extend it
for per device to dump specific msg.

Thanks.

>
> Your register dump stuff looks like you might want to consider using
> regmap, it's got this and other register access diagnostics already.
>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
