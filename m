From: "Zhong, Huiquan" <huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] spi: fix one potential spin_lock issue
Date: Mon, 20 Apr 2015 02:54:05 +0000
Message-ID: <5C100827E7A2704FA82A3269FBF0E13CE6DB6C@shsmsx102.ccr.corp.intel.com>
References: <1429084832-8953-1-git-send-email-huiquan.zhong@intel.com>
 <20150418124914.GQ26185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150418124914.GQ26185-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Seems that issue can't reproduce in latest kernel since there is one patch (comments is 983aee5d7090cf12b624f18533777caa09d067b1) to check if the device is processing a message before idle.
So no need my patch with the latest kernel upstream. Sorry to disturb.


commit 983aee5d7090cf12b624f18533777caa09d067b1
Author: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Date:   Tue Dec 9 19:46:56 2014 +0000

    spi: Check to see if the device is processing a message before we idle

    cur_msg is updated under the queue lock and holds the message we are
    currently processing. Since currently we only ever do removals in the
    pump kthread it doesn't matter in what order we do things but we want
    to be able to push things out from the submitting thread so pull the
    check to see if we're currently handling a message before we check to
    see if the queue is idle.

Thanks,
Huiquan

-----Original Message-----
From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org] 
Sent: Saturday, April 18, 2015 8:49 PM
To: Zhong, Huiquan
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; huiquanz.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH] spi: fix one potential spin_lock issue

On Wed, Apr 15, 2015 at 04:00:32PM +0800, Huiquan Zhong wrote:
> master->pump_messages workqueue can be queued by spi_start_queue(),
> __spi_queued_transfer().
> 
> there is one case that if one resume thread call spi_start_queue(), 
> and at the same time another spi_device thread call 
> spi_queued_transfer() to do spi transfer, then the first workqueue 
> will start the spi transfer, but the next workqueue queued before SPI 
> transfer complete, will unusual terminate spi transfer.

I've applied this, it took a while mostly because it is very hard for me to understand your commit message - I'm not clear what mechanism will cause a problem for a running transfer ("unusual terminate spi transfer").  I can see we might end up with the work being added to the queue more often than is needed but not how that ends up causing anything other than a little wasted work.  

Your commit message suggests it's to do with multiple devices adding to the queue simultaneously but the queue access in __spi_queued_transfer() and __spi_pump_messages() all appears to be done with the queue lock held...

I'm still not 100% clear that this is doing anything other than making the locking a bit more consistent.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
