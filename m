From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [LINUX RFC v2 0/4] spi: add dual parallel mode support in Zynq MPSoC GQSPI controller
Date: Wed, 2 Sep 2015 20:56:09 +0200
Message-ID: <201509022056.09635.marex@denx.de>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com> <201508260856.22258.marex@denx.de> <7CFCFE83B8145347A1D424EC939F1C3C014AFF00@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org" <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	"b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org" <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>,
	"juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org" <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	"beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org" <beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Ranjit Abhimanyu Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7CFCFE83B8145347A1D424EC939F1C3C014AFF00-4lKfpRxZ5enZMOc0yg5rMog+Gb3gawCHQz34XiSyOiE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday, September 02, 2015 at 07:12:14 PM, Ranjit Abhimanyu Waghmode 
wrote:
> Hi Marek,
> 
> > -----Original Message-----
> > From: Marek Vasut [mailto:marex-ynQEQJNshbs@public.gmane.org]
> > Sent: Wednesday, August 26, 2015 12:26 PM
> > To: Ranjit Abhimanyu Waghmode
> > Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> > broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Michal Simek; Soren Brinkmann; zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> > ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org; b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org; knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org;
> > juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org; beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org; linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> > linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-
> > kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Harini Katakam; Punnaiah Choudary Kalluri
> > Subject: Re: [LINUX RFC v2 0/4] spi: add dual parallel mode support in
> > Zynq MPSoC GQSPI controller
> > 
> > On Wednesday, August 26, 2015 at 08:26:03 AM, Ranjit Waghmode wrote:
> > > This series adds dual parallel mode support for Zynq Ultrascale+ MPSoC
> > > GQSPI controller driver.
> > > 
> > > What is dual parallel mode?
> > > ---------------------------
> > > ZynqMP GQSPI controller supports Dual Parallel mode with following
> > > functionalities: 1) Supporting two SPI flash memories operating in
> > > parallel. 8 I/O lines. 2) Chip selects and clock are shared to both
> > > the flash devices
> > > 3) This mode is targeted for faster read/write speed and also doubles
> > > the size 4) Commands/data can be transmitted/received from both the
> > > devices(mirror), or only upper or only lower flash memory devices.
> > > 
> > > 5) Data arrangement:
> > >    With stripe enabled,
> > >    Even bytes i.e. 0, 2, 4,... are transmitted on Lower Data Bus
> > >    Odd bytes i.e. 1, 3, 5,.. are transmitted on Upper Data Bus.
> > 
> > This might be a dumb question, but why don't you just treat this as an
> > SPI NOR flash with 8-bit bus ?
> 
> In case of dual parallel configuration of this controller there are
> different modes like single, dual and quad mode. Whatever you are
> suggesting would fit only in the case of Quad mode operation as both buses
> would have 4 lines each. In case of single mode of parallel configuration,
> there would be two buses; but the line on each bus would one. So
> altogether there will be two lines. And in case of dual mode of parallel
> configuration each bus will be having two lines. So altogether 4 lines
> will be there. So keeping 8 lines would not support above two modes of
> parallel configuration correctly.
> 
> Logically it is a single flash with 8 IO lines but physically it's a two
> flash devices and each has 4 IO lines. So, in this case, read and write
> addresses should be always even and minimum data that can be accessed is 2
> bytes.

Oh, I see what the issue is now. It has to do with configuring the flash
into correct bus-width mode, right ?

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
