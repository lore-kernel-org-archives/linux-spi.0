From: Alexis RODET <alexis.rodet-zROAmvwsW6hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] Renaming 'struct flash_platform_data' into 'struct
	spi_flash_platform_data' in include/linux/spi/flash.h
Date: Mon, 22 Nov 2010 15:15:12 +0100
Message-ID: <4CEA7AF0.6000804@bvs-tech.com>
References: <20101117160514.GA5308@n2100.arm.linux.org.uk>	
	<4CE6B27D.2000909@bvs-tech.com> <20101121044720.GA6088@tarshish>	
	<4CEA3EAE.4080700@bvs-tech.com> <1290434369.2529.38.camel@helium>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030904090908030809030508"
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1290434369.2529.38.camel@helium>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is a multi-part message in MIME format.
--------------030904090908030809030508
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David,

Le 22/11/2010 14:59, David Brownell a écrit :
> On Mon, 2010-11-22 at 10:58 +0100, Alexis RODET wrote:
>> Hello,
>>
>>  there is a problem with the double
>> definition of 'struct flash_platform_data' that are incompatible:
>>
>> in arch/arm/include/asm/mach/flash.h:
>> in include/linux/spi/flash.h:
>> Both headers are included in a number of machines or driver.
> And this patch doesn't touch machine or driver code, so it's incomplete.
Look at the patch in previous mail attachment and you'll see it does.

39 files changed, 41 insertions(+), 41 deletions(-)

Sorry I didn't put it in message core because I already posted it on
linux-mtd-IAPFreCvJWM7uuMidbF8XZu6nac5fYnt@public.gmane.org
I don't know the good usage.

> ISTR the last time this issue was raised, a similar incomplete patch was
> proposed.
>
> How about a patch that does the full rename??
What do you mean ?
Renaming 'struct flash_platform_data' from
arch/arm/include/asm/mach/flash.h also ?
Or moving arch/arm/include/asm/mach/flash.h in common includes ?

Alexis

--------------030904090908030809030508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
--------------030904090908030809030508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--------------030904090908030809030508--
