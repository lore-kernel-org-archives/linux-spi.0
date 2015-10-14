From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v5 06/10] dmaengine: add API for getting dma
 controller's quirk
Date: Wed, 14 Oct 2015 16:23:10 +0530
Message-ID: <20151014105310.GQ27370@localhost>
References: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
 <1442188139-6017-1-git-send-email-shawn.lin@rock-chips.com>
 <20151005153746.GG13501@vkoul-mobl.iind.intel.com>
 <56139289.7000005@rock-chips.com>
 <561629D6.9010702@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <561629D6.9010702-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Oct 08, 2015 at 10:31:18AM +0200, Lars-Peter Clausen wrote:
> > Basically I agree not to expose dma's quirk to slave controllers...But, the
> > fact I mentioned on cover letter explain the reasons why I have to let slave
> > controllers know that they are working with a broken dma. It's a dilemma
> > that if we don't want that to be exposed(let slave controllers' driver get
> > the info via a API), we have t add broken quirk for all of them ,here and
> > there, which seems to be a disaster:(
> 
> The problem with this API is that it transports values with device specific
> meanings over a generic API. Which is generally speaking not a good idea
> because the consumer witch is supposed to be generic suddenly needs to know
> which provider it is talking to.
> 
> A better solution in this case typically is either introduce a generic API
> with generic values or a custom API with custom values, but don't mix the two.
> 
> > 
> > I would appreciate it if you could give me some suggestions at your earliest
> > convenience. :)
> 
> In this case I think the best way to handle this is not quirks, but rather
> expose the actual maximum burst size using the DMA capabilities API. Since
> supporting only a certain burst depth is not really a quirk. All hardware
> has a limit for this and for some it might be larger or smaller than for
> others and it might be the same IP core but the maximum size depends on some
> IP core parameters. So this should be discoverable.

yes that makes more sense than adding quirks, exposing the right values
which should be a readable property for driver will ensure it works on
system with/without quirks

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
