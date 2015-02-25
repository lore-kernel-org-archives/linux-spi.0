From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 1/1] spi: dw: revisit FIFO size detection again
Date: Wed, 25 Feb 2015 11:35:14 +0200
Message-ID: <1424856914.14897.32.camel@linux.intel.com>
References: <1424803388-6033-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <CAFRkauBykVRaS9nEKTw-opYoe6z50eA=qwg74nBB1y9tzMm4gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFRkauBykVRaS9nEKTw-opYoe6z50eA=qwg74nBB1y9tzMm4gg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 2015-02-25 at 12:53 +0800, Axel Lin wrote:
> 2015-02-25 2:43 GMT+08:00 Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>:
> > The commit d297933cc7fc (spi: dw: Fix detecting FIFO depth) tries to fix the
> > logic of the FIFO detection based on the description on the comments. However,
> > there is a slight difference between numbers in TX Level and TX FIFO size.
> >
> > So, by specification the FIFO size would be in a range 2-256 bytes. From TX
> > Level prospective it means we can set threshold in the range 0-(FIFO size - 1)
> > bytes. Hence there are currently two issues:
> >   a) FIFO size 2 bytes is actually skipped since TX Level is 1 bit and could be
> >      either 0 or 1 byte;
> >   b) FIFO size is incorrectly decreased by 1 which already done by meaning of
> >      TX Level register.
> >
> > This patch fixes it eventually right.
> >
> > Fixes: d297933cc7fc (spi: dw: Fix detecting FIFO depth)
> > Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> > Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >
> > Shame on me I somehow missed this when tested mentioned patch.
> >
> >  drivers/spi/spi-dw.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> > index 0257dd1..ba9773d 100644
> > --- a/drivers/spi/spi-dw.c
> > +++ b/drivers/spi/spi-dw.c
> > @@ -494,14 +494,14 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
> >         if (!dws->fifo_len) {
> >                 u32 fifo;
> >
> > -               for (fifo = 2; fifo <= 256; fifo++) {
> > +               for (fifo = 1; fifo <= 256; fifo++) {
> 
> I think the upper bound of the for loop should be 255 (FIFO size - 1)
> for (fifo = 1; fifo <= 255; fifo++) {
> so if writting 255 to DW_SPI_TXFLTR success, fifo_len is 256.
> 
> no need to test writing 256 to  DW_SPI_TXFLTR.


Yes, I even just retested carefully.
I will change to < 256 and keep your Reviewed-by tag in v2, hope it's
okay.

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
