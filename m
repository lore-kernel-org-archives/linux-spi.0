From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-pxa2xx: Remove unused legacy PXA DMA API
 channel numbers
Date: Tue, 04 Aug 2015 08:54:26 +0300
Message-ID: <55C05392.80905@linux.intel.com>
References: <1438598472-1145-1-git-send-email-jarkko.nikula@linux.intel.com> <20150803161413.GY20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150803161413.GY20873-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 08/03/2015 07:14 PM, Mark Brown wrote:
> On Mon, Aug 03, 2015 at 01:41:11PM +0300, Jarkko Nikula wrote:
>> These became unused by the commit 6356437e65c2
>> ("spi: spi-pxa2xx: remove legacy PXA DMA bits").
>
> This doesn't apply against current code, please check and resend.
>
Hmm... I'm confused, both patches were done on top of commit 
34cadd9c1bcb ("spi: pxa2xx: Add support for Intel Sunrisepoint") in 
spi/topic/pxa2xx and I see this patch 1/2 applied there and merged into 
for-next now. Anyway, patch 2/2 should still apply fine.

-- 
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
