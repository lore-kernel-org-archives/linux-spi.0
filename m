From: Harini Katakam <harini.katakam@xilinx.com>
Subject: RE: [PATCH] SPI: Add driver for Cadence SPI controller
Date: Mon, 17 Mar 2014 14:01:17 +0000
Message-ID: <d0d4dc5c-aade-4155-b998-3d177b6581c2@CH1EHSMHS004.ehs.local>
References: <1395057936-8643-1-git-send-email-harinik@xilinx.com>
 <CAL_JsqKacetGytGUJir7ky3qOgCy-3ny1pT_Bx4eCYV2wMgcTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Rob Landley <rob@landley.net>, Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	Michal Simek <michals@xilinx.com>
To: Rob Herring <robherring2@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKacetGytGUJir7ky3qOgCy-3ny1pT_Bx4eCYV2wMgcTg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robherring2@gmail.com]
> Sent: Monday, March 17, 2014 6:17 PM
> To: Harini Katakam
> Cc: Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala; Rob
> Landley; Mark Brown; Grant Likely; devicetree@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> spi@vger.kernel.org; Michal Simek
> Subject: Re: [PATCH] SPI: Add driver for Cadence SPI controller
>
> On Mon, Mar 17, 2014 at 7:05 AM, Harini Katakam <harinik@xilinx.com>
> wrote:
> > Add driver for Cadence SPI controller. This is used in Xilinx Zynq.
> >
> > Signed-off-by: Harini Katakam <harinik@xilinx.com>
> > ---
>
> > +- reg                  : Physical base address and size of SPI registers map.
> > +- interrupts           : Property with a value describing the interrupt
> > +                         number.
> > +- interrupt-parent     : Must be core interrupt controller
> > +- clock-names          : List of input clock names - "ref_clk", "pclk"
> > +                         (See clock bindings for details).
> > +- clocks               : Clock phandles (see clock bindings for details).
> > +- num-chip-select      : Number of chip selects used.
>
> See Documentation/devicetree/bindings/spi/spi-bus.txt. Use "num-cs"
> here.

I'll check that.
> > +
> > +       irq = platform_get_irq(pdev, 0);
> > +       if (irq < 0) {
>
> I believe this returns NO_IRQ which could be 0.
>
> s/</<=/
>
> > +       dev_dbg(&pdev->dev, "suspend succeeded\n");
>
> Not needed. The kernel already has suspend/resume tracing printks.

Will remove.

> > +       dev_dbg(&pdev->dev, "resume succeeded\n");
>
> Not needed. The kernel already has suspend/resume tracing printks.

Will remove.

Regards,
Harini



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
