From: Nicholas Mc Guire <der.herr-kA1LtwSENNE@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: tegra20-sflash: cleanup wait_for_completion
	return handling
Date: Mon, 2 Feb 2015 10:08:09 +0100
Message-ID: <20150202090809.GB19706@opentech.at>
References: <1422795604-29004-1-git-send-email-hofrat@osadl.org> <54CF3CC5.6030204@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54CF3CC5.6030204-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 02 Feb 2015, Laxman Dewangan wrote:

> On Sunday 01 February 2015 06:30 PM, Nicholas Mc Guire wrote:
>> return type of wait_for_completion_timeout is unsigned long not int, this
>> patch adds an appropriate variable and fixes up the assignment.
>> As the string in dev_err already states "timeout" there
>> is little point in printing the 0 here.
>>
>> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
>
> Looks good to me. Thanks for fixing this.
> I think it is good if we fix the typo here also.
>
> Acked-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
>>
>> +		if (WARN_ON(dma_timeout == 0)) {
>>   			dev_err(tsd->dev,
>> -				"spi trasfer timeout, err %d\n", ret);
>> +				"spi trasfer timeout\n");
>
> trasfer -> transfer.
>
>
overlooked that - sorry - will fix it up and resubmit.

thx!
hofrat
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
