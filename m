From: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
Subject: RE: [PATCH] spi/atmel: add support for runtime PM
Date: Tue, 21 Oct 2014 00:51:20 +0000
Message-ID: <B256D81BAE5131468A838E5D7A243641BF59671F@penmbx01>
References: <1413424160-21180-1-git-send-email-wenyou.yang@atmel.com>
 <7hk33yhms4.fsf@deeprootsystems.com>	<20141017135716.GS1820@sirena.org.uk>
 <7hd29qhj3i.fsf@deeprootsystems.com>
 <B256D81BAE5131468A838E5D7A243641BF594F37@penmbx01>
 <7hd29mfwa8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, "Ferre, Nicolas" <Nicolas.FERRE@atmel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Kevin Hilman <khilman@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7hd29mfwa8.fsf@deeprootsystems.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@kernel.org]
> Sent: Tuesday, October 21, 2014 2:09 AM
> To: Yang, Wenyou
> Cc: Mark Brown; linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org; Ferre,
> Nicolas; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] spi/atmel: add support for runtime PM
> 
> "Yang, Wenyou" <Wenyou.Yang@atmel.com> writes:
> 
> >> -----Original Message-----
> >> From: Kevin Hilman [mailto:khilman@kernel.org]
> >> Sent: Friday, October 17, 2014 10:22 PM
> >> To: Mark Brown
> >> Cc: Yang, Wenyou; linux-spi@vger.kernel.org;
> >> linux-kernel@vger.kernel.org; Ferre, Nicolas;
> >> linux-arm-kernel@lists.infradead.org
> >> Subject: Re: [PATCH] spi/atmel: add support for runtime PM
> >>
> >> Mark Brown <broonie@kernel.org> writes:
> >>
> >> > On Fri, Oct 17, 2014 at 06:02:35AM -0700, Kevin Hilman wrote:
> >> >> Wenyou Yang <wenyou.yang@atmel.com> writes:
> >> >
> >> >> > +	if (!pm_runtime_suspended(dev)) {
> >> >> > +		clk_disable_unprepare(as->clk);
> >> >> > +		pinctrl_pm_select_sleep_state(dev);
> >> >> > +	}
> >> >
> >> >> a.k.a. pm_runtime_put_sync() since the ->runtime_suspend()
> >> >> callback does the same thing.
> >> >
> >> > Will that do the right thing when runtime PM is disabled in Kconfig?
> >>
> >> Good point.
> >>
> >> Then the way to make this cleaner, and obvious on inspection that
> >> system suspend/resume are doing the same thing as runtime
> >> suspend/resume is to have -
> >> >suspend call the runtime_suspend function.
> >>
> >> The runtime suspend/resume functions then should be wrapped in
> >> CONFIG_PM instead of CONFIG_PM_RUNTIME.
> > But if the runtime PM is disabled, __pm_runtime_idle() return -ENOSYS,
> > which invoked by pm_runtime_put_sync(), in spite of the runtime
> > suspend/resume functions wrapper,
> 
> You won't be calling _put_sync(), instead you'll just directly call
> atmel_spi_runtime_suspend().
Got it , I will change it. Thanks.

> 
> The goal is to make it obvious upon reading that ->suspend and
> ->runtime_suspend are doing exactly the same thing.
> 
> Kevin

Best Regards,
Wenyou Yang
