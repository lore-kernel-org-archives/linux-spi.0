From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 06/10] dmaengine: add API for getting dma controller's
 quirk
Date: Wed, 7 Oct 2015 15:32:06 +0100
Message-ID: <20151007143205.GG3320@vkoul-mobl.iind.intel.com>
References: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
 <1442188139-6017-1-git-send-email-shawn.lin@rock-chips.com>
 <20151005153746.GG13501@vkoul-mobl.iind.intel.com>
 <56139289.7000005@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>,
	Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56139289.7000005-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Oct 06, 2015 at 05:21:13PM +0800, Shawn Lin wrote:

> >>+	int (*device_get_quirks)(struct dma_chan *chan);
> >
> >And why do we want to expose this to users? THis doesnt seem right!
> >
> 
> Basically I agree not to expose dma's quirk to slave controllers...But, the
> fact I mentioned on cover letter explain the reasons why I have to let slave
> controllers know that they are working with a broken dma. It's a dilemma
> that if we don't want that to be exposed(let slave controllers' driver get
> the info via a API), we have to add broken quirk for all of them ,here and
> there, which seems to be a disaster:(
> 
> I would appreciate it if you could give me some suggestions at your earliest
> convenience. :)
> 
> >A quirk may exists but should be handled inside the controller driver and do
> >appropriate action. You don't tell users or expect them to handle these
> >
I laready gave one re-read the above lines.

Anyway I went ahead and read the usage. You are setting the slave parameters
for this. I can see two ways:
1. Have the quirk to driver and based on quirk reset the slave settings when
they are set by client.
2. Put this in DT and set the dma properties based on these quirks and let
driver and cleint be agnostic to it

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
