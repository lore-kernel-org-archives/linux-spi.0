From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH spi for-5.4 0/5] Deterministic SPI latency with NXP DSPI driver
Date: Sat, 24 Aug 2019 15:13:02 +0300
Message-ID: <CA+h21hpUytc2S=NmEbjDiQo4wRrKJiE5ZT+jVgCyocUb2RMYNg@mail.gmail.com>
References: <20190818182600.3047-1-olteanv@gmail.com> <CA+h21hr4UcoJK7upNJjG0ibtX7CkF=akxVdrb--1AJn6-z=sUQ@mail.gmail.com>
 <20190821043845.GB1332@localhost> <20190821140815.GA1447@localhost>
 <CA+h21hrtzU1XL-0m+BG5TYZvVh8WN6hgcM7CV5taHyq2MsR5dw@mail.gmail.com>
 <20190822141641.GB1437@localhost> <CA+h21hpJm-3svfV93pYYrpoiV12jDjuROHCgvCjPivAjXTB_VA@mail.gmail.com>
 <20190822160521.GC4522@localhost> <CA+h21hrELeUKbfGD3n=BL741QN9m3SaoJJ0y+q_uthdxvSFVRg@mail.gmail.com>
 <20190823052217.GD2502@localhost>
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
In-Reply-To: <20190823052217.GD2502@localhost>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 23 Aug 2019 at 08:22, Richard Cochran <richardcochran@gmail.com> wrote:
>
> On Thu, Aug 22, 2019 at 07:13:12PM +0300, Vladimir Oltean wrote:
> > You do think that I understand the problem? But I don't!
>
> ;^)
>
> > > And who generates Local_sync_resp?
> > >
> >
> > Local_sync_resp is the same as Local_sync_req except maybe with a
> > custom tag added by the switch. Irrelevant as long as the DSA master
> > can timestamp it.
>
> So this is point why it won't work.  The time stamping logic in the
> switch only recognizes PTP frames.
>
> Thanks,
> Richard

So to summarize the pros and cons of a PHC-to-PHC loopback sync:
Pros:
- At least two orders of magnitude improvement in offset compared to a
software timestamping solution, even in the situation where the
software timestamp is fully optimized
- Does not depend on the availability of PPS hardware
- In the case where both MACs support this, the synchronization can
simply reuse the DSA link with no dedicated circuitry
Cons:
- DSA framework for retrieving timestamps would need to be reworked
- The solution would have to be implemented in the kernel
- A separate protocol from PTP would have to be devised
- Not all DSA masters support hardware timestamping. Of those that do,
not all may support timestamping generic frames
- Not all PTP-capable DSA switches support timestamping generic frames
- Not all DSA switches may be able to loop back traffic from their CPU
port. I think this is called "hairpinning".
- The solution only covers the sync of the top-most switch in the DSA
tree. The hairpinning described above would need to be selective as
well, not just possible.

So at this point, the solution is not generic enough for me to be
compelled to prototype it. Taking system clock timestamps in the SPI
driver is "good enough". We'll just need to work out a way with Mark
that this can be added to the SPI subsystem, given the valid
objections already expressed.

Thanks,
-Vladimir
