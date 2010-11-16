From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 08/12] gpio: add ti-ssp gpio driver
Date: Tue, 16 Nov 2010 14:38:08 -0500
Message-ID: <4CE2DDA0.1030404@ti.com>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-9-git-send-email-cyril@ti.com>
	<4CE1B651.1060006@bluewatersys.com>
Reply-To: cyril-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
	"dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	"khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>,
	"broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org"
	<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	"rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>,
	"alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org" <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
To: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4CE1B651.1060006-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 11/15/2010 05:38 PM, Ryan Mallon wrote:
> On 11/16/2010 08:12 AM, Cyril Chemparathy wrote:
>> TI's SSP controller pins can be directly read and written to behave like a
>> GPIO.  This patch adds a GPIO driver that exposes such functionality.
>>
>> Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
>> ---
[...]
>> +	spin_lock_init(&gpio->lock);
>> +	platform_set_drvdata(pdev, gpio);
>> +
>> +	gpio->chip.base  = pdata->start;
>> +	gpio->chip.ngpio = 4;
> 
> Is this always four or can the SSP peripheral be configured to have
> varying numbers of gpios. Maybe the number of gpios should be passed via
> platform data?
> 

This can only be 4 (hw defined per-port limit).

I have changed as per your other comments, and will post an update.

Thanks
Cyril.

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
