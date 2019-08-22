From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH spi for-5.4 0/5] Deterministic SPI latency with NXP DSPI driver
Date: Thu, 22 Aug 2019 19:13:12 +0300
Message-ID: <CA+h21hrELeUKbfGD3n=BL741QN9m3SaoJJ0y+q_uthdxvSFVRg@mail.gmail.com>
References: <20190818182600.3047-1-olteanv@gmail.com> <CA+h21hr4UcoJK7upNJjG0ibtX7CkF=akxVdrb--1AJn6-z=sUQ@mail.gmail.com>
 <20190821043845.GB1332@localhost> <20190821140815.GA1447@localhost>
 <CA+h21hrtzU1XL-0m+BG5TYZvVh8WN6hgcM7CV5taHyq2MsR5dw@mail.gmail.com>
 <20190822141641.GB1437@localhost> <CA+h21hpJm-3svfV93pYYrpoiV12jDjuROHCgvCjPivAjXTB_VA@mail.gmail.com>
 <20190822160521.GC4522@localhost>
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
In-Reply-To: <20190822160521.GC4522@localhost>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 22 Aug 2019 at 19:05, Richard Cochran <richardcochran@gmail.com> wrote:
>
> On Thu, Aug 22, 2019 at 05:58:49PM +0300, Vladimir Oltean wrote:
> > I don't think I understand the problem here.
>
> On the contrary, I do.
>

You do think that I understand the problem? But I don't!

> > You'd have something like this:
> >
> > Master (DSA master port)         Slave (switch CPU port)
> >
> >     |                            |         Tstamps known
> >     |                            |         to slave
> >     |       Local_sync_req       |
> >  t1 |------\                     |         t1
> >     |       \-----\              |
> >     |              \-----\       |
> >     |                     \----->| t2      t1, t2
> >     |                            |
> >     |     Local_sync_resp /------| t3      t1, t2, t3
> >     |              /-----/       |
> >     |       /-----/              |
> >  t4 |<-----/                     |         t1, t2, t3, t4
> >     |                            |
> >     |                            |
> >     v           time             v
>
> And who generates Local_sync_resp?
>

Local_sync_resp is the same as Local_sync_req except maybe with a
custom tag added by the switch. Irrelevant as long as the DSA master
can timestamp it.

> Also, what sort of frame is it?  PTP has no Sync request or response.
>

A frame that can be timestamped on RX and TX by the DSA switch and
master, that is not a PTP frame.

> > But you don't mean a TX timestamp at the egress of swp4 here, do you?
>
> Yes, I do.
>
> > Why would that matter?
>
> Because in order to synchronize to an external GM, you need to measure
> two things:
>
> 1. the (unchanging) delay from MAC to MAC
> 2. the (per-packet) switch residence time
>

But since when are we discussing the synchronization to an external
grandmaster? I don't see the connection.

> Thanks,
> Richard

Regards,
-Vladimir
