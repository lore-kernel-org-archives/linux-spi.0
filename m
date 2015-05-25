From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH spi 1/7] spi-tegra20-slink: remove duplicate check on
 resource
Date: Mon, 25 May 2015 20:13:48 +0530
Message-ID: <55633524.2060704@gmail.com>
References: <1413885950-24208-1-git-send-email-varkab@cdac.in> <544F22C8.8040106@gmail.com> <20150525140806.GX21391@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "varkab-If5XQcfNmg0@public.gmane.org" <varkab-If5XQcfNmg0@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150525140806.GX21391-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Monday 25 May 2015 07:38 PM, Mark Brown wrote:

> On Tue, Oct 28, 2014 at 10:29:52AM +0530, Varka Bhadram wrote:
>> On 10/21/2014 03:35 PM, Varka Bhadram wrote:
>>> Sanity check on resource happening with devm_ioremap_resource().
>>> +
>>>   	spi_irq = platform_get_irq(pdev, 0);
>>>   	tspi->irq = spi_irq;
>>>   	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
>> Ping...
> Please don't send content free pings, and always send patches to
> maintainers as covered in SubmittingPatches.

Sorry for the mess. I send this series long back on 10/21/2014.

Do you think that should i do something for this series..?

-- 
Varka Bhadram.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
