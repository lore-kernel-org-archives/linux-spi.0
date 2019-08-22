From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH spi for-5.4 0/5] Deterministic SPI latency with NXP DSPI
 driver
Date: Thu, 22 Aug 2019 07:16:41 -0700
Message-ID: <20190822141641.GB1437@localhost>
References: <20190818182600.3047-1-olteanv@gmail.com>
 <CA+h21hr4UcoJK7upNJjG0ibtX7CkF=akxVdrb--1AJn6-z=sUQ@mail.gmail.com>
 <20190821043845.GB1332@localhost>
 <20190821140815.GA1447@localhost>
 <CA+h21hrtzU1XL-0m+BG5TYZvVh8WN6hgcM7CV5taHyq2MsR5dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
        Hubert Feurstein <h.feurstein@gmail.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hrtzU1XL-0m+BG5TYZvVh8WN6hgcM7CV5taHyq2MsR5dw@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 21, 2019 at 11:17:23PM +0300, Vladimir Oltean wrote:
> Of course PPS with a dedicated hardware receiver that can take input
> compare timestamps is always preferable. However non-Ethernet
> synchronization in the field looks to me like "make do with whatever
> you can". I'm not sure a plain GPIO that raises an interrupt is better
> than an interrupt-driven serial protocol controller - it's (mostly)
> the interrupts that throw off the precision of the software timestamp.
> And use Miroslav's pps-gpio-poll module and you're back from where you
> started (try to make a sw timestamp as precise as possible).

Right, it might be better, might not.  You can consider hacking a
local time stamp into the ISR.  Also, if one of your MACs has a input
event pin, you can feed the switch's PPS output in there.

> wouldn't be my first choice. But DSA could have that built-in, and
> with the added latency benefit of a MAC-to-MAC connection.
> Too bad the mv88e6xxx driver can't do loopback timestamping, that's
> already 50% of the DSA drivers that support PTP at all. An embedded
> solution for this is less compelling now.

Let me back track on my statement about mv88e6xxx.  At the time, I
didn't see any practical way to use the CPU port for synchronization,
but I forget exactly the details.  Maybe it is indeed possible,
somehow.  If you can find a way that will work on your switch and on
the Marvell, then I'd like to hear about it.

Thinking back...

One problem is this.  PTP requires a delay measurement.  You can send
a delay request from the host, but there will never be a reply.

Another problem is this.  A Sync message arriving on an external port
is time stamped there, but then it is encapsulated as a tagged DSA
management message and delivered out the CPU port.  At this point, it
is no longer a PTP frame and will not be time stamped at the CPU port
on egress.

Thanks,
Richard
