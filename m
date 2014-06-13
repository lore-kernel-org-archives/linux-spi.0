From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] spi/pxa2xx: fix incorrect SW mode chipselect setting
 for BayTrail LPSS SPI
Date: Fri, 13 Jun 2014 16:10:08 +0300
Message-ID: <20140613131008.GK21178@lahna.fi.intel.com>
References: <1402675045-22460-1-git-send-email-chiau.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Miao <eric.y.miao@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Chew Chiau Ee <chiau.ee.chew@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402675045-22460-1-git-send-email-chiau.ee.chew@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jun 13, 2014 at 11:57:25PM +0800, Chew Chiau Ee wrote:
> From: Chew, Chiau Ee <chiau.ee.chew@intel.com>
> 
> It was observed that after module removal followed by insertion,
> the SW mode chipselect is not properly set. Thus causing transfer
> failure due to incorrect CS toggling.
> 
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
