From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 04/12] spi: add ti-ssp spi master driver
Date: Tue, 16 Nov 2010 19:17:18 -0500
Message-ID: <4CE31F0E.7050103@ti.com>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-5-git-send-email-cyril@ti.com>
	<20101116072225.GF4074@angua.secretlab.ca>
	<AANLkTi=utWumLKo9QVWXpkC8WxpgaNJJs+dj=pa2eq-q@mail.gmail.com>
Reply-To: cyril-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        "linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
        "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>,
        "alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org" <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <AANLkTi=utWumLKo9QVWXpkC8WxpgaNJJs+dj=pa2eq-q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 11/16/2010 02:47 AM, Grant Likely wrote:
> On Tue, Nov 16, 2010 at 12:22 AM, Grant Likely
> <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>> On Mon, Nov 15, 2010 at 02:12:06PM -0500, Cyril Chemparathy wrote:
>>> This patch adds an SPI master implementation that operates on top of an
>>> underlying TI-SSP port.
>>>
>>> Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
>> [...]
>>> +static int __init ti_ssp_spi_init(void)
>>> +{
>>> +     return platform_driver_register(&ti_ssp_spi_driver);
>>> +}
>>> +subsys_initcall(ti_ssp_spi_init);
>>
>> After discussions about device init dependencies at plumbers, and
>> since this is the first SPI device driver I've reviewed since that
>> dicussion, this driver gets to be the first to implement the proposed
>> policy.  :-)
>>
>> Change this to module_initcall().  Many spi and i2c drivers use
>> module or subsys_initcall to try and influence driver probe order so
>> that certain regulator chips get registered before the devices that
>> try to use them.  This approach is insane.
>>
>> Instead, it is now incumbent on the board support code to ensure that
>> any device that depends on another device (including i2c or spi
>> regulators) will defer registration until the prerequisite devices are
>> bound to drivers.
>>
>> I don't *think* this change will affect anything in this particular
>> patch series, but if it does then let me know and I'll help you work out
>> how to fix it using a bus notifier.
> 
> Oh, wait, spoke too soon.  You do add a regulator in this series, so
> this change will require a fixup.  The solution is to register an
> bus_notifier to the spi bus type before you start registering devices.
> It also requires deferring the musb_hdrc.1 and tps6116x registrations
> until the bus_notifier callback gets called with an indication that
> the regulator is bound.  It will look something like this:
> 
> static int tnetv107x_spi_notifier_call(struct notifier_block *nb,
> 				unsigned long event, void *__dev)
> {
> 	struct device *dev = __dev;
> 
> 	if ((event == BUS_NOTIFY_BOUND_DRIVER) && (dev == (the-regulator))) {
> 		register-the-remaining-devices();
> 		return NOTIFY_STOP;
> 	};
> 	return NOTIFY_DONE;
> }
> 
> static struct notifier_block tnetv107x_spi_nb = {
> 	.notifier_call = tnetv107x_spi_notifier_call,
> };
> 
> and then in the device registration code, before registering the
> regulator:
> 
> 	bus_register_notifier(&spi_bus_type, &tnetv107x_spi_nb);
> 
> Let me know if you have any trouble.

The ability to wait on multiple devices may come handy.  In this
particular case the backlight driver depends on both ssp-gpio and
regulator devices.  Ideally, boards should be able to do something like...

platform_device_register_after(&backlight_device, "spi1.0");
platform_device_register_after(&backlight_device, "ti-ssp-gpio.0");

... and the device should get automatically registered once its
dependencies have been met.


Crude and incomplete code follows:

struct platform_device_depend {
	struct list_head node;
	const char *dev_name;
	struct platform_device *pdev;
};

LIST_HEAD(platform_device_depend);

static int platform_device_register_after(struct platform_device *pdev,
					  const char *dev_name)
{
	struct platform_device_depend *dep;

	dep = kzalloc(sizeof(*dep), GFP_KERNEL);
	if (!dep)
		return -ENOMEM;
	dep->dev_name = dev_name;
	dep->pdev = pdev;
	list_add_tail(&dep->node, &platform_device_depend);
	return 0;
}

static int platform_device_try_register(struct platform_device *pdev)
{
	struct platform_device_depend *dep;

	list_for_each_entry(dep, &platform_device_depend, node) {
		if (dep->pdev == pdev)
			return -EBUSY;
	}
	return platform_device_register(pdev);
}

static int bus_notifier_func(struct notifier_block *nb,
			     unsigned long event, void *__dev)
{
	struct platform_device_depend *dep, *tmp;
	struct device *dev = __dev;

	if (event != BUS_NOTIFY_BOUND_DRIVER)
		return NOTIFY_DONE;

	list_for_each_entry_safe(dep, tmp, &platform_device_depend,
				 node) {
		if (strcmp(dep->dev_name, dev_name(dev)) != 0)
			continue;
		list_del(&dep->node);
		platform_device_try_register(dep->pdev);
		kfree(dep);
	}

	return NOTIFY_OK;
}

Regards
Cyril.
