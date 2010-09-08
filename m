From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] spi/spi_s3c64xx: Move to subsys_initcall()
Date: Wed, 8 Sep 2010 17:55:27 +0100
Message-ID: <20100908165526.GB15562@rakim.wolfsonmicro.main>
References: <1283855357-15179-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <AANLkTim=ArPyqC7K-aaer97deGeR6yU-FS1Hpm3D_1ER@mail.gmail.com>
 <20100908091242.GB31253@rakim.wolfsonmicro.main>
 <AANLkTimvc52yXuMFN2=qLKX1MSyTum1GHnLdDW8dMR=2@mail.gmail.com>
 <20100908161245.GC3686@angua.secretlab.ca>
 <20100908162251.GA15562@rakim.wolfsonmicro.main>
 <20100908164432.GG3686@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Jassi Brar <jassi.brar@samsung.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100908164432.GG3686@angua.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 08, 2010 at 10:44:32AM -0600, Grant Likely wrote:
> On Wed, Sep 08, 2010 at 05:22:51PM +0100, Mark Brown wrote:

> > Doing dependencies could get pretty complicated, especially once you
> > handle optional dependencies ("is this missing because it didn't probe
> > yet or because it's just not there?") so it's not entirely clear to me
> > that it's worth the hassle.

> I think it might be doable.  I had a similar problem with Ethernet
> MACs and PHYs where the PHY was on a completely separate bus from the
> MAC with zero guarantees on probe order.  I had some code that made it
> simple to use a bus notifier to defer MAC initialization until the
> required phy turned up and was probed.  I eventually abandoned it
> because accessing the PHY could be deferred until .ndo_open() time.
> However, it would be easy to resurrect, and might be a reasonable
> solution.  At the very least it is worth an investigation.

If you've got stuff that'd be great - ASoC also has a deferral mechanism
implemented due to this song and dance.  Like I say, the main reason
I've never looked at it myself is that it's never been sufficiently much
of a practical problem for me to justify the effort.
