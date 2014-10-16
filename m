From: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/rockchip: fix bug that case spi can't go as fast
 as slave request
Date: Thu, 16 Oct 2014 17:16:02 +0800
Message-ID: <543F8CD2.1010302@rock-chips.com>
References: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com> <1413372349-4254-1-git-send-email-addy.ke@rock-chips.com> <20141015130452.GD27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, amstan-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, sonnyrao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wei.luo-TNX95d0MmH7DzftRWevZcw@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141015130452.GD27755-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

hi, Mark

On 2014/10/15 21:04, Mark Brown wrote:
> On Wed, Oct 15, 2014 at 07:25:49PM +0800, Addy Ke wrote:
> 
>> +	if (WARN_ON(rs->speed > MAX_SCLK_OUT))
>> +		rs->speed = MAX_SCLK_OUT;
>> +
>> +	/* the minimum divsor is 2 */
>> +	if (rs->max_freq < 2 * rs->speed) {
>> +		clk_set_rate(rs->spiclk, 2 * rs->speed);
>> +		rs->max_freq = clk_get_rate(rs->spiclk);
>> +	}
> 
> I'll apply this but you should be checking the return code from
> clk_set_rate() here, please send a followup patch doing that.  It might

If clk_set_rate return error, do I only put dev_warn here or return error value to spi core?

> also be worth consdering just setting the rate unconditionally here, it
> seems like it should make things simpler.
> 
I think we need.
If we set the rate unconditionally here, clk_set_rate() will be executed in each spi transfer.




--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
