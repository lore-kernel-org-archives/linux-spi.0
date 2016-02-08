From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: [PATCH] spi: Add struct spi_master max_transfer_size member to
 kernel-doc
Date: Mon, 8 Feb 2016 18:34:21 -0300
Message-ID: <56B909DD.9010504@osg.samsung.com>
References: <1454965848-5120-1-git-send-email-javier@osg.samsung.com>
 <20160208211553.GA13270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160208211553.GA13270-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark,

On 02/08/2016 06:15 PM, Mark Brown wrote:
> On Mon, Feb 08, 2016 at 06:10:48PM -0300, Javier Martinez Canillas wrote:
>> Commit 4acad4aae10d ("spi: expose master transfer size limitation.") added
>> a parameter to specify the SPI controller maximum transfer size limitation
>> but did not update the kernel-doc so building the docs leads to a warning:
>
> This duplicates a patch Randy sent earlier.
>

Ok, I missed that patch. Thanks.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
