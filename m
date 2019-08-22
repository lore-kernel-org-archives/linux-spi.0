From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH spi for-5.4 0/5] Deterministic SPI latency with NXP DSPI
 driver
Date: Thu, 22 Aug 2019 09:05:21 -0700
Message-ID: <20190822160521.GC4522@localhost>
References: <20190818182600.3047-1-olteanv@gmail.com>
 <CA+h21hr4UcoJK7upNJjG0ibtX7CkF=akxVdrb--1AJn6-z=sUQ@mail.gmail.com>
 <20190821043845.GB1332@localhost>
 <20190821140815.GA1447@localhost>
 <CA+h21hrtzU1XL-0m+BG5TYZvVh8WN6hgcM7CV5taHyq2MsR5dw@mail.gmail.com>
 <20190822141641.GB1437@localhost>
 <CA+h21hpJm-3svfV93pYYrpoiV12jDjuROHCgvCjPivAjXTB_VA@mail.gmail.com>
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
In-Reply-To: <CA+h21hpJm-3svfV93pYYrpoiV12jDjuROHCgvCjPivAjXTB_VA@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 22, 2019 at 05:58:49PM +0300, Vladimir Oltean wrote:
> I don't think I understand the problem here.

On the contrary, I do.

> You'd have something like this:
> 
> Master (DSA master port)         Slave (switch CPU port)
> 
>     |                            |         Tstamps known
>     |                            |         to slave
>     |       Local_sync_req       |
>  t1 |------\                     |         t1
>     |       \-----\              |
>     |              \-----\       |
>     |                     \----->| t2      t1, t2
>     |                            |
>     |     Local_sync_resp /------| t3      t1, t2, t3
>     |              /-----/       |
>     |       /-----/              |
>  t4 |<-----/                     |         t1, t2, t3, t4
>     |                            |
>     |                            |
>     v           time             v

And who generates Local_sync_resp?

Also, what sort of frame is it?  PTP has no Sync request or response.

> But you don't mean a TX timestamp at the egress of swp4 here, do you?

Yes, I do.
 
> Why would that matter?

Because in order to synchronize to an external GM, you need to measure
two things:

1. the (unchanging) delay from MAC to MAC
2. the (per-packet) switch residence time

Thanks,
Richard
