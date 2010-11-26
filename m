From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [sodaville] [PATCH 1/9] spi/pxa2xx: don't use subys initcall
	for driver init
Date: Fri, 26 Nov 2010 14:29:16 +0100
Message-ID: <4CEFB62C.6020508@linutronix.de>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
	<1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
	<AANLkTin4vh85XRkEd7YocCmKngViR_qZDe7z1b4JXyd-@mail.gmail.com>
	<4CED1C95.8070300@linutronix.de>
	<20101124141623.GH24970@rakim.wolfsonmicro.main>
	<4CED3199.2040700@linutronix.de>
	<20101125235415.GA9310@n2100.arm.linux.org.uk>
	<20101126105028.GA24010@www.tglx.de>
	<20101126110605.GI9310@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101126110605.GI9310-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Russell King - ARM Linux wrote:
> On Fri, Nov 26, 2010 at 11:50:28AM +0100, Sebastian Andrzej Siewior wrote:
>> * Russell King - ARM Linux | 2010-11-25 23:54:15 [+0000]:
>>
>>> Why should the PXA code change when you haven't explained _why_ you want
>>> to change the SPI driver to conform to your idea?
>> The problem was, that the platform driver never got probed after I
>> registered the PCI driver. For that reason I made the patch attached. It
>> got lost while moving the tree forward and I did not notice it earlier.
>> While at it, I changed the subsys_init to module_init because it looked
>> wrong. At this time I was also thinking about using one module for the
>> platform and PCI code but never got to it.
> 
> This is one of the problems of the foo_driver_probe() idea - if the
> device is not present at the time the driver is registered, then the
> driver loses out completely.
> 
> This would seem to be exagerated as you're creating this platform device
> from a PCI device - who's to say that someone won't unbind the PCI device
> and re-bind it later, causing the platform device to be deleted and
> re-created?

Unbinding a PCI device should call ->remove of the pci driver and this in
turn will remove the platform device which calls ->remove of the driver.

> As such, I think the patch you've shown in this email is more appropriate
> (getting rid of the platform_driver_probe()) than trying to sort out
> init-level dependencies.  Really, the init-level dependencies in this case
> are not the problem - the use of platform_driver_probe() is.

Okay. So I leave as it.

Sebastian

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
