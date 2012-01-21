From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] spi/s3c64xx: Implement runtime PM support
Date: Sat, 21 Jan 2012 14:18:05 +0000
Message-ID: <20120121141804.GB10751@opensource.wolfsonmicro.com>
References: <20120121132329.GA10751@opensource.wolfsonmicro.com>
 <1327152265-10789-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1327152265-10789-3-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CADkCAuuR4NRV-VhZEyBTns3bBKVjtGupk2dv_UjM0gf3dvNMmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Linus Walleij <linus.walleij@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADkCAuuR4NRV-VhZEyBTns3bBKVjtGupk2dv_UjM0gf3dvNMmg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Jan 21, 2012 at 02:41:59PM +0100, Bill Gatliff wrote:

> What about using autosuspend instead?  If a client is doing a lot of
> closely-spaced SPI transactions on a relatively flat device tree,
> might the resulting runtime suspend/resume overhead between each
> transaction become noticeable?

It seems very low overhead, particularly in the context of the overhead
of the SPI transactions themselves.  I have sometimes wondered if it
might be an idea to just make the core do something along these lines by
default as there should be very few cases where it's important to have
the suspend happen immediately.
