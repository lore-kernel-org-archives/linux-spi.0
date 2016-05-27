From: Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v3 10/12] spi: add driver for J-Core SPI controller
Date: Thu, 26 May 2016 21:16:21 -0400
Message-ID: <20160527011621.GA10893@brightrain.aerifal.cx>
References: <cover.1464148904.git.dalias@libc.org>
 <00b31c4d09c340bd69fd4bbbc0ea06371aecc502.1464148904.git.dalias@libc.org>
 <20160525101708.GS8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160525101708.GS8206@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, May 25, 2016 at 11:17:08AM +0100, Mark Brown wrote:
> On Wed, May 25, 2016 at 05:43:03AM +0000, Rich Felker wrote:
> 
> > changes based on ml discussion of the v2 patch. The chipselect change
> > has not been made yet, except for rewriting the current logic to be
> > more clear. If the decision is that it's needed, I can do it easily,
> > but it needs testing still.
> 
> You need to fix that, it's not good to just decide to ignore review
> comments.  It is astonishing that you are doing this while expecting to
> bypass the normal process for merging things.  I'm not going to look at
> this version, please ensure you have addressed all the feedback from the
> previous review before any new version you submit.

I've made and tested a change that looks like what you want, with the
hw->csReg's chipselect bits set initially high in the probe function,
and only the requested bit being modified by the chipselect function.
Would you prefer I continue to submit this driver with new versions of
the patch series, or separate it out for further review on its own?

Rich
