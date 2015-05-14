From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bcm-mspi: Add support for Broadcom MSPI driver.
Date: Thu, 14 May 2015 14:43:14 -0700
Message-ID: <555516F2.6080201@gmail.com>
References: <1431452293-16697-1-git-send-email-jonathar@broadcom.com> <1431452293-16697-3-git-send-email-jonathar@broadcom.com> <20150512191718.GW3066@sirena.org.uk> <5553E31A.8060309@broadcom.com> <5553E9FA.4070708@broadcom.com> <20150514103144.GO2761@sirena.org.uk> <5554E715.7070203@broadcom.com> <20150514190823.GR2761@sirena.org.uk> <5554FDB4.50809@broadcom.com> <20150514201221.GX2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150514201221.GX2761-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 14/05/15 13:12, Mark Brown wrote:
> On Thu, May 14, 2015 at 12:55:32PM -0700, Jonathan Richardson wrote:
>> On 15-05-14 12:08 PM, Mark Brown wrote:
> 
>>> All it takes is one hardware engineer who sees a SPI controller and a
>>> GPIO they can use for chip select; I wouldn't be so sure that nobody
>>> ever fixed this up locally (or happened to use a device that only needed
>>> single duplex).
> 
>> Hi Mark. Would it help if we just set the flags to half duplex using
>> SPI_MASTER_HALF_DUPLEX when we register the master?
> 
> That would deal with the data corruption issues, yes.  Though it seems
> like there are some people who want full duplex support here - I don't
> know if any of them can point you at suitable hardware to test?

I am fine with having the driver supporting only half-duplex for now,
considering that Jonathan and Scott have no peripheral to test
full-duplex with.

Getting you platforms and test setups could take more time than needed
so, let's proceed with the shortest path.
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
