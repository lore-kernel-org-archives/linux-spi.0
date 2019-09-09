From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH v2 0/4] Deterministic SPI latency with NXP DSPI driver
Date: Mon, 9 Sep 2019 15:08:26 +0100
Message-ID: <CA+h21hocjvF_-cvGEgank3_tgVBfCQLtp2seLguOCp0S=cx9Jw@mail.gmail.com>
References: <20190905010114.26718-1-olteanv@gmail.com> <20190909100618.GC2036@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-spi@vger.kernel.org, netdev@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190909100618.GC2036@sirena.org.uk>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On 09/09/2019, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Sep 05, 2019 at 04:01:10AM +0300, Vladimir Oltean wrote:
>
>> This patchset proposes an interface from the SPI subsystem for
>> software timestamping SPI transfers. There is a default implementation
>> provided in the core, as well as a mechanism for SPI slave drivers to
>> check which byte was in fact timestamped post-facto. The patchset also
>> adds the first user of this interface (the NXP DSPI driver in TCFQ mode).
>
> I think this is about as good as we're going to get but we're
> very near the merge window now so I'll leave this until after the
> merge window is done in case there's more review comments before
> applying.  I need to reread the implementation code a bit as
> well, it looked fine on a first scan through but it's possible I
> might spot something later.
>

There's one thing I still don't like, and that is the fact that the
delay for sending one SPI word is so low, I can't actually capture it
precisely with a "pre" and a "post" system clock timestamp. What
actually happens is that I'm actually measuring the timing of the (too
loose) CPU loop. Normally that's not bad, because the guarantee that
the transfer happened between "pre" and "post" is still kept. But I'm
introducing a false jitter in the delays I'm reporting ("post" -
"pre") that does not actually depend upon the hardware phenomenon, but
on the CPU frequency :) At maximum CPU frequency (performance
governor) the reported latency is always constant, but still larger
than the SPI transfer time. In fact it's constant exactly _because_
the CPU frequency is constant. When the CPU goes at lower frequencies,
user space gets confused about the varying delay and my control loop
doesn't keep lock as well.
So in fact I wonder whether I'm using the PTP system timestamping API
properly. One idea I had was to just timestamp the write to the TX
FIFO, and add a constant delay based on bytes_per_word * (NSEC_PER_SEC
/ speed_hz). IMHO that correction should logically be applied to both
"pre" and "post". Then say that the "post" is equal to the "pre". But
that would mean I'm reporting a delay of zero, and losing the
guarantee that the transfer actually happens between the reported
"pre" and "post". On the other hand, introducing a static correction
option could potentially help with the drivers that just get notified
of a DMA completion.
The other idea was to just push the PTP system timestamping all the
way into regmap_write, and just minimize the governor effect by making
sure the timestamped area of code is really short. I don't really
know.
