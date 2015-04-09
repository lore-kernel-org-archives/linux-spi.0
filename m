From: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 4/5] spi: bcm-mspi: Make BCMA optional to support non-BCMA
 chips
Date: Thu, 9 Apr 2015 15:26:29 -0700
Message-ID: <5526FC95.1000500@broadcom.com>
References: <1428516275-12819-1-git-send-email-jonathar@broadcom.com> <1428516275-12819-5-git-send-email-jonathar@broadcom.com> <20150408200306.GM6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"Ian Campbell" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rafal Milecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150408200306.GM6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 15-04-08 01:03 PM, Mark Brown wrote:
> On Wed, Apr 08, 2015 at 11:04:34AM -0700, Jonathan Richardson wrote:
> 
>>   - A new config for non-BCMA chips has been added.
>>   - Common code between the BCMA and non BCMA version are shared.
>>   - Function pointers to set read/write functions to abstract bcma
>>     and non-bcma versions are provided.
>>   - DT is now mandatory. Hard coded SPI devices are removed and must be
>>     set in DT.
>>   - Remove function was unnecessary and removed.
> 
> This looks like it should be a patch series in itself - for example, the
> move to using function pointers as a read/write operation looks like
> something that could easily be pulled out, as could the removal of
> unused functions.  Having things split out makes life a lot easier for
> review since it makes it much easier to check if the change is doing the
> things it's supposed to be doing.
> 

Mark, thanks for the comments. I think we need a new driver instead of
trying to re-use the existing driver that requires quite a few changes
and that I also can't test. Having both drivers in the same file doesn't
work well either. Common code isn't desirable because we're likely going
to make changes to it anyway. It doesn't use interrupts currently and I
don't like the polling for SPI transfer completion. Once I make the
changes I'll submit a standalone non-BCMA MSPI driver for review.

Jon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
