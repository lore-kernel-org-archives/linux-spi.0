From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 06/10] dmaengine: add API for getting dma controller's
 quirk
Date: Mon, 5 Oct 2015 16:37:47 +0100
Message-ID: <20151005153746.GG13501@vkoul-mobl.iind.intel.com>
References: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
 <1442188139-6017-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Stuebner <heiko@sntech.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Olof Johansson <olofj@lixom.net>,
	Sonny Rao <sonnyrao@chromium.org>,
	Addy Ke <addy.ke@rock-chips.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-spi@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442188139-6017-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Sep 14, 2015 at 07:48:59AM +0800, Shawn Lin wrote:
> Add dmaengine_get_quirks API for peripheral devices to query
> quirks if they need it to make special workaround due to broken
> dma controller design.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> Changes in v1: None
> 
>  include/linux/dmaengine.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index e2f5eb4..5174ca4 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -704,6 +704,7 @@ struct dma_device {
>  
>  	int (*device_config)(struct dma_chan *chan,
>  			     struct dma_slave_config *config);
> +	int (*device_get_quirks)(struct dma_chan *chan);

And why do we want to expose this to users? THis doesnt seem right!

A quirk may exists but should be handled inside the controller driver and do
appropriate action. You don't tell users or expect them to handle these

-- 
~Vinod
