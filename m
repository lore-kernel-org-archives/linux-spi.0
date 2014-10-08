From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] spi: pl022: Fix broken spidev when DMA is enabled
Date: Wed, 8 Oct 2014 11:31:29 -0700
Message-ID: <54358301.20505@broadcom.com>
References: <rjui@broadcom.com> <1412743127-4523-1-git-send-email-rjui@broadcom.com> <20141008112143.GT4609@sirena.org.uk> <543562EB.8060300@broadcom.com> <20141008182123.GH4609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	JD Zheng <jdzheng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	"Scott Branden" <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141008182123.GH4609-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 10/8/2014 11:21 AM, Mark Brown wrote:
> On Wed, Oct 08, 2014 at 09:14:35AM -0700, Ray Jui wrote:
>
>> Thanks for the reply. It looks like you are also the maintainer of spidev.
>> In this case, could you please help to confirm that you expect spidev to use
>> separate buffers for TX and RX? If so, I can go ahead and make the change in
>> spidev.
>
> Yes, that would be my expectation for maximum robustness (or if it is
> going to use one buffer it explicitly maps it for mixed use but I'd
> expect that to be asking for trouble).
>
Okay, Mark. I'm going to make the change in the spidev and submit a new 
patch.

Thanks for the feedback.

Ray
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
