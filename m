From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
Date: Mon, 2 Apr 2012 11:43:57 +0100
Message-ID: <20120402104357.GB24211@n2100.arm.linux.org.uk>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com> <CACRpkdYRStgKo_e-4kZKA-V-OoMiV21jRS3R4g1Cq+4c+4=iQA@mail.gmail.com> <CAH+eYFC+q4xFuSdRBkO9nb0XZWU4pQ_yCyinMy2X3ds9WQd1kw@mail.gmail.com> <CACRpkda2zh=zR+A9bwhRXYHtQdFeUpiqG4d5g1i82mPCs1mXaQ@mail.gmail.com> <20120402101427.GA3172@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Rabin Vincent <rabin@rab.in>,
	Grant Likely <grant.likely@secretlab.ca>,
	Samuel Ortiz <sameo@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120402101427.GA3172@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 02, 2012 at 11:14:28AM +0100, Mark Brown wrote:
> On Mon, Apr 02, 2012 at 12:39:11AM +0200, Linus Walleij wrote:
> 
> > Mark: as Rabin says the v1 patch is probably fine, are you pushing this
> > to ARM SoC or into Russell's patch tracker?
> 
> I was waiting for some pronouncement from Russell - looking at the git
> logs it seems the patch tracker is the normal way to merge things.

Well, this stuff was invented by Linus, so its Linus' decision about
how to deal with the power control.
