From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi/xilinx: Use automatic bus number on device tree
Date: Wed, 21 Jan 2015 17:51:19 +0100
Message-ID: <CAPybu_2UqrAQ+a=9Luni12uvN8hfa9DFW8vtfGp+UE_VcMX_hw@mail.gmail.com>
References: <1421855590-9210-1-git-send-email-ricardo.ribalda@gmail.com>
 <1421855590-9210-2-git-send-email-ricardo.ribalda@gmail.com> <54BFCDA1.4060205@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"moderated list:ARM/S5P EXYNOS AR..."
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54BFCDA1.4060205-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Lars

I think you are right. The other patches on the set are still valid though


Thanks!

On Wed, Jan 21, 2015 at 5:02 PM, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
> On 01/21/2015 04:53 PM, Ricardo Ribalda Delgado wrote:
>>
>> If there is more than one spi device on a device tree, the second one
>> will fail to probe due to a duplicated bus_num.
>
>> [...]
>
> This should already be fixed. See commit 4b153a2137c5 ("spi: xilinx: Use
> pdev->id instead of pdev->dev.id for the SPI bus number")[1]. If the device
> was registered using devicetree pdev->id is -1, so dynamic numbers will be
> used.
>
> - Lars
>
> [1]
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-xilinx.c?id=4b153a2137c5d2914794c8944d78c731c1b0ae9d
>



-- 
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
