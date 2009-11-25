From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC] two new linux-next trees (SPI and devicetree)
Date: Tue, 24 Nov 2009 18:11:39 -0800
Message-ID: <20091124181139.b9e218ed.akpm@linux-foundation.org>
References: <fa686aa40911241654w6ceb2c96nb3a6a57ac1b471f5@mail.gmail.com>
	<20091124170419.92cb63f6.akpm@linux-foundation.org>
	<fa686aa40911241753lca699c9sa9ca0a0585a9d39d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michal Simek <michal.simek@petalogix.com>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934054AbZKYCML@vger.kernel.org>
In-Reply-To: <fa686aa40911241753lca699c9sa9ca0a0585a9d39d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 24 Nov 2009 18:53:21 -0700 Grant Likely <grant.likely@secretlab.ca> wrote:

> > My current stash:
> >
> >
> > atmel_spi-fix-dma-addr-calculation-for-len-buffer_size.patch
> > spi-controller-driver-for-designware-spi-core.patch
> > spi-add-pci-interface-driver-for-designware-spi-core.patch
> > spi-add-pci-interface-driver-for-designware-spi-core-fix.patch
> > spi-controller-driver-for-designware-spi-core-fix.patch
> > spidev-add-proper-section-markers.patch
> > spidev-use-declare_bitmap-instead-of-declaring-the-array.patch
> > spidev-use-declare_bitmap-instead-of-declaring-the-array-checkpatch-fixes.patch
> > spi-drain-mxc-spi-transfer-buffer-when-probing-device.patch
> > spi_s3c24xx-add-fiq-pseudo-dma-support.patch
> 
> Since they're already in your tree, do you mind continuing to shepherd
> these (either merge or drop)?

Sure.

> > I haven't heard anything from David in over a month.
> 
> Okay, shall I go ahead and merge my change to MAINTAINERS through my
> tree too then?

OK by me.
