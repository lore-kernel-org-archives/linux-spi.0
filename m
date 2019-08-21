From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH spi for-5.4 0/5] Deterministic SPI latency with NXP DSPI driver
Date: Wed, 21 Aug 2019 23:17:23 +0300
Message-ID: <CA+h21hrtzU1XL-0m+BG5TYZvVh8WN6hgcM7CV5taHyq2MsR5dw@mail.gmail.com>
References: <20190818182600.3047-1-olteanv@gmail.com> <CA+h21hr4UcoJK7upNJjG0ibtX7CkF=akxVdrb--1AJn6-z=sUQ@mail.gmail.com>
 <20190821043845.GB1332@localhost> <20190821140815.GA1447@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Hubert Feurstein <h.feurstein@gmail.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190821140815.GA1447@localhost>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Richard,

On Wed, 21 Aug 2019 at 17:08, Richard Cochran <richardcochran@gmail.com> wrote:
>
> On Tue, Aug 20, 2019 at 09:38:45PM -0700, Richard Cochran wrote:
> > Overall, the PTP switch use case is well supported by Linux.  The
> > synchronization of the management CPU to the PTP, while nice to have,
> > is not required to implement a Transparent Clock.  Your specific
> > application might require it, but honestly, if the management CPU
> > needs good synchronization, then you really aught to feed a PPS from
> > the switch into a gpio (for example) on the CPU.
>
> Another way to achieve this is to have a second MAC interface on the
> management CPU connected to a spare port on the switch.  Then time
> stamping, PHC, ptp4l, and phc2sys work as expected.
>
> Thanks,
> Richard

Of course PPS with a dedicated hardware receiver that can take input
compare timestamps is always preferable. However non-Ethernet
synchronization in the field looks to me like "make do with whatever
you can". I'm not sure a plain GPIO that raises an interrupt is better
than an interrupt-driven serial protocol controller - it's (mostly)
the interrupts that throw off the precision of the software timestamp.
And use Miroslav's pps-gpio-poll module and you're back from where you
started (try to make a sw timestamp as precise as possible).
As for dedicating a second interface pair in (basically) loopback just
for sync, that's how I'm testing PTP when I don't have a second board
and hence how the idea occurred to me. I can imagine this even getting
deployed and I can also probably name an example, but it certainly
wouldn't be my first choice. But DSA could have that built-in, and
with the added latency benefit of a MAC-to-MAC connection.
Too bad the mv88e6xxx driver can't do loopback timestamping, that's
already 50% of the DSA drivers that support PTP at all. An embedded
solution for this is less compelling now.

Regards,
-Vladimir
