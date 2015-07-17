From: Ranjit Abhimanyu Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support
 in Zynq MPSoC GQSPI controller
Date: Fri, 17 Jul 2015 12:03:48 +0000
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3CA7F18F@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150714164005.GE11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E53D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150715160146.GS11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E758@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150716085739.GT11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"Soren Brinkmann" <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
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
To: "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150716085739.GT11162-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

> -----Original Message-----
> From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Thursday, July 16, 2015 2:28 PM
> To: Ranjit Abhimanyu Waghmode
> Cc: Michal Simek; Soren Brinkmann; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org;
> computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; marex-ynQEQJNshbs@public.gmane.org;
> shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org; juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org; ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org; linux-
> mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Harini Katakam;
> Punnaiah Choudary Kalluri; ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> Subject: Re: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in
> Zynq MPSoC GQSPI controller
>
> On Thu, Jul 16, 2015 at 07:27:34AM +0000, Ranjit Abhimanyu Waghmode wrote:
>
> > For an example take two flashes connected in stacked mode.
> > For user it doesn't matter whether how many flashes are really connected.
> > There will be situation like, single partition is spread across two flashes
> (partition staring at the end of one flash and continued to the second flash). But
> it has to be shown contiguous to user.
> > In this scenario, I am not clear how MTD layer will handle the case.
> > It would be great if you could just put some light on it.
>
> That's something for the MTD layer or possibly even a layer above it to worry
> about - this situation is the same as we have with disks where we have md which
> combines other devices, if something similar is needed for flash we should use a
> similar pattern.

Kindly help in understanding, how can we represent the stacked mode and parallel mode changes in MTD layer?

Thanks & Regards,
Ranjit


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
