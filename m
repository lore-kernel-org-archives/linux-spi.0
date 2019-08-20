From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH spi for-5.4 0/5] Deterministic SPI latency with NXP DSPI
 driver
Date: Tue, 20 Aug 2019 18:57:29 +0200
Message-ID: <20190820165729.GQ29991@lunn.ch>
References: <20190818182600.3047-1-olteanv@gmail.com>
 <CA+h21hr4UcoJK7upNJjG0ibtX7CkF=akxVdrb--1AJn6-z=sUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
        Hubert Feurstein <h.feurstein@gmail.com>, mlichvar@redhat.com,
        Richard Cochran <richardcochran@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hr4UcoJK7upNJjG0ibtX7CkF=akxVdrb--1AJn6-z=sUQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> - Ethernet has support for hardware timestamping

True, but not all drivers support it.

Marvell switches are often combined with Marvell MACs. None of the
Marvell MAC drivers, mv643xx, mvneta, mvpp2 or octeontx2 support
hardware timestamping. My guess is, the hardware probably supports it,
but nobody has taken the time to writing the driver code. FEC does
have PTP support, but what does it look like in general? Are Marvell
drives the exception, or the norm?

What we have been talking about in this thread, adding timestamp calls
at various places, is simple, compared to adding driver code to a
number of MAC drivers. We can get a lot of 'bang for our buck' with
time stamps, it is easy to copy to other drivers, you don't need a
good knowledge of the hardware, datasheet, etc.

So if we can get this accepted, we should try to do it. You can always
come back later and add your full hardware solution.

   Andrew
