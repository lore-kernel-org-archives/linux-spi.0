From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH spi for-5.4 0/5] Deterministic SPI latency with NXP DSPI
 driver
Date: Thu, 22 Aug 2019 16:56:45 +0200
Message-ID: <20190822145645.GJ13020@lunn.ch>
References: <20190818182600.3047-1-olteanv@gmail.com>
 <CA+h21hr4UcoJK7upNJjG0ibtX7CkF=akxVdrb--1AJn6-z=sUQ@mail.gmail.com>
 <20190821043845.GB1332@localhost>
 <20190821140815.GA1447@localhost>
 <CA+h21hrtzU1XL-0m+BG5TYZvVh8WN6hgcM7CV5taHyq2MsR5dw@mail.gmail.com>
 <20190822141641.GB1437@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hubert Feurstein <h.feurstein@gmail.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190822141641.GB1437@localhost>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> Thinking back...
> 
> One problem is this.  PTP requires a delay measurement.  You can send
> a delay request from the host, but there will never be a reply.
> 
> Another problem is this.  A Sync message arriving on an external port
> is time stamped there, but then it is encapsulated as a tagged DSA
> management message and delivered out the CPU port.  At this point, it
> is no longer a PTP frame and will not be time stamped at the CPU port
> on egress.

I think so that both the host interface and the CPU port recognize the
frame and time stamp it, it needs to be untagged. Otherwise, as you
said, the hardware does not recognise it. I've never tried sending
untagged frames to the CPU port. I expect they are just dropped.

However, somebody might want to play with the TCAM. The TCAM can
redirect a packet out any port. I've no idea what the pipeline
ordering is, but it might be possible for the TCAM to redirect a frame
back to the host interface, before it gets dropped because it does not
have DSA tags?  But is the TCAM before or after PTP in the pipeline?
Could you then get 4 timestamps for the same frame?  Host egress,
switch ingress, switch egress, host ingress?

But how do you make this generic? Can other switches also loop a frame
back like this and do the same time stamping? How do you actually get
access to these time stamps split over two blocks of hardware?

So in theory, this might be possible, but in practice?

     Andrew
