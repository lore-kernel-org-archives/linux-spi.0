From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/pl022: Activate resourses before deactivate them in
	suspend
Date: Sun, 28 Oct 2012 21:28:44 +0100
Message-ID: <CAPDyKFoOJz6608b4z2PoW8ODvTJVZRq-yB0itfXnuoXdR1SpGQ@mail.gmail.com>
References: <1349423012-18048-1-git-send-email-ulf.hansson@stericsson.com>
	<20121027214642.GH4564@opensource.wolfsonmicro.com>
	<CACRpkdbCfxnSSLR6GoSbAxtfnwOivxCCrLtwnR=9tpwpfACqTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	"Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Ulf Hansson <ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACRpkdbCfxnSSLR6GoSbAxtfnwOivxCCrLtwnR=9tpwpfACqTQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 28 October 2012 20:52, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Sat, Oct 27, 2012 at 11:46 PM, Mark Brown
> <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
>> On Fri, Oct 05, 2012 at 09:43:32AM +0200, Ulf Hansson wrote:
>>
>>> To be able to deactivate resourses in suspend, the resourses must
>>> first be surely active. This is done with a pm_runtime_get_sync.
>>> Once the resourses are restored to active state again in resume,
>>> the runtime pm usage count can be decreased with a pm_runtime_put.
>>
>> The PM core will ensure devices are runtime resumed before we enter
>> suspend precisely due to this sort of issue.
>
> I asked the very same question to Ulf (in speech, sorry
> so you couldn't see it...)
>
> So I guess we are talking about drivers/base/main.c
>
> in device_prepare()
> pm_runtime_get_noresume() is called

This will increase the "usage_counter" for the device. It will not
"runtime_resume" the device, though it will prevent it from being
"runtime_suspended".

> and in device_complete()
> pm_runtime_put_sync() is called.
>

> Both put into current for in
> commit 88d26136a256576e444db312179e17af6dd0ea87
> on sep 19th.
>
> Yes it seems like it will do the job.
>
> Ulf can you comment on this...
>
> Yours,
> Linus Walleij

Kind regards
Ulf Hansson

------------------------------------------------------------------------------
WINDOWS 8 is here. 
Millions of people.  Your app in 30 days.
Visit The Windows 8 Center at Sourceforge for all your go to resources.
http://windows8center.sourceforge.net/
join-generation-app-and-make-money-coding-fast/
