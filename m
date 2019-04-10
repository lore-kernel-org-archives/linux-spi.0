From: Flavio Suligoi <f.suligoi@asem.it>
Subject: RE: [PATCH 1/1] spi: pxa2xx: add driver enabling message
Date: Wed, 10 Apr 2019 12:01:15 +0000
Message-ID: <6953cafeb6bc4367842f37f567bb893f@asem.it>
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
 <20190410103250.GF6106@sirena.org.uk>
 <a7237e949bb643d5b49ccc5ae241bbb9@asem.it>
 <20190410115431.GO6106@sirena.org.uk>
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
In-Reply-To: <20190410115431.GO6106@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> On Wed, Apr 10, 2019 at 11:47:43AM +0000, Flavio Suligoi wrote:
> 
> > You have right about to avoid too many boot messages,
> > but in this case, using an x86 machine and with
> > the spi-pxa2xx in DMA mode, so without the message:
> 
> > "no DMA channels available, using PIO",
> 
> > there is absolutely no indication about the existence
> > of the SPI master controller.
> 
> It's totally fine to not have a boot print for the device, the best way
> to find devices if you need them is to look in sysfs anyway.

Ok
 
> > The second reason is about the DMA/PIO mode indication.
> > With the board I'm using, sometimes the spi-pxa2xx driver can't allocate
> > a DMA channel and works in PIO mode.
> 
> > So, with the advice of Jarkko, I think that a valid solution could be:
> 
> > 1) remove the "no DMA channels available, using PIO" message
> > 2) add a new message with the indications of:
> > 	- controller mode (slave or master)
> > 	- transfer mode (DMA or PIO)
> 
> > What do you think about this?
> 
> If the system is randomly failing to assign a DMA channel when it should
> then shouldn't we just fix that?  A print which is presumably intended
> to prompt the user to reboot to try to get things working doesn't seem
> like a good solution.

Right, I'm just fix the DMA problem (I'm preparing a patch about this)

Flavio
