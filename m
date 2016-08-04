From: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Subject: Re: [PATCH v5 2/2] spi: add driver for J-Core SPI controller
Date: Thu, 4 Aug 2016 00:30:17 -0400
Message-ID: <20160804043017.GG15995@brightrain.aerifal.cx>
References: <cover.1470187592.git.dalias@libc.org>
 <a452a1588abbfb1f69390a6b882ea27a449b2391.1470187592.git.dalias@libc.org>
 <CAL_JsqJEYtrVxZT=j97XXY2w1u1QgtpfjYSOB_H-R4y6SAb7UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJEYtrVxZT=j97XXY2w1u1QgtpfjYSOB_H-R4y6SAb7UQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Aug 03, 2016 at 08:16:43AM -0500, Rob Herring wrote:
> On Sun, Apr 3, 2016 at 12:12 AM, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org> wrote:
> 
> The date on your patch emails is way off.

Thanks for catching this. I tweaked my email-prep scripts to improve
coverage of who to send to, and somehow lost the part that deletes the
bogus Date: headers from git-format-patch output. I'll resend since
the messages were probably missed by their intended recipients.


> > The J-Core "spi2" device is a PIO-based SPI master controller. It
> > differs from "bitbang" devices in that that it's clocked in hardware
> > rather than via soft clock modulation over gpio, and performs
> > byte-at-a-time transfers between the cpu and SPI controller.
> >
> > This driver will be extended to support future versions of the J-Core
> > SPI controller with DMA transfers when they become available.
> >
> > Signed-off-by: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
