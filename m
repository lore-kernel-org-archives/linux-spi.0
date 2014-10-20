From: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/atmel: add support for runtime PM
Date: Mon, 20 Oct 2014 11:09:19 -0700
Message-ID: <7hd29mfwa8.fsf@deeprootsystems.com>
References: <1413424160-21180-1-git-send-email-wenyou.yang@atmel.com>
	<7hk33yhms4.fsf@deeprootsystems.com>
	<20141017135716.GS1820@sirena.org.uk>
	<7hd29qhj3i.fsf@deeprootsystems.com>
	<B256D81BAE5131468A838E5D7A243641BF594F37@penmbx01>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi\@vger.kernel.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel\@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Ferre\, Nicolas" <Nicolas.FERRE-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"linux-arm-kernel\@lists.infradead.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: "Yang\, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B256D81BAE5131468A838E5D7A243641BF594F37@penmbx01> (Wenyou
	Yang's message of "Mon, 20 Oct 2014 02:05:42 +0000")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

"Yang, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
>> Sent: Friday, October 17, 2014 10:22 PM
>> To: Mark Brown
>> Cc: Yang, Wenyou; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Ferre,
>> Nicolas; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> Subject: Re: [PATCH] spi/atmel: add support for runtime PM
>> 
>> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:
>> 
>> > On Fri, Oct 17, 2014 at 06:02:35AM -0700, Kevin Hilman wrote:
>> >> Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> writes:
>> >
>> >> > +	if (!pm_runtime_suspended(dev)) {
>> >> > +		clk_disable_unprepare(as->clk);
>> >> > +		pinctrl_pm_select_sleep_state(dev);
>> >> > +	}
>> >
>> >> a.k.a. pm_runtime_put_sync() since the ->runtime_suspend() callback
>> >> does the same thing.
>> >
>> > Will that do the right thing when runtime PM is disabled in Kconfig?
>> 
>> Good point.
>> 
>> Then the way to make this cleaner, and obvious on inspection that system
>> suspend/resume are doing the same thing as runtime suspend/resume is to have -
>> >suspend call the runtime_suspend function.
>> 
>> The runtime suspend/resume functions then should be wrapped in CONFIG_PM
>> instead of CONFIG_PM_RUNTIME.
> But if the runtime PM is disabled, __pm_runtime_idle() return -ENOSYS,
> which invoked by pm_runtime_put_sync(), in spite of the runtime
> suspend/resume functions wrapper,

You won't be calling _put_sync(), instead you'll just directly call
atmel_spi_runtime_suspend().

The goal is to make it obvious upon reading that ->suspend and
->runtime_suspend are doing exactly the same thing.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
