From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: [PATCH 18/18] spi: (RFC, don't apply) report OF style modalias
 when probing using DT
Date: Mon, 24 Aug 2015 10:00:15 +0200
Message-ID: <55DACF0F.2000505@osg.samsung.com>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-19-git-send-email-javier@osg.samsung.com>
 <20150820183634.GN12027@sirena.org.uk> <20150820210822.GH74600@google.com>
 <55D64A65.7030905@osg.samsung.com> <20150820232517.GZ12027@sirena.org.uk>
 <55D666F4.2080801@osg.samsung.com> <20150821172931.GK12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150821172931.GK12027-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark,

On 08/21/2015 07:29 PM, Mark Brown wrote:
> On Fri, Aug 21, 2015 at 01:47:00AM +0200, Javier Martinez Canillas wrote:
>> On 08/21/2015 01:25 AM, Mark Brown wrote:
>>> On Thu, Aug 20, 2015 at 11:45:09PM +0200, Javier Martinez Canillas wrote:
> 
>>>>> IOW, it's labeled as such mostly for safety, since it has quite a few
>>>>> distributed dependencies.
> 
>>> Are there really only 17 drivers that are missing an explict of_table?
>>> That seems like a low number.
> 
>> In fact the 17 patches are the combination of the SPI drivers that:
> 
>> a) Have a .id_table but not a MODULE_DEVICE_TABLE(spi,...)
>> b) Have a .of_match_table but no a MODULE_DEVICE_TABLE(of,...)
>> c) Don't have a .of_match_table but have a DT binding document
> 
>> Maybe there are more SPI drivers out there that only have a .id_table
>> and don't have a .of_match_table nor a DT binding doc. But in that case
>> there isn't too much I can do since I've no information that these are
>> drivers are actually used in systems booted with OF.
> 
> We could at the very least scan through the in tree DTs.  There does
> seem to be a substantial overlap between systems that often don't use
> modular kernels but could and systems where people are using the I2C
> and SPI ID mapping shims.
> 

My script does this but didn't find any matches.

Basically what I do is for drivers with no OF table, to take the name field
from the spi_device_id in the SPI id table and see if one of these are used
as a compatible string either in a DTS or mentioned in a DT binding.

I found some matches in DT bindings which are the type c) issue but none
used in an in tree DTS.

But that doesn't mean that there could be drivers with no OF table, no DT
binding and with out-of-tree DTS that are using compatible = "bar" instead
compatible = "foo,bar" and relying on SPI matching using the SPI device id
table as a fallback. But I guess these should be fixed for module autoload.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
