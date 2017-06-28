From: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 15/15] spi: qup: support for qup v1 dma
Date: Wed, 28 Jun 2017 01:47:38 -0500
Message-ID: <20170628064738.GD5203@hector.attlocal.net>
References: <1497949857-1852-1-git-send-email-varada@codeaurora.org>
 <1497949857-1852-16-git-send-email-varada@codeaurora.org>
 <20170623214923.ratchkoay73ytlv3@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Abhishek Sahu <absahu-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170623214923.ratchkoay73ytlv3@rob-hp-laptop>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

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

Yes, the CRCI should be part of the dma cells for the ADM.  That would make a
channel + crci work as a virtual channel that is backed by a hardware channel.

The only thing that has to be dealt with is the protocol difference between the
BAM and ADM dma blocks, which is what the v1 compatible tells us.


Regards,
Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
