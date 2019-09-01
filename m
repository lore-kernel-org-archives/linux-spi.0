From: Vladimir Oltean <olteanv@gmail.com>
Subject: RT and PTP system timestamping
Date: Sun, 1 Sep 2019 22:02:07 +0300
Message-ID: <CA+h21hqRFGvspMJtn1VDb_JzpRnApLSEARWPcGNvTADXCsou_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Richard Cochran <richardcochran@gmail.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Hubert Feurstein <h.feurstein@gmail.com>
To: netdev <netdev@vger.kernel.org>, linux-rt-users@vger.kernel.org,
        linux-spi@vger.kernel.org
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello people of netdev, linux-rt-users and linux-spi,

Apologies in advance for asking a question about something I know nothing about.

I am playing with a device driver of a SPI-controlled PTP timer. For
my particular application it is important that the value of the PTP
timer can be retrieved with an accuracy bound of less than +/- 400 ns.
Currently that job has been served by the PTP_SYS_OFFSET_EXTENDED [1]
ioctl (which allows for the timer's and the system's time to be
correlated) plus some hacks in the SPI core and drivers which were
submitted for review [2].

In the future I would like to evaluate RT on the device I am playing
with. There are a few dependency patches in flight and I'm not
actually clear what my current evaluation options as of now are, so I
think I'll just have to wait until 5.4-rt.
But at least I need to consider the RT friendliness of the solution I
am proposing. The gist of it (in the current version) is: put the
controller in poll mode, disable local IRQs and preemption on the
local CPU (via a spin_lock_irqsave), then surround the transfer of the
SPI byte I'm interested in with (basically) calls to
ktime_get_real_ts64.

Of course, this approach is completely incompatible with RT:
- In RT, spin_lock_irqsave does not disable IRQs and preemption. But
without those disabled, the PTP system timestamps are basically
throw-away - they should capture the most precise "before" and "after"
time of when the SPI slave device has received byte N of the transfer
(that is when it's snapshotting its timer internally). It's true that
the PTP_SYS_OFFSET_EXTENDED ioctl has a n_samples argument which can
be used in a sort of "pick shortest readout time" fashion, but there
is no guarantee that there will always be even 1 out of X readouts
that complete atomically with no preemption.
- Forcing the disabling of interrupts and preemption creates the
opportunity for unbounded latency for the other threads in the system.
- Disabling interrupts to record the before-and-after time for a TX
event would also be a contradiction in terms for SPI controllers that
don't do polling, i.e. DMA-based.
- In RT, there is no hardirq context at all given to a SPI controller driver.

The above constraints mean that the problem of timestamping byte N of
a SPI transfer is intractable from within the SPI controller driver
itself, at least with RT, as far as I can tell.
Ensuring the atomicness of one system clock readout with the SPI
transfer is hard enough I think, doing it for both the "pre" and the
"post" times is even more so. There have been discussions about only
taking one of the 2 timestamps, and deducing the other as being a
constant offset far. That is something I may be open to experiment
with, as long as there's least one place which can be timestamped,
that has a known offset relative to the hardware event (e.g. the
hardirq context - then the "pre" time can be backtraced).
I noticed the record_irq_time() function call in kernel/irq/handle.c
[3] and I do wonder whether it can be used for driver consumption?
I don't love the idea of moving the driver back to interrupt mode
though, but it's the only way I see currently. The other reason why I
put it in poll mode is that 50% of the time spent for a transfer is
simply wasted doing other stuff (an IRQ gets raised after each
transferred byte). This is secondary however.

I am looking forward to comments that will hopefully put me on the right path.

Regards,
-Vladimir

[1]: https://www.spinics.net/lists/netdev/msg532765.html
[2]: https://www.spinics.net/lists/netdev/msg593404.html
[3]: https://lwn.net/Articles/691297/
