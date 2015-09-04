From: Ranjit Abhimanyu Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [LINUX RFC v2 1/4] spi: add support of two chip selects & data
 stripe
Date: Fri, 4 Sep 2015 12:02:21 +0000
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3C014B0D67@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1440570367-22569-2-git-send-email-ranjit.waghmode@xilinx.com>
 <20150903121232.GW12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"Soren Brinkmann" <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org" <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	"marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>,
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
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150903121232.GW12027-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Thursday, September 03, 2015 5:43 PM
> To: Ranjit Abhimanyu Waghmode
> Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Michal Simek;
> Soren Brinkmann; zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org; marex-ynQEQJNshbs@public.gmane.org;
> b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org; knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org; juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org;
> beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org; linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Harini Katakam; Punnaiah Choudary Kalluri
> Subject: Re: [LINUX RFC v2 1/4] spi: add support of two chip selects & data
> stripe
> 
> On Wed, Aug 26, 2015 at 11:56:04AM +0530, Ranjit Waghmode wrote:
> 
> > To support dual parallel mode operation of ZynqMP GQSPI controller
> > following API's are added inside the core:
> 
> As covered in SubmittingPatches please try to make each patch a single change
> rather than having multiple separate changes in one commit.
I will split the patch.
> 
> > +	/* Controller may support more than one chip.
> > +	 * This flag will enable that feature.
> > +	 */
> > +#define SPI_MASTER_BOTH_CS		BIT(8)		/* enable both
> chips */
> 
> This isn't saying that the controller supports more than one chip, it's saying that
> the controller supports asserting more than one chip select at once which isn't
> the same thing.  I'm also not entirely sure that this makes sense as a separate
> feature to the data striping one - I'm struggling to think of a way to use this
> sensibly separately to that.
If the SPI controller is having more than one chip select and the data lines are distributed equally.
And also there is requirement to activate all the chip selects in one go.

Now we can consider following use cases:

Suppose we need to send the same data to multiple slaves of same kind:
Here the application need not to do individual slave access for writing, instead it can send data to all the devices in one go.

Let's take another case where application is trying to send data in such a way that first nibble of the byte will got to the one slave and the second nibble of the byte will go to the other slave:
Here data in slave devices can be organized by taking advantage of above topology along with the support in hardware.

Regards,
Ranjit
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
