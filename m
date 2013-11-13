From: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Wed, 13 Nov 2013 09:28:59 +0100
Message-ID: <5283384B.504@samsung.com>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com>
 <1546740.qqSm3Pi1hO@flatron> <20131108110517.GK2493@sirena.org.uk>
 <3104102.55j2C8XQ5u@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Rajeshwari Birje <rajeshwari.birje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Rajeshwari S Shinde <rajeshwari.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Lukasz Czerwinski <l.czerwinski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <3104102.55j2C8XQ5u@flatron>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 11/10/2013 06:26 PM, Tomasz Figa wrote:
> On Friday 08 of November 2013 11:05:17 Mark Brown wrote:
>> On Thu, Nov 07, 2013 at 10:39:37AM +0100, Tomasz Figa wrote:
>>> On Thursday 07 of November 2013 14:52:36 Rajeshwari Birje wrote:
>>>> The reordering of the words is taken care by the Swap configuration
>>>> (swap_cfg) register, which I have set for both 16 and 32 bits_per_word
>>>> case. I have tested this patch and works fine for me and also has
>>>> improved the timing performance.
>>> This driver seems to have already worked fine with 32 bits per word,
>>> using the s5c73m3 camera sensor, which uses SPI for firmware upload.
>> This is all sounding very confused.  Either this patch is a bug fix or
>> it's breaking the driver but I can't tell without more information about
>> what it's supposed to do.  Can someone explain in concrete terms what
>> the intended effect of the patch is on wire behaviour?
>>
>> It is possible that the s5c73m3 driver is buggy here if it's only been
>> tested with the s3c64xx driver (which seems likely) since the author
>> could have worked around the driver behaviour.
> I'm confused here as well.
>
> Looking at the W25Q32DW datasheet[1], it does not really support 32 bit
> words and using such with it seems more like an abuse of this feature.
>
> As for the s5c73m3 sensor, we should ask Andrzej or Sylwester to look
> at the datasheet and see how SPI transfer are supposed to work there.
Hi all,

s5c73m3 sensor specs we have access to say nothing about the subject.
Driver is based on internal code, which is also not helpful in this matter.

Regards
Andrzej
>
> [1] http://www.winbond.com.tw/NR/rdonlyres/D35D5D04-4CE9-46A1-8950-AEA573045507/0/W25Q32DW.pdf
>
> Best regards,
> Tomasz
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
