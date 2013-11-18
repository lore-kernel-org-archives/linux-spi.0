From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 23/31] spi: tegra: convert to standard DMA DT bindings
Date: Mon, 18 Nov 2013 10:30:35 -0700
Message-ID: <528A4EBB.2090800@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org> <1384548866-13141-24-git-send-email-swarren@wwwdotorg.org> <20131116101422.GK15393@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131116101422.GK15393-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 11/16/2013 03:14 AM, Mark Brown wrote:
> On Fri, Nov 15, 2013 at 01:54:18PM -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> By using dma_request_slave_channel_or_err(), the DMA slave ID can be
> 
> Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Is this function introduced earlier in the series?

Yes, patch 11/31 introduced this.

> One of the things
> I'm looking at is trying to factor out some DMA code in the SPI
> framework so perhaps using this straight off would be good.  But perhaps
> the channel request stuff will all be in the drivers and it'll just pass
> a handle to the framework code so there'll be no issue.

I think I can make a "core changes" branch that contains:

[PATCH 11/31] dma: add channel request API that supports deferred probe

[PATCH 14/31] ASoC: dmaengine: support deferred probe for DMA channels

[PATCH 15/31] ASoC: dmaengine: add custom DMA config to
snd_dmaengine_pcm_config

That could be merged into relevant subsystems alone, if they only depend
on the core changes and not any of the Tegra driver changes.

However, I suspect that the Tegra driver changes may need to be merged
into any subsystem that's doing much other work on the Tegra drivers,
especially any significant refactoring, so the subsystem would probably
have to pick up the whole series anyway. Still, I'll make sure I
re-order the branch to put the core changes first so we have as much
flexibility as possible.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
