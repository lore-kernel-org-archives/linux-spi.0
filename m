From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: Re: [PATCH] spi-topcliff-pch: Fix probing when DMA mode is used
Date: Thu, 27 Feb 2014 09:13:21 +0100
Message-ID: <1998640.ToDhBRKzdY@ws-stein>
References: <1393428679-18462-1-git-send-email-alexander.stein@systec-electronic.com> <20140227043719.GH9383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140227043719.GH9383-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thursday 27 February 2014 13:37:19, Mark Brown wrote:
> On Wed, Feb 26, 2014 at 04:31:19PM +0100, Alexander Stein wrote:
> > If during registering SPI master due to SPI device probing a SPI transfer
> > is issued the DMA buffers are not allocated yet.
> 
> Applied, thanks.

Thinking about this patch over night, this also should go to stable, no?

Best regards,
Alexander

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
