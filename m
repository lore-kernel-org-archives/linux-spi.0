From: Ranjit Abhimanyu Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support
 in Zynq MPSoC GQSPI controller
Date: Thu, 16 Jul 2015 07:27:34 +0000
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3CA7E758@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150714164005.GE11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E53D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150715160146.GS11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>,
	"shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org" <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	"ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org" <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"Punnaiah Choudary Kalluri" <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150715160146.GS11162-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

> > > > What is stacked mode?
> > > > ---------------------
> > > > ZynqMP GQSPI controller supports stacked mode with following
> > > functionalities:
> > > > 1) The Generic Quad-SPI controller also supports two SPI flash memories
> > > >    in a shared bus arrangement to reduce IO pin count.
> > > > 2) Separate chip select lines
> > > > 3) Shared I/O lines
> > > > 4) This mode is targeted for increasing the flash memory and no
> performance
> > > >    improvement when compared with single.
> 
> > > This is just a normal SPI controller from a SPI point of view.
> 
> > How can we really represent the stacked mode in current configuration?
> 
> In the same way as any other controller with two chip selects...  there are quite
> a few other drivers that provide examples of this, you should look for one that
> has hardware control similar to yours.

Thanks Mark for your suggestion. But I have minor doubts.

For an example take two flashes connected in stacked mode.
For user it doesn't matter whether how many flashes are really connected. 
There will be situation like, single partition is spread across two flashes (partition staring at the end of one flash and continued to the second flash). But it has to be shown contiguous to user.
In this scenario, I am not clear how MTD layer will handle the case.
It would be great if you could just put some light on it.

Regards,
Ranjit
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
