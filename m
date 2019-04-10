From: Flavio Suligoi <f.suligoi@asem.it>
Subject: RE: [PATCH 1/1] spi: pxa2xx: add driver enabling message
Date: Wed, 10 Apr 2019 11:47:43 +0000
Message-ID: <a7237e949bb643d5b49ccc5ae241bbb9@asem.it>
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
 <20190410103250.GF6106@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410103250.GF6106@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

> On Mon, Apr 08, 2019 at 05:22:44PM +0200, Flavio Suligoi wrote:
> > Add an info message for the PXA2xx device driver start-up,
> > with the indication of the transfer mode used (DMA or GPIO).
> >
> > This info is useful to individuate the timing when
> > the module starts.
> 
> Adding this sort of message to every driver is going to make boot far
> too noisy, it's one thing if we actually enumerate information about the
> physical device but this isn't really that.  There are already prints in
> the driver core for when things get probed which can be enabled if
> ordering issues need to be debugged.

You have right about to avoid too many boot messages,
but in this case, using an x86 machine and with
the spi-pxa2xx in DMA mode, so without the message: 

"no DMA channels available, using PIO",

there is absolutely no indication about the existence
of the SPI master controller.

This is the first reason for this patch.
The second reason is about the DMA/PIO mode indication. 
With the board I'm using, sometimes the spi-pxa2xx driver can't allocate
a DMA channel and works in PIO mode.

So, with the advice of Jarkko, I think that a valid solution could be:

1) remove the "no DMA channels available, using PIO" message
2) add a new message with the indications of:
	- controller mode (slave or master)
	- transfer mode (DMA or PIO)

What do you think about this?

Flavio
