From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v7 9/9] spi: rockchip: modify DMA max burst to 1
Date: Tue, 9 Feb 2016 09:04:29 +0530
Message-ID: <20160209033428.GJ19598@localhost>
References: <1453460812-8498-1-git-send-email-wxt@rock-chips.com>
 <1453460812-8498-10-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Stuebner <heiko@sntech.de>,
	Sonny Rao <sonnyrao@chromium.org>, shawn.lin@rock-chips.com,
	dianders@chromium.org, linux-rockchip@lists.infradead.org,
	Addy Ke <addy.ke@rock-chips.com>,
	Olof Johansson <olof@lixom.net>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Caesar Wang <wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453460812-8498-10-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 22, 2016 at 07:06:52PM +0800, Caesar Wang wrote:
> From: Addy Ke <addy.ke@rock-chips.com>
> 
> Generic dma controller on Rockchips' platform cannot support
> DMAFLUSHP instruction which make dma to flush the req of non-aligned
> or non-multiple of what we need. That will cause an unrecoverable
> dma bus error. The saftest way is to set dma max burst to 1.

Applied, thanks

-- 
~Vinod
