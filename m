From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Date: Tue, 15 Jan 2019 14:26:02 +0000
Message-ID: <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
To: Martin Sperl <kernel@martin.sperl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Martin,

On 14/01/2019 22:01, Martin Sperl wrote:
> Hi Jon,
>=20
> On 14.01.2019, at 16:35, Jon Hunter <jonathanh@nvidia.com
> <mailto:jonathanh@nvidia.com>> wrote:
>=20
>> Hi Martin, Mark,
>>
>> [ =C2=A0=C2=A058.222033] spi_master spi1: could not stop message queue
>> [ =C2=A0=C2=A058.222038] spi_master spi1: queue stop failed
>> [ =C2=A0=C2=A058.222048] dpm_run_callback(): platform_pm_suspend+0x0/0x5=
4
>> returns -16
>> [ =C2=A0=C2=A058.222052] PM: Device 7000da00.spi failed to suspend: erro=
r -16
>> [ =C2=A0=C2=A058.222057] PM: Some devices failed to suspend, or early wa=
ke event
>> detected
>=20
> Unfortunately I have not been able to reproduce this in=C2=A0
> my test cases=C2=A0with the hw available to me.

Looking at both boards that fail, tegra30-cardhu-a04 and
tegra124-jetson-tk1 they both have a spi-flash. The compatible strings
for the spi flashes are "winbond,w25q32" and "winbond,w25q32dw",
respectively which interestingly are not documented/used anywhere in the
kernel. It appears that there was a patch to fix this a few years back
but never got applied [0]. However, applying this patch does not fix the
issue. Furthermore, without this patch applied I see that the spi flash
is detected fine ...

[    2.540395] m25p80 spi1.0: w25q32dw (4096 Kbytes)

So this is not related but the main point is occurs with a spi flash device=
.

> Looks as if there is something missing in=C2=A0spi_stop_queue that=C2=A0
> would wake the worker thread one last time without any delays
> and finish the hw shutdown immediately - it runs as a delayed
> task...
>=20
> One question: do you run any spi transfers in
> your test case before suspend?

No and before suspending I dumped some of the spi stats and I see no
tranfers/messages at all ...

Stats for spi1 ...
Bytes: 0
Errors: 0
Messages: 0
Transfers: 0

> /sys/class/spi_master/spi1/statistics/messages=C2=A0gives some
> counters=C2=A0on the number=C2=A0of spi messages processed which
> would give you an=C2=A0indication if that is happening.
>=20
> It could be as easy as adding right after the first lock=C2=A0
> in spi_stop_queue:
> kthread_mod_delayed_work(&ctlr->kworker,
> =C2=A0&ctlr->pump_idle_teardown, 0);
> (plus maybe a yield or similar to allow the worker to=C2=A0
> quickly/reliably=C2=A0run on a single core machine)
>=20
> I hope that this initial guess helps.

Unfortunately, the above did not help and the issue persists.

Digging a bit deeper I see that now the 'ctlr->queue' is empty but
'ctlr->busy' flag is set and this is causing the 'could not stop message
queue' error.

It seems that __spi_pump_messages() is getting called several times
during boot when registering the spi-flash, then after the spi-flash has
been registered, about a 1 sec later spi_pump_idle_teardown() is called
(as expected), but exits because 'ctlr->running' is true. However,
spi_pump_idle_teardown() is never called again and when we suspend we
are stuck in the busy/running state. In this case should something be
scheduling spi_pump_idle_teardown() again? Although even if it does I
don't see where the busy flag would be cleared in this path?

Cheers
Jon


[0] https://patchwork.kernel.org/patch/7021961/
--=20
nvpublic
