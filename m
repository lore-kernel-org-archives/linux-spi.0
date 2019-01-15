From: kernel@martin.sperl.org
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync instead run teardown delayed
Date: Tue, 15 Jan 2019 18:39:27 +0100
Message-ID: <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com> <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org> <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Mark Brown <broonie@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi John!

> On 15.01.2019, at 15:26, Jon Hunter <jonathanh@nvidia.com> wrote:
>> Looks as if there is something missing in spi_stop_queue that 
>> would wake the worker thread one last time without any delays
>> and finish the hw shutdown immediately - it runs as a delayed
>> task...
>> 
>> One question: do you run any spi transfers in
>> your test case before suspend?
> 
> No and before suspending I dumped some of the spi stats and I see no
> tranfers/messages at all ...
> 
> Stats for spi1 ...
> Bytes: 0
> Errors: 0
> Messages: 0
> Transfers: 0

This...

>> /sys/class/spi_master/spi1/statistics/messages gives some
>> counters on the number of spi messages processed which
>> would give you an indication if that is happening.
>> 
>> It could be as easy as adding right after the first lock 
>> in spi_stop_queue:
>> kthread_mod_delayed_work(&ctlr->kworker,
>>  &ctlr->pump_idle_teardown, 0);
>> (plus maybe a yield or similar to allow the worker to 
>> quickly/reliably run on a single core machine)
>> 
>> I hope that this initial guess helps.
> 
> Unfortunately, the above did not help and the issue persists.
> 
> Digging a bit deeper I see that now the 'ctlr->queue' is empty but
> 'ctlr->busy' flag is set and this is causing the 'could not stop message
> queue' error.
> 
> It seems that __spi_pump_messages() is getting called several times
> during boot when registering the spi-flash, then after the spi-flash has
> been registered, about a 1 sec later spi_pump_idle_teardown() is called
> (as expected), but exits because 'ctlr->running' is true. However,

and this contradicts each other!
If there is a call to message pump, then we should process a message
and the counters should increase.

If those counters do not increase then there is something strange.

If we are called without anything to do then the pump should trigger a
tear down and stop.

> spi_pump_idle_teardown() is never called again and when we suspend we
> are stuck in the busy/running state. In this case should something be
> scheduling spi_pump_idle_teardown() again? Although even if it does I
> don't see where the busy flag would be cleared in this path?
> 

I am wondering where busy/running would be set in the first place
if there are no counters...

Is it possible that the specific flash is not using the “normal” 
spi_pump_message, but spi_controller_mem_ops operations? 

Maybe we are missing the teardown in that driver or something is
changing flags there.

grepping a bit:

I see spi_mem_access_start calling spi_flush_queue, which is calling
pump_message, which - if there is no transfer - will trigger a delayed
tear-down, while it maybe should not be doing that.

Maybe spi_mem_access_end needs a call to spi_flush_queue as well?

Unfortunately this is theoretical work and quite a lot of guesswork
without an actual device available for testing...

Thanks,
	Martin
