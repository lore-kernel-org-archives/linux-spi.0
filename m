From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: Applied "spi: Add QuadSPI driver for Atmel SAMA5D2" to the spi
 tree
Date: Thu, 8 Nov 2018 09:50:22 +0100
Message-ID: <20181108095022.66ad3ad1@bbrezillon>
References: <20181105103625.9644-6-bugalski.piotr@gmail.com>
        <20181107150327.B6DC41124E14@debutante.sirena.org.uk>
        <20181107151836.GB6809@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Piotr Bugalski <bugalski.piotr@gmail.com>,
        linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107151836.GB6809@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Wed, 7 Nov 2018 15:18:36 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Nov 07, 2018 at 03:03:27PM +0000, Mark Brown wrote:
> > The patch
> > 
> >    spi: Add QuadSPI driver for Atmel SAMA5D2
> > 
> > has been applied to the spi tree at
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git   
> 
> Sorry, I got confused about which patch series Boris had asked me to
> apply for him - it wasn't this one!  Since the review looked like it was
> just one minor issue last time I'll just leave them for now, they were
> applied on a separate branch for sharing with the MTD tree so it's easy
> for me to drop them if that's required or if I should put together the
> pull request for MTD.  Sorry for any confusion this ends up causing,
> it's entirely my mistake.

I'm probably missing something, but I don't see where you made a
mistake :-). It's indeed the series I asked you to merge, the only
comment I had was actually a suggestion to help Piotr solve his perf
issue (which was already present in the old driver).

And thanks for creating the mtd topic branch BTW.

Regards,

Boris
