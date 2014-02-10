From: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add Qualcomm QUP SPI controller support
Date: Mon, 10 Feb 2014 11:47:38 -0600
Message-ID: <20140210174738.GA31596@qualcomm.com>
References: <1391705868-20091-1-git-send-email-iivanov@mm-sol.com>
 <1391705868-20091-3-git-send-email-iivanov@mm-sol.com>
 <20140207073952.GA2610@qualcomm.com>
 <1391766753.27491.60.camel@iivanov-dev>
 <20140207173207.GA19974@qualcomm.com>
 <1392051302.2853.56.camel@iivanov-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Gilad Avidov <gavidov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Kiran Gunda <kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392051302.2853.56.camel@iivanov-dev>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Feb 10, 2014 at 06:55:02PM +0200, Ivan T. Ivanov wrote:

[....]

> > > > Bail here?
> > > 
> > > I don't know. What will be the consequences if controller continue to
> > > operate on its default rate?
> > > 
> > 
> > It is unclear.  But if you can't set the rate that is configured or if there is
> > a misconfiguration, it's probably better to exit the probe and catch it here.
> 
> 
> My preference is to delay clock speed change till first
> SPI transfer. And use wherever transfer itself mandate.
> 

That works.  My only concern is that it might be nice to catch a configuration
problem early rather than wait for the SPI transfer to fail continuously.

[....]

> > > My understanding is:
> > > 
> > > Disabling clocks will timeout transaction, if any. Core Device driver
> > > will call: devm_spi_unregister(), which will wait pending transactions
> > > to complete and then remove the SPI master.
> > 
> > Disabling clocks will confuse the hardware.  We cannot disable clocks while the
> > spi core is active and transferring data.
> 
> I could follow approach taken by other SPI drivers, just reset
> controller and disable clocks.

You have to wait until the hardware is in a sane state.  For the QUP, that means
in a RUN/PAUSE/RESET state.  It cannot be in transition when you cut the clocks.
The safest thing to do is to get the QUP into the RESET state and then cut the
clocks.

[.....]

> > > I am not aware of the difference. My board report v.20020000. 
> > > Is there difference of handling these controllers?
> > 
> > There were some bug fixes between versions.  None of those affect SPI (that I
> > can tell), but it's better to be more descriptive and use the full versions in
> > the compatible tags.
> 
> No strong preference here. Should I add qcom,spi-qup-v2.2.0, then? :-)

According to the documentation, there is no v2.2.0.  It appears there is some
disconnect between the specific HW revision and the documentation.  I'll see if
I can get some clarification from the hardware guys.  For now, I think the 2.1.1
and 2.2.1 tags are fine.


-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
