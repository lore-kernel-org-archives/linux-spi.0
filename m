From: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v3 15/15] spi: qup: support for qup v1 dma
Date: Tue, 27 Jun 2017 15:06:46 +0530
Message-ID: <20170627093645.GA21936@codeaurora.org>
References: <1497949857-1852-1-git-send-email-varada@codeaurora.org>
 <1497949857-1852-16-git-send-email-varada@codeaurora.org>
 <20170623214923.ratchkoay73ytlv3@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Abhishek Sahu <absahu-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170623214923.ratchkoay73ytlv3@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Rob,

On Fri, Jun 23, 2017 at 04:49:23PM -0500, Rob Herring wrote:
> On Tue, Jun 20, 2017 at 02:40:57PM +0530, Varadarajan Narayanan wrote:
> > Currently the QUP Version v1 does not work with DMA so added
> > the support for the same.
> >
> > 1. It uses ADM DMA which requires TX and RX CRCI
> > 2. DMA channel initialization need to be done after setting
> >    block size for having valid values in maxburst
> > 3. QUP mode should be DMOV instead of BAM.
> >
> > Signed-off-by: Abhishek Sahu <absahu-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > Signed-off-by: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > ---
> >  .../devicetree/bindings/spi/qcom,spi-qup.txt       |  6 ++++
> >  drivers/spi/spi-qup.c                              | 35 +++++++++++++++++-----
> >  2 files changed, 34 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
> > index 5c09077..e754181 100644
> > --- a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
> > +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
> > @@ -38,6 +38,12 @@ Optional properties:
> >  - dma-names:    Names for the dma channels, if present. There must be at
> >                  least one channel named "tx" for transmit and named "rx" for
> >                  receive.
> > +- qcom,tx-crci: Identificator for Client Rate Control Interface (CRCI) to be
>
> Identificator is not a word.
>
> This sounds like something that should be a cell in the dmas property.

I will hold this patch for now. This depends on the ADM driver, which
is not upstreamed yet. Will incorporate your feedback and re-post the
patch later.

Thanks
Varada

> > +		used with TX DMA channel. Required when using DMA for
> > +		transmission with QUP Version 1 i.e qcom,spi-qup-v1.1.1.
> > +- qcom,rx-crci: Identificator for Client Rate Control Interface (CRCI) to be
> > +		used with RX DMA channel. Required when using DMA for
> > +		receiving with QUP Version 1 i.e qcom,spi-qup-v1.1.1.
> >
> >  SPI slave nodes must be children of the SPI master node and can contain
> >  properties described in Documentation/devicetree/bindings/spi/spi-bus.txt

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
