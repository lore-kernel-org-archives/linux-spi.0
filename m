From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Thu, 17 Oct 2013 13:03:26 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA27E10@DBDE04.ent.ti.com>
References: <20131011100839.GA21581@sirena.org.uk> <525CDB77.4040201@ti.com>
 <20131015111647.GX2443@sirena.org.uk> <525D2BB3.4020705@ti.com>
 <20131015124656.GM2443@sirena.org.uk> <525D41E2.30206@ti.com>
 <20131015180142.GS23337@ld-irv-0074.broadcom.com>
 <CA+7tXigv1Q3BPE3uhzdJpx3DsqUpxzrBUaPfWR-i15PsVtMWsQ@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA23640@DBDE04.ent.ti.com>
 <525FD715.50703@ti.com> <20131017123850.GN2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Peter Korsgaard <peter@korsgaard.com>, "Balbi, Felipe" <balbi@ti.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Mark Brown <broonie@kernel.org>, "Poddar, Sourav" <sourav.poddar@ti.com>,
 Trent Piepho <tpiepho@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20131017123850.GN2443@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

> From: Mark Brown [mailto:broonie@kernel.org]
> > On Thu, Oct 17, 2013 at 05:54:53PM +0530, Sourav Poddar wrote:
> >   Setup:
> >     Here, the actual memcpy is done in the spi controller, and flash
> >     communicates to the qspi controller to do the memcpy using the
> >     SPI framework. This is what is propsed in the $subject patch.
> 
> >   Setup:
> >     Here, the actual memcpy is done in the mtd read api itself, by
> > getting the
> >     memmap address from the spi controller.
> 
> > So, time reduced almost to half while bypassing the SPI framework.
> 
> The interesting case for benchmarking here is more a comparison between
> normal DMA driven transfers and the memcpy().  Some consideration of the
> CPU load would also be interesting here, if the SoC is waiting for the
> flash then it's probably useful if it can make progress on other things.
> 
So in this CASE-2:  SPI framework is bypassed: mtd_read() becomes
mtd_read() {
	if (flash->mmap_mode)
		if (dma_available)
			read_via_dma(destination, source, length);
		else
			memcpy(destination, source, length);
	else
		/* use spi frame-work by default */
}

Are you looking for comparison between  read_via_dma() v/s memcpy() ?

If yes, then unfortunately we are bit constrained because our controller
does not support DMA. So, we have to depend on CPU based memcpy()
only. However, use of DMA can be added as an independent patch on
top of this CASE-2 patch.

So will the base patch for CASE-2  (with SPI framework is bypassed) help ?


with regards, pekon

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
