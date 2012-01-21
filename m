From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [PATCH 3/3] spi/s3c64xx: Implement runtime PM support
Date: Sat, 21 Jan 2012 14:41:59 +0100
Message-ID: <CADkCAuuR4NRV-VhZEyBTns3bBKVjtGupk2dv_UjM0gf3dvNMmg@mail.gmail.com>
References: <20120121132329.GA10751@opensource.wolfsonmicro.com>
	<1327152265-10789-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1327152265-10789-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Linus Walleij <linus.walleij@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1327152265-10789-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Guys:

On Sat, Jan 21, 2012 at 2:24 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Enable and disable the clocks to the SPI controller using runtime PM. This
> serves the dual purpose of reducing power consumption a little and letting
> the core know when the device is idle.

What about using autosuspend instead?  If a client is doing a lot of
closely-spaced SPI transactions on a relatively flat device tree,
might the resulting runtime suspend/resume overhead between each
transaction become noticeable?

I'm doing runtime PM on several drivers myself, and that question
keeps coming up a lot.  Especially for devices that are more
complicated to suspend/resume than this one.  But even without the
device-specific overhead, I'm wondering how structure-walking that
goes on behind the pm_runtime() calls might tip the balance of PM
gains the opposite way from what we are seeking.

Not a critique of your patch series per se, but you probably have some
thoughts on all of this too--- and I would love to hear them while
they are still fresh. :)


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
