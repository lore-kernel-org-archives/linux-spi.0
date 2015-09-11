From: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [LINUX RFC v2 1/4] spi: add support of two chip selects & data stripe
Date: Fri, 11 Sep 2015 21:54:29 +0530
Message-ID: <CAFcVECJ_sF6Sav4NffMkwS5iQnPk2x7SE=qji5ByF17ejX0n=g@mail.gmail.com>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
	<1440570367-22569-2-git-send-email-ranjit.waghmode@xilinx.com>
	<20150903121232.GW12027@sirena.org.uk>
	<7CFCFE83B8145347A1D424EC939F1C3C014B0D67@XAP-PVEXMBX01.xlnx.xilinx.com>
	<20150911123644.GU12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ranjit Abhimanyu Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
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
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150911123644.GU12027-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Fri, Sep 11, 2015 at 6:06 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Sep 04, 2015 at 12:02:21PM +0000, Ranjit Abhimanyu Waghmode wrote:
>
> Please fix your mail client to word wrap within paragraphs and to quote
> text without reflowing it - your messages are very hard to read.
>
>> > > + /* Controller may support more than one chip.
>> > > +  * This flag will enable that feature.
>> > > +  */
>> > > +#define SPI_MASTER_BOTH_CS               BIT(8)          /* enable both
>> > chips */
>
>> Now we can consider following use cases:
>
>> Suppose we need to send the same data to multiple slaves of same kind:
>> Here the application need not to do individual slave access for writing, instead it can send data to all the devices in one go.
>
> That's a *very* specific application which will only work for write only
> devices - I'd be surprised if such systems actually had distinct chip
> select lines at the CPU level.
>

Agreed that it is very specific but here are a few ways it is used
when communicating with two flash devices in parallel configuration:
- Write enable is sent to both devices using a single operation.
- Writing to any configuration registers in the flash is done in one go
- Some application that want to mirror important data to both devices.
Even with reading, the assertion of multiple cs combined with stripe
will mean:
- Two status bytes, one form each will be obtained in one operation
- Similarly data that was written using stripe is read back and combined.

Such systems could still maintain separate chip selects to perform
individual operations such as reading flash ID, debugging failures or
locking specific sectors.

Regards,
Harini
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
