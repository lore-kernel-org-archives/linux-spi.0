From: Harini Katakam <harini.katakam@xilinx.com>
Subject: RE: [PATCH] SPI: Add driver for Cadence SPI controller
Date: Tue, 18 Mar 2014 14:45:09 +0000
Message-ID: <aa8486d2-8571-4b31-8980-78806a80e600@CH1EHSMHS031.ehs.local>
References: <1395057936-8643-1-git-send-email-harinik@xilinx.com>
 <20140317173017.GW11706@sirena.org.uk>
 <255edf4f-05a8-4d9a-b32d-1a4a8ddaffb5@CH1EHSMHS004.ehs.local>
 <20140318110401.GH11706@sirena.org.uk>
 <d7cf691a-c9cb-4a8a-bf5c-eae952a5d729@VA3EHSMHS045.ehs.local>
 <20140318123348.GR11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"rob@landley.net" <rob@landley.net>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	Michal Simek <michals@xilinx.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140318123348.GR11706@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

HI Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, March 18, 2014 6:04 PM
> To: Harini Katakam
> Cc: robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com;
> ijc+devicetree@hellion.org.uk; galak@codeaurora.org; rob@landley.net;
> grant.likely@linaro.org; devicetree@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> spi@vger.kernel.org; Michal Simek
> Subject: Re: [PATCH] SPI: Add driver for Cadence SPI controller
> 
> On Tue, Mar 18, 2014 at 12:13:45PM +0000, Harini Katakam wrote:
> 
> 
> > > > In this case both possible interrupt conditions are handled.
> 
> > > Are you sure that's the case, and even if you are that's still not
> > > handling the case where the device isn't flagging an interrupt at all.
> 
> > The IXR_ALL mask is only used to disable all the interrupts in the
> beginning.
> > These two are the only interrupts enabled.
> > And RXNEMPTY status is just polled. That interrupt is not enabled either
> 
> This is all going to be fragile in the face of bugs or changes in the
> code though and like I keep saying it doesn't handle interrupt sharing.

OK. I dint consider interrupt sharing. 
Do you think the following implementation would be better?

status = IRQ_NONE;
if (intr_status & CDNS_SPI_IXR_MODF_MASK) {
	/* Handle this interrupt here */
	status = IRQ_HANDLED;
} else if (intr_status & CDNS_SPI_IXR_TXOW_MASK) {
	/* Handle this interrupt here */
	status = IRQ_HANDLED;
}

return status;

Regards,
Harini
