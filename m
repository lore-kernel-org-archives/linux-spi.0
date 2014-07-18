From: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/4] ARM: DTS: fix the chip select gpios definition in
 the SPI nodes
Date: Sat, 19 Jul 2014 04:16:33 +0900
Message-ID: <53C97291.3040501@samsung.com>
References: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk> <1405523950-2231-5-git-send-email-javier.martinez@collabora.co.uk> <20140717184944.GE17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140717184944.GE17528-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 07/18/14 03:49, Mark Brown wrote:
> On Wed, Jul 16, 2014 at 05:19:10PM +0200, Javier Martinez Canillas wrote:
>> From: Naveen Krishna Chatradhi<ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>
>> This patch replaces the "cs-gpio" from "controller-data" node
>> as was specified in the old binding and uses the standard
>> "cs-gpios" property expected by the SPI core as is defined now
>> in the spi-s3c64xx driver DT binding.
>
> I've applied this one too since everything here really ought to go in
> together and we should probably try to get this into v3.16 - Kukjin,
> please say if this is an issue and I can revert.
>
It should be fine to me :)

Thanks for your asking.

- Kukjin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
