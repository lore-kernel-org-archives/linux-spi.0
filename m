From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 2/5] spi: rspi: Remove casts
Date: Sat, 28 Dec 2013 12:44:29 +0100
Message-ID: <8739713.Slr9ZZgJxG@avalon>
References: <1387878574-21445-1-git-send-email-geert+renesas@linux-m68k.org> <2810034.n2a8aHlIUW@avalon> <CAMuHMdXyeRdgFJF0MzJkJ5jf1pSWfO98mdn-JSF0ze2iuTbLug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXyeRdgFJF0MzJkJ5jf1pSWfO98mdn-JSF0ze2iuTbLug-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

On Friday 27 December 2013 19:38:43 Geert Uytterhoeven wrote:
> On Fri, Dec 27, 2013 at 3:33 PM, Laurent Pinchart wrote:
> >> @@ -440,12 +437,13 @@ static void rspi_memory_from_8bit(void *buf, const
> >> void *data, unsigned len) static int rspi_send_dma(struct rspi_data
> >> *rspi,
> >> struct spi_transfer *t) {
> >> 
> >>       struct scatterlist sg;
> >> 
> >> -     void *buf = NULL;
> >> +     const void *buf = NULL;
> >> 
> >>       struct dma_async_tx_descriptor *desc;
> >>       unsigned len;
> >>       int ret = 0;
> >>       
> >>       if (rspi->dma_width_16bit) {
> >> 
> >> +             void *tmp;
> > 
> > I really dislike tmp as a variable name, as it can mean pretty much
> > anything. What about calling it tx_buf instead ?
> 
> Thanks, that would indeed be a better name.
> However, Mark has already applied it to spi/for-next, so I'm not sure we
> can still change it, without sending a complete new patch.

I've noticed that after sending the reply. I think we can live with tmp for 
now.

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
