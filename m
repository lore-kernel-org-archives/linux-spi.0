From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH spi for-5.4 0/5] Deterministic SPI latency with NXP DSPI
 driver
Date: Wed, 21 Aug 2019 07:08:15 -0700
Message-ID: <20190821140815.GA1447@localhost>
References: <20190818182600.3047-1-olteanv@gmail.com>
 <CA+h21hr4UcoJK7upNJjG0ibtX7CkF=akxVdrb--1AJn6-z=sUQ@mail.gmail.com>
 <20190821043845.GB1332@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
        Hubert Feurstein <h.feurstein@gmail.com>, mlichvar@redhat.com,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190821043845.GB1332@localhost>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Aug 20, 2019 at 09:38:45PM -0700, Richard Cochran wrote:
> Overall, the PTP switch use case is well supported by Linux.  The
> synchronization of the management CPU to the PTP, while nice to have,
> is not required to implement a Transparent Clock.  Your specific
> application might require it, but honestly, if the management CPU
> needs good synchronization, then you really aught to feed a PPS from
> the switch into a gpio (for example) on the CPU.

Another way to achieve this is to have a second MAC interface on the
management CPU connected to a spare port on the switch.  Then time
stamping, PHC, ptp4l, and phc2sys work as expected.

Thanks,
Richard
