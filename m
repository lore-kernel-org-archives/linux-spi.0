From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] spi: dw-mid: don't leak memory on exit
Date: Fri, 29 Aug 2014 10:35:15 +0300
Message-ID: <1409297715.30155.27.camel@linux.intel.com>
References: <1409215997-26085-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20140828181922.GJ29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Feng Tang <feng.tang@intel.com>, linux-spi@vger.kernel.org,
	stable@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20140828181922.GJ29327@sirena.org.uk>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 2014-08-28 at 19:19 +0100, Mark Brown wrote:
> On Thu, Aug 28, 2014 at 11:53:17AM +0300, Andy Shevchenko wrote:
> > When built with DMA support the memory for an internal structure is allocated
> > but not freed. Converting to devm_kzalloc solves the issue.
> > 
> > Fixes: 7063c0d942a1 (spi/dw_spi: add DMA support)
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: <stable@vger.kernel.org> # v2.6.38+
> 
> You've sent two versions of this with different changelogs and diffs -
> what's the story there?

Sorry for confusion.

There are two different fixes against MID support.
One of them to protect against crash on removal, another is this one.

> This doesn't seem like an obvious stable candidate - it's a leak fix on
> probe.

Yes, I may agree with you. Then, please, do not consider this one. It
would be a part of a patches against spi-dw-mid.c


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
