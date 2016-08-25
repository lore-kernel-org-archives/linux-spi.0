From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] spi: qup: skip clk_disable_unprepare if the device is
 already runtime suspended
Date: Thu, 25 Aug 2016 14:27:53 +0100
Message-ID: <6816de1a-430c-ba4c-fb48-b8728cc074f2@arm.com>
References: <1472128408-7231-1-git-send-email-sudeep.holla@arm.com>
 <20160825132606.GA24683@hector.attlocal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160825132606.GA24683-3KkwrOJo9xYlRp7syxWybdHuzzzSOjJt@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Andy,

On 25/08/16 14:26, Andy Gross wrote:
> On Thu, Aug 25, 2016 at 01:33:28PM +0100, Sudeep Holla wrote:
>> If the spi device is already runtime suspended, if spi_qup_suspend is
>> executed during suspend-to-idle or suspend-to-ram it will result in the
>> following splat:
>>
>> WARNING: CPU: 3 PID: 1593 at drivers/clk/clk.c:476 clk_core_unprepare+0x80/0x90
>> Modules linked in:
>>
>
> <snip>
>
> Thanks for fixing this.  I had noticed this yesterday when I was testing your
> freeze patch but hadn't had time to dig in.
>

Yes, even I tested the same once I got PSCI firmware :)

>
> Tested-by: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>

Thanks.

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
