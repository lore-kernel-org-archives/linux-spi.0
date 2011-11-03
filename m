From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] spi/pl022: Enable clock in probe an use runtime_idle
Date: Thu, 3 Nov 2011 16:47:15 +0100
Message-ID: <4EB2B783.7020503@stericsson.com>
References: <1319206124-17549-1-git-send-email-ulf.hansson@stericsson.com>
	<20111102141628.GG19187@n2100.arm.linux.org.uk>
	<4EB29E59.4040509@stericsson.com>
	<20111103141336.GN12913@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111103141336.GN12913@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Russell King - ARM Linux wrote:
> On Thu, Nov 03, 2011 at 02:59:53PM +0100, Ulf Hansson wrote:
>>>> @@ -2342,11 +2350,19 @@ static int pl022_runtime_resume(struct device *dev)
>>>>   	return 0;
>>>>  }
>>>> +
>>>> +static int pl022_runtime_idle(struct device *dev)
>>>> +{
>>>> +	pm_runtime_suspend(dev);
>>>> +	return 0;
>>>> +}
>>>>  #endif
>>>>   static const struct dev_pm_ops pl022_dev_pm_ops = {
>>>>  	SET_SYSTEM_SLEEP_PM_OPS(pl022_suspend, pl022_resume)
>>>> -	SET_RUNTIME_PM_OPS(pl022_runtime_suspend, pl022_runtime_resume, NULL)
>>>> +	SET_RUNTIME_PM_OPS(pl022_runtime_suspend,
>>>> +			   pl022_runtime_resume,
>>>> +			   pl022_runtime_idle)
>>> This is an unnecessary change.
>>>
>>> The bus-level ops runtime PM ops call pm_generic_runtime_idle() when
>>> its 'runtime_idle' operation is invoked.  Let's look at the code
>>> there:
>>>
>>> int pm_generic_runtime_idle(struct device *dev)
>>> {
>>>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>>>
>>>         if (pm && pm->runtime_idle) {
>>>                 int ret = pm->runtime_idle(dev);
>>>                 if (ret)
>>>                         return ret;
>>>         }
>>>
>>>         pm_runtime_suspend(dev);
>>>         return 0;
>>> }
>>>
>>> If the driver has a NULL runtime idle, then generic code will call
>>> pm_runtime_suspend() for the device.  So, adding a runtime_idle callback
>>> to a driver to explicitly call pm_runtime_suspend() is not required.
>>>
>> You are somewhat correct. But the patch is still needed as is!
> 
> No it is not required, by any means shape or form.
> 
>> Reason is simply that after a probe, driver core is calling  
>> pm_runtime_put_sync. This will not go through the  
>> pm_generic_runtime_idle function, but directly to __pm_runtime_idle.
> 
> Let's look at the code:
> 
> static inline int pm_runtime_put_sync(struct device *dev)
> {
>         return __pm_runtime_idle(dev, RPM_GET_PUT);
> }
> 
> int __pm_runtime_idle(struct device *dev, int rpmflags)
> {
> ...
>         spin_lock_irqsave(&dev->power.lock, flags);
>         retval = rpm_idle(dev, rpmflags);
>         spin_unlock_irqrestore(&dev->power.lock, flags);
> ...
> }
> 
> static int rpm_idle(struct device *dev, int rpmflags)
> {
>         int (*callback)(struct device *);
> ...
>         if (dev->pm_domain)
>                 callback = dev->pm_domain->ops.runtime_idle;
>         else if (dev->type && dev->type->pm)
>                 callback = dev->type->pm->runtime_idle;
>         else if (dev->class && dev->class->pm)
>                 callback = dev->class->pm->runtime_idle;
>         else if (dev->bus && dev->bus->pm)
>                 callback = dev->bus->pm->runtime_idle;
>         else
>                 callback = NULL;
> 
>         if (callback)
>                 __rpm_callback(callback, dev);
> ...
> }
> 
> static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>         __releases(&dev->power.lock) __acquires(&dev->power.lock)
> {
> ...
>         retval = cb(dev);
> ...
> }
> 
> Nothing in there calls down to the _driver_ level PM ops from the core
> runtime PM code.  What will happen is that this statement will assign
> the callback pointer:
> 
> 	callback = dev->bus->pm->runtime_idle;
> 
> and dev->bus->pm will be &amba_pm.  Its runtime idle function will be
> pm_generic_runtime_idle.  As I quoted above:

This I totally missed! You are absolutely right!
Of course the amba bus calls the generic runtime idle function.

I will re-work the patch and remove the runtime_idle function completely!

> 
>>> int pm_generic_runtime_idle(struct device *dev)
>>> {
>>>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>>>
>>>         if (pm && pm->runtime_idle) {
>>>                 int ret = pm->runtime_idle(dev);
>>>                 if (ret)
>>>                         return ret;
>>>         }
>>>
>>>         pm_runtime_suspend(dev);
>>>         return 0;
>>> }
> 
> This is the only way you get down to the driver-level pm->runtime_idle
> callback.
> 
> Please describe what benefit having *THIS* pm->runtime_idle(dev) pointing
> at your new function:
> 
>>>> +static int pl022_runtime_idle(struct device *dev)
>>>> +{
>>>> +	pm_runtime_suspend(dev);
>>>> +	return 0;
>>>> +}
> 
> gains us over the case where pm->runtime_idle is NULL inside
> pm_generic_runtime_idle().
> 
