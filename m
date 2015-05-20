From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 0/3] Using SPI NOR flah on sunxi.
Date: Wed, 20 May 2015 16:54:47 -0700
Message-ID: <20150520235447.GZ11598@ld-irv-0074>
References: <cover.1430403750.git.hramrach@gmail.com>
 <OF23B05612.4290AF80-ONC1257E37.00589292-C1257E37.005AB106@rohde-schwarz.com>
 <CAOMqctRLnCJfVCYGjsmhORYNk+HCf07wwSXnZv4oqDxbaQqKGw@mail.gmail.com>
 <201504302034.36753.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Suchanek <hramrach@gmail.com>,
	Thomas.Betker@rohde-schwarz.com,
	Alison Chaiken <alison_chaiken@mentor.com>,
	Huang Shijie <b32955@freescale.com>,
	"Bean Huo ????????? (beanhuo)" <beanhuo@micron.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	devicetree <devicetree@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Kumar Gala <galak@codeaurora.org>,
	"grmoore@altera.com" <grmoore@altera.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mtd@lists.infradead.org,
	linux-mtd <linux-mtd-bounces@lists.infradead.org>,
	linux-sunxi <linux-sunxi@googlegroups.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Rafa?? Mi??ecki <zajec5@gmail.com>, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.o
To: Marek Vasut <marex@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201504302034.36753.marex@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Apr 30, 2015 at 08:34:36PM +0200, Marek Vasut wrote:
> On Thursday, April 30, 2015 at 06:56:18 PM, Michal Suchanek wrote:
> > On 30 April 2015 at 18:30,  <Thomas.Betker@rohde-schwarz.com> wrote:
> > > Hello Michal:
> > >> I tried to connect a SPI NOR flash to my sunxi board and due to the
> > > 
> > > current
> > > 
> > >> sunxi SPI driver limitations it does not work.
> > >> 
> > >> The SPI driver returns an error when more than 64 bytes are
> > >> transferred at once
> > >> due to lack of DMA support.
> > > 
> > > Wouldn't it be easier to fix the SPI driver to handle transfers larger
> > > than 64 bytes, filling and draining the FIFO multiple times if
> > > neccessary? (As far as I can tell, most SPI drivers do this.)
> > 
> > Yes, the intent is to fix this by adding dma support to the driver,
> > eventually.
> > 
> > The patch might be still useful for other hardware with developing SPI
> > support.
> 
> Please just fix the controller driver to correctly handle arbitrary transfer
> lengths.

Just noticed this. Yes, that would definitely be a better option!

Brian
