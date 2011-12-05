From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] spi/s3c64xx: Implement runtime PM support
Date: Mon, 5 Dec 2011 23:16:48 +0000
Message-ID: <20111205231647.GA21083@opensource.wolfsonmicro.com>
References: <1323103813-5325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1323103813-5325-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CACRpkdYPdV2_Hr8hO_CAhZ=MvqcBiNdgwySbATcPSfwFRvkARg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kukjin Kim <kgene.kim@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYPdV2_Hr8hO_CAhZ=MvqcBiNdgwySbATcPSfwFRvkARg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 05, 2011 at 10:41:21PM +0100, Linus Walleij wrote:

> Just wanted to mention that I had this discussion with Magnus Damm
> about how they do this in shmobile: in there their central runtime PM
> policy in arch/arm/mach-shmobile/pm_runtime.c adds in the
> pm_clk_notifier from drivers/base/power/clock_ops.c to gate/ungate
> the clocks centrally acting on bus notifiers without any per-driver
> hooks like these.

Yeah, I'm familiar with that - some other platforms were looking into a
similar scheme I think.

> I clearly see that in this platform it's *not* going to work since
> for this one driver atleast, there are two clocks, not just one,
> that need to be managed for the device.

Well, that's not something that's a blocker to central management - the
core can always work with two clocks.  What's more of an issue is when
devices need to work with their clocks independantly of the core, but
that's not insurmountable.

I do also think that if we do decide to move more platforms to central
management it's going to be easier to first transition all their drivers
to a repetitive style of clock management and then do a big factor out
once the pattern is clearly visible.  It's a big undertaking for things
like the Samsung family of processors where you've got a huge set of
chips to work with going all the way back to s3c24xx so anything we can
do to make it easier is going to be a win.
