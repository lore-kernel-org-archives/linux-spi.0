From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH spi for-5.4 0/5] Deterministic SPI latency with NXP DSPI
 driver
Date: Tue, 20 Aug 2019 21:38:45 -0700
Message-ID: <20190821043845.GB1332@localhost>
References: <20190818182600.3047-1-olteanv@gmail.com>
 <CA+h21hr4UcoJK7upNJjG0ibtX7CkF=akxVdrb--1AJn6-z=sUQ@mail.gmail.com>
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
In-Reply-To: <CA+h21hr4UcoJK7upNJjG0ibtX7CkF=akxVdrb--1AJn6-z=sUQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Aug 20, 2019 at 06:57:10PM +0300, Vladimir Oltean wrote:
> What if all we need is just a mini-"phc2sys-over-Ethernet" that runs
> on a kernel thread internally to DSA? We say that DSA switches are
> "slave" to the "master" netdevice - their PTP clock can be the same.
> I am fairly confident that the sja1105 at least can be configured in
> hardware to work in this mode. One just needs to enable the CPU port
> in its own reachability matrix. None of the switch ports is really a
> "CPU port" hardware speaking.

I did consider this method when working on an early version of the
marvell driver.  At least for that chip, there was no way to get the
time stamps on the port attached to the CPU port.

The DSA system (as I understand it) does not allow using the Linux
interface acting as the CPU port in a way that would allow taking time
stamps with the existing code base.  You might find a way, but I guess
it won't be easy.

Overall, the PTP switch use case is well supported by Linux.  The
synchronization of the management CPU to the PTP, while nice to have,
is not required to implement a Transparent Clock.  Your specific
application might require it, but honestly, if the management CPU
needs good synchronization, then you really aught to feed a PPS from
the switch into a gpio (for example) on the CPU.

Using SPI or MDIO or I2C or UART as a synchronization bus is not a
wise solution.

Having said that, I don't oppose improving the situation for these
slow, non-deterministic serial buses, but you will have to sell your
solution to the maintainers of said buses.

Thanks,
Richard
