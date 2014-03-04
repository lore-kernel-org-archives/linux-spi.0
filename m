From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: Re: [PATCH] spi-topcliff-pch: Fix probing when DMA mode is used
Date: Tue, 04 Mar 2014 07:52:56 +0100
Message-ID: <3771945.ph3nlbMubQ@ws-stein>
References: <1393428679-18462-1-git-send-email-alexander.stein@systec-electronic.com> <2382434.oQkeY8Zb6p@ws-stein> <20140304044422.GJ2411@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140304044422.GJ2411-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday 04 March 2014 12:44:22, Mark Brown wrote:
> On Mon, Mar 03, 2014 at 08:21:16AM +0100, Alexander Stein wrote:
> > Well, i think this is a rather rarely use case. You need either all
> > drivers compiled in where the SPI device driver is loaded before SPI
> > master or you need SPI master als module while the SPI device driver
> > is already compiled in. Oh, and the SPI device driver must do a SPI
> > transfer during probe. So the conditions are reptty strict when this
> > problem might happen.
> 
> > PS: On EG20T (PCH) it seems this will never happen as the DMA channels
> > are allocated wrongly (see other patch from me) andso DMA will never
> > be used.
> 
> OK, so this doesn't sound terribly urgent then?  It's hard to see and
> other bugs mean it wouldn't be triggered anyway?

Yes, at least for EG20T. I have no idea about those MLxxxx IOH.

Alexander

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
