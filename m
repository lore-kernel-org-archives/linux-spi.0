From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/pl022: Activate resourses before deactivate them in
	suspend
Date: Tue, 30 Oct 2012 18:05:41 +0100
Message-ID: <CAPDyKFofQntK28i23JtZnEbnDfPoFvLC0yBhDR04=qfg=A+WKw@mail.gmail.com>
References: <CAPDyKFoOJz6608b4z2PoW8ODvTJVZRq-yB0itfXnuoXdR1SpGQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1210281659520.9245-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	"Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Ulf Hansson <ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1210281659520.9245-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 28 October 2012 22:09, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> On Sun, 28 Oct 2012, Ulf Hansson wrote:
>
>> On 28 October 2012 20:52, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> > On Sat, Oct 27, 2012 at 11:46 PM, Mark Brown
>> > <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
>> >> On Fri, Oct 05, 2012 at 09:43:32AM +0200, Ulf Hansson wrote:
>> >>
>> >>> To be able to deactivate resourses in suspend, the resourses must
>> >>> first be surely active. This is done with a pm_runtime_get_sync.
>> >>> Once the resourses are restored to active state again in resume,
>> >>> the runtime pm usage count can be decreased with a pm_runtime_put.
>> >>
>> >> The PM core will ensure devices are runtime resumed before we enter
>> >> suspend precisely due to this sort of issue.
>> >
>> > I asked the very same question to Ulf (in speech, sorry
>> > so you couldn't see it...)
>> >
>> > So I guess we are talking about drivers/base/main.c
>> >
>> > in device_prepare()
>> > pm_runtime_get_noresume() is called
>>
>> This will increase the "usage_counter" for the device. It will not
>> "runtime_resume" the device, though it will prevent it from being
>> "runtime_suspended".
>
> Indeed.  The PM core does _not_ insure that devices are runtime resumed
> before going into system suspend.  Some subsystems may do this (the PCI
> subsystem does, for example -- see
> drivers/pci/pci-driver.c:pci_pm_prepare()), but the PM core doesn't.
>
> Alan Stern
>

Thanks for clarifying this Alan. Although, I am having second thoughts
around this patch even if it does what I expect it to do.

I think that the pm_runtime_get_sync (and the corrsponding "put")
should maybe be done in the suspend|resume functions of the amba bus
(drivers/amba/bus.c) instead.
The reason is because the amba bus is responsible for the apb_pclk -
clk, which also should be handled during suspend and this is not the
case right now. Unless we think each amba device driver should handle
this clock during suspend|resume...

Kind regards
Ulf Hansson

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
