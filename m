From: Harini Katakam <harini.katakam@xilinx.com>
Subject: RE: [PATCH] SPI: Add driver for Cadence SPI controller
Date: Tue, 18 Mar 2014 05:22:37 +0000
Message-ID: <554ccbca-f92e-454c-90c0-b8a4ddddf3fd@CH1EHSMHS001.ehs.local>
References: <1395057936-8643-1-git-send-email-harinik@xilinx.com>
 <20140317173017.GW11706@sirena.org.uk>
 <20140317175911.GU18529@joshc.qualcomm.com>
 <20140317181440.GY11706@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>,
	Josh Cartwright <joshc@codeaurora.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140317181440.GY11706@sirena.org.uk>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Monday, March 17, 2014 11:45 PM
> To: Josh Cartwright
> Cc: Harini Katakam; robh+dt@kernel.org; pawel.moll@arm.com;
> mark.rutland@arm.com; ijc+devicetree@hellion.org.uk;
> galak@codeaurora.org; rob@landley.net; grant.likely@linaro.org;
> devicetree@vger.kernel.org; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-spi@vger.kernel.org; Michal Simek
> Subject: Re: [PATCH] SPI: Add driver for Cadence SPI controller
> 
> On Mon, Mar 17, 2014 at 12:59:11PM -0500, Josh Cartwright wrote:
> > On Mon, Mar 17, 2014 at 05:30:17PM +0000, Mark Brown wrote:
> > > On Mon, Mar 17, 2014 at 05:35:36PM +0530, Harini Katakam wrote:
> 
> > > > +static int __maybe_unused cdns_spi_suspend(struct device *dev) {
> 
> > > This needs to call spi_master_suspend() as well (and similarly on
> > > resume).
> 
> > I'm not that familiar with the SPI core, but this seems like an
> > inversion.  Is there a reason why the SPI master class doesn't
> > implement
> > suspend/resume() callbacks which handle stopping/starting the queue
> > automatically for all masters?
> 
> This is for users of an optional feature of the infrastructure.  We probably
> should just call it anyway since it does have checks for the feature being
> used (but given all the open coding around this stuff I'd need to verify that
> the class callbacks would reliably get called).
> 
> In any case that's not happening now and the driver as it stands is buggy
> since it's trampling all over the hardware without syncing with anything that
> isn't ongoing.

In case of a suspend, we are stopping an ongoing transfer and disabling the interface.
In case I add clock disable and anything else to unprepared too, it will be a cleaner 
exit but it will still stop the transfer right? What do you suggest?
Should we wait for transfer to complete or a timeout to occur?

Regards,
Harini


