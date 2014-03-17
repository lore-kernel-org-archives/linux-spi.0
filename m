From: "B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/2] spi/fsl-lib: Get the SPI controller bus number from
 DTS
Date: Mon, 17 Mar 2014 05:11:11 +0000
Message-ID: <c4b28b01b2f544ca9d264eaee2542257@DM2PR03MB301.namprd03.prod.outlook.com>
References: <1394789757-40732-1-git-send-email-B48286@freescale.com>
 <1394789757-40732-2-git-send-email-B48286@freescale.com>
 <20140314191922.GA366@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140314191922.GA366-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



> -----Original Message-----
> From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Saturday, March 15, 2014 3:19 AM
> To: Hou Zhiqiang-B48286
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org; pawel.moll-5wv7dgnIgG8@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org;
> ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org; galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org;
> grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org; Wood Scott-B07421; Hu Mingkai-B21284
> Subject: Re: [PATCH 2/2] spi/fsl-lib: Get the SPI controller bus number
> from DTS
> 
> On Fri, Mar 14, 2014 at 05:35:57PM +0800, Hou Zhiqiang wrote:
> > Get the spi_master's bus_num from DTS to make the spi_master's name
> > static. So "mtdparts=spi.bus_num.chip_select:..." in cmdline can be
> > used to asign mtd partions of spi flash.
> 
> If we are going to do this it shouldn't be device specific (it should be
> done in the framework since nothing is specific to the controller there)
> but I'm not convinced that we should be doing it - this is all very Linux
> specific.

This patch just assign a bus number to the controller. It is driver's 
responsibility to distribute a bus number to spi_master and the definition
of bus_num is used to distinguish controllers. So, it is specific for the
controller and doesn't affect the framework. 

> 
> The DT already has support for specifying flash layouts, can't those be
> used (for example via chosen if they're not fixed for the board)?  Or if
> it's just picking the correct filesystem then UUIDs and labels are the
> standard way to do things.

The DT specifying flash layouts is ok. There is another way to make the
flash layouts using command line, but it is not safe because of the dynamic
bus_num. It is not the reason that the way of DT is supported flash layouts,
to live the other way unsafe, right?

Thanks,
Zhiqiang
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
