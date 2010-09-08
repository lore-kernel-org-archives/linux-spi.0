From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] spi/spi_s3c64xx: Move to subsys_initcall()
Date: Wed, 8 Sep 2010 17:22:51 +0100
Message-ID: <20100908162251.GA15562@rakim.wolfsonmicro.main>
References: <1283855357-15179-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <AANLkTim=ArPyqC7K-aaer97deGeR6yU-FS1Hpm3D_1ER@mail.gmail.com>
 <20100908091242.GB31253@rakim.wolfsonmicro.main>
 <AANLkTimvc52yXuMFN2=qLKX1MSyTum1GHnLdDW8dMR=2@mail.gmail.com>
 <20100908161245.GC3686@angua.secretlab.ca>
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
In-Reply-To: <20100908161245.GC3686@angua.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 08, 2010 at 10:12:45AM -0600, Grant Likely wrote:

[reflowed into 80 columns]

> ... but it seems to me that there is a systemic problem in the way the
> driver model is being used if SPI (and I2C) bus drivers need to be
> 'special' in this regard.  What are the ordering requirements on things
> like PMICs?  (My uneducated assumption is that other devices depend on
> them being enabled before being probed.)  Would it be better to have a

Pretty much this, yes - if you might want to turn on your supplies
when you're probed it's rather helpful if the subsystem needed to
control the regulators is available when you probe.

> mechanism to defer probing on certain devices until other devices are
> probed?  Then the relationships could be made explicit instead of the
> rather coarse-grained (and potentially fragile) approach of changing the
> init order.

That would be much nicer (and this is far from the only case where we
need to deal with it) but it's a substantial change to core kernel
infrastructure so it's being worked around like this.  Given how all the
discussions about sorting and dependencies for suspend and resume went
it might be an uphill struggle to do much more, especially while we are
able to continue to deal with things fairly easily using the current
infrastructure.

Doing dependencies could get pretty complicated, especially once you
handle optional dependencies ("is this missing because it didn't probe
yet or because it's just not there?") so it's not entirely clear to me
that it's worth the hassle.
