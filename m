From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] spi: s3c64xx: Don't free controller_data on non-dt
 platforms
Date: Sat, 22 Sep 2012 12:12:10 -0400
Message-ID: <20120922161209.GV4495@opensource.wolfsonmicro.com>
References: <1347546690-21848-1-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: thomas.abraham@linaro.org, spi-devel-general@lists.sourceforge.net,
	kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org,
	sw0312.kim@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1347546690-21848-1-git-send-email-s.nawrocki@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 13, 2012 at 04:31:30PM +0200, Sylwester Nawrocki wrote:
> When s3c64xx-spi is instantiated from device tree an instance of
> struct s3c64xx_spi_csinfo is dynamically allocated in the driver.

Applied, thanks.
