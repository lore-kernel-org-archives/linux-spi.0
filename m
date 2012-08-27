From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] spi/s3c64xx: Drop extra calls to spi_master_get in
 suspend/remove functions
Date: Mon, 27 Aug 2012 10:19:06 -0700
Message-ID: <20120827171904.GP4339@opensource.wolfsonmicro.com>
References: <1345173265-1721-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Thomas Abraham <thomas.abraham@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1345173265-1721-1-git-send-email-linux@roeck-us.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 16, 2012 at 08:14:25PM -0700, Guenter Roeck wrote:
> Suspend and resume functions call spi_master_get() without matching
> spi_master_put(). The extra references are unnecessary and cause subsequent
> module unload attempts to fail. Drop the calls.

Applied, thanks.
