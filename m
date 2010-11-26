From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/9] spi/pxa2xx: don't use subys initcall for driver init
Date: Thu, 25 Nov 2010 18:14:49 -0700
Message-ID: <AANLkTi=tbiYCvTKH_wDDE0QuFpoBMnw-ZjF826VupnRA@mail.gmail.com>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
	<1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
	<AANLkTin4vh85XRkEd7YocCmKngViR_qZDe7z1b4JXyd-@mail.gmail.com>
	<4CED1C95.8070300@linutronix.de>
	<20101124141623.GH24970@rakim.wolfsonmicro.main>
	<4CED3199.2040700@linutronix.de>
	<20101125235415.GA9310@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
	drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101125235415.GA9310-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Nov 25, 2010 at 4:54 PM, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Wed, Nov 24, 2010 at 04:39:05PM +0100, Sebastian Andrzej Siewior wrote:
>> Mark Brown wrote:
>>> On Wed, Nov 24, 2010 at 03:09:25PM +0100, Sebastian Andrzej Siewior wro=
te:
>>>
>>>> I've been pointed out to this commit but I don't understand _why_.
>>>> The part I don't get is "so it can be used with cpufreq". Is it
>>>> refered to a driver or the subsystem as it?
>>>
>>> We need the regulators for the CPU rails to start before the cpufreq
>>> driver starts so cpufreq can talk to them, and since the regulators may
>>> be SPI attached this means we also need the SPI controller to start
>>> before cpufreq. =A0cpufreq starts at vanilla init time.
>>
>> After digging through the code I think I've found it. pxa_cpu_init()
>> registers a cpufreq client. cpufreq calls init and pxa then
>> regulator_get() to get the regulator and I guess this is the problem.
>> So I would suggest to defer pxa_cpu_init() via late_initcall().
>>
>> The other way around will force you to hack the init code for various
>> drivers to make it work.
>
> Why should the PXA code change when you haven't explained _why_ you want
> to change the SPI driver to conform to your idea?

The idea is to get away from trying to resolve probe order issue by
messing with the initcall level in spi and i2c bus drivers.  It's
fragile, and it doesn't work with drivers as modules.  Instead, we're
investigating making the dependencies explicit in the board support
code.  However, hacking other initcalls to enable what I want to do on
the spi bus drivers isn't a solution, it is just moving the problem.

g.

---------------------------------------------------------------------------=
---
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
