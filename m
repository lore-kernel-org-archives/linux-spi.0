From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [RESEND][PATCH 0/2] McSPI Slave and DMA , FIFO support
Date: Thu, 27 Aug 2009 22:42:20 -0700
Message-ID: <200908272242.20636.david-b@pacbell.net>
References: <42120.10.24.255.18.1245765231.squirrel@dbdmail.itg.ti.com> <200907021705.18048.david-b@pacbell.net> <007b01c9fe05$9e5baeb0$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Hemanth V" <hemanthv@ti.com>, linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <007b01c9fe05$9e5baeb0$LocalHost@wipultra793>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sunday 05 July 2009, Hemanth V wrote:
> Do you see any major changes required to support
> slave mode in the SPI core driver.

There *is* no such thing as a "SPI core driver"...


> We are able to 
> use the existing interface for slave mode also, but
> some APIs/ Structures could be made generic.

Three things are obvious:

 - A spi_master is not a slave side driver!

 - Control model would need to be inverted
    * Chip select would be one input,
      not N outputs
    * No clock rate controls at all
    * latency issues ... driver can't necessarily
      respond quickly enough to guarantee no data
      loss (FIFOs help)
    * Can't re-use /dev/spidev*
    * Request queue would have a very different role

 - Some primitives are likely missing, for flow
   control (when hardware has a READY handshake)

I think a few proposals for how to handle slave
side have been circulated.


