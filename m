From: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/atmel: add support for runtime PM
Date: Fri, 17 Oct 2014 07:22:09 -0700
Message-ID: <7hd29qhj3i.fsf@deeprootsystems.com>
References: <1413424160-21180-1-git-send-email-wenyou.yang@atmel.com>
	<7hk33yhms4.fsf@deeprootsystems.com>
	<20141017135716.GS1820@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141017135716.GS1820-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> (Mark Brown's message of
	"Fri, 17 Oct 2014 15:57:16 +0200")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

> On Fri, Oct 17, 2014 at 06:02:35AM -0700, Kevin Hilman wrote:
>> Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> writes:
>
>> > +	if (!pm_runtime_suspended(dev)) {
>> > +		clk_disable_unprepare(as->clk);
>> > +		pinctrl_pm_select_sleep_state(dev);
>> > +	}
>
>> a.k.a. pm_runtime_put_sync() since the ->runtime_suspend() callback does
>> the same thing.
>
> Will that do the right thing when runtime PM is disabled in Kconfig?

Good point.

Then the way to make this cleaner, and obvious on inspection that system
suspend/resume are doing the same thing as runtime suspend/resume is to
have ->suspend call the runtime_suspend function.

The runtime suspend/resume functions then should be wrapped in CONFIG_PM
instead of CONFIG_PM_RUNTIME.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
