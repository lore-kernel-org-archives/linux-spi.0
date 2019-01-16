From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Date: Wed, 16 Jan 2019 10:58:16 +0000
Message-ID: <7ffb7c42-a7e1-edf2-2d0e-86d2240b5c9e@nvidia.com>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
To: <kernel@martin.sperl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 15/01/2019 17:39, kernel@martin.sperl.org wrote:
> Hi John!
>=20
>> On 15.01.2019, at 15:26, Jon Hunter <jonathanh@nvidia.com> wrote:
>>> Looks as if there is something missing in spi_stop_queue that=20
>>> would wake the worker thread one last time without any delays
>>> and finish the hw shutdown immediately - it runs as a delayed
>>> task...
>>>
>>> One question: do you run any spi transfers in
>>> your test case before suspend?
>>
>> No and before suspending I dumped some of the spi stats and I see no
>> tranfers/messages at all ...
>>
>> Stats for spi1 ...
>> Bytes: 0
>> Errors: 0
>> Messages: 0
>> Transfers: 0
>=20
> This...
>=20
>>> /sys/class/spi_master/spi1/statistics/messages gives some
>>> counters on the number of spi messages processed which
>>> would give you an indication if that is happening.
>>>
>>> It could be as easy as adding right after the first lock=20
>>> in spi_stop_queue:
>>> kthread_mod_delayed_work(&ctlr->kworker,
>>>  &ctlr->pump_idle_teardown, 0);
>>> (plus maybe a yield or similar to allow the worker to=20
>>> quickly/reliably run on a single core machine)
>>>
>>> I hope that this initial guess helps.
>>
>> Unfortunately, the above did not help and the issue persists.
>>
>> Digging a bit deeper I see that now the 'ctlr->queue' is empty but
>> 'ctlr->busy' flag is set and this is causing the 'could not stop message
>> queue' error.
>>
>> It seems that __spi_pump_messages() is getting called several times
>> during boot when registering the spi-flash, then after the spi-flash has
>> been registered, about a 1 sec later spi_pump_idle_teardown() is called
>> (as expected), but exits because 'ctlr->running' is true. However,
>=20
> and this contradicts each other!
> If there is a call to message pump, then we should process a message
> and the counters should increase.
>=20
> If those counters do not increase then there is something strange.

Actually no, this is nothing strange here at all. If you look Tegra has
it's own 'transfer_one_message' handler (tegra_spi_transfer_one_message
in drivers/spi/spi-tegra114.c) and this does not update any of the
statistics. Looks like the statistics are not updated if a SPI
controller has it own transfer_one_message hander which is a shame.

> If we are called without anything to do then the pump should trigger a
> tear down and stop.

>> spi_pump_idle_teardown() is never called again and when we suspend we
>> are stuck in the busy/running state. In this case should something be
>> scheduling spi_pump_idle_teardown() again? Although even if it does I
>> don't see where the busy flag would be cleared in this path?
>>
>=20
> I am wondering where busy/running would be set in the first place
> if there are no counters...

Looks like running is set true on initialising the queue and busy is set
true in __spi_pump_messages().

> Is it possible that the specific flash is not using the =E2=80=9Cnormal=
=E2=80=9D=20
> spi_pump_message, but spi_controller_mem_ops operations?=20

I definitely see __spi_pump_messages() being called which in turn calls
tegra_spi_transfer_one_message().

> Maybe we are missing the teardown in that driver or something is
> changing flags there.
>=20
> grepping a bit:
>=20
> I see spi_mem_access_start calling spi_flush_queue, which is calling
> pump_message, which - if there is no transfer - will trigger a delayed
> tear-down, while it maybe should not be doing that.
>=20
> Maybe spi_mem_access_end needs a call to spi_flush_queue as well?
>=20
> Unfortunately this is theoretical work and quite a lot of guesswork
> without an actual device available for testing...

Looking some more I think that the problem is ...

1. The controller is put into the 'running' state when spi_start_queue()
is called (which itself is called during the registration of the spi
controller).
2. After sending some messages to initialise the SPI flash,
spi_pump_idle_teardown() is called but exits early because the
controller is in the 'running' state and this prevents 'busy' from being
cleared.
3. On entering suspend spi_stop_queue() is called but the controller is
still in the 'busy' state and so fails to stop.

So the problem I see is that 'busy' is never cleared and before it was.
Furthermore, because 'busy' is never cleared, I see that the SPI
controller is never pm-runtime suspended and cannot be suspended, and so
this will have an impact on power.

With your patch after booting I see ...

$ cat /sys/class/spi_master/spi1/device/power/runtime_status
active

Reverting your patch, after booting I see ...

$ cat /sys/class/spi_master/spi1/device/power/runtime_status
suspended

Does the device you are testing with support runtime-pm? If so what do
you see?

Cheers
Jon

--=20
nvpublic
