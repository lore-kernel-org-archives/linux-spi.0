From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: expose spi_master and spi_device statistics via sysfs
Date: Thu, 4 Jun 2015 18:56:39 +0200
Message-ID: <8DBE5E2D-47ED-48D3-A185-82AF4831B0A2@martin.sperl.org>
References: <1432574909-2326-1-git-send-email-kernel@martin.sperl.org> <556EE446.3060407@metafoo.de> <20150603115319.GF14071@sirena.org.uk>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150603115319.GF14071-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



> On 03.06.2015, at 13:53, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
>> On Wed, Jun 03, 2015 at 01:25:58PM +0200, Lars-Peter Clausen wrote:
>> 
>> Having those kinds of stats in world readable files has serious security
>> implications as they can be used to implement side-channel attacks. They
>> should probably only be available in debugfs for root.
> 
> We do get to control the permissions on sysfs files, though it's a bit
> more unusual to make things root only (and there is the histogram).

I left histogram as a single file because I remember having seen a file in
/sys with similar semantics using multiple values (but I can not
remember which one).

I can remove it when I get back near my development box in a little
more than a week.

As for side channel attacks: the information is there already.
E.g the number of Interrupts for the spi device in /proc/interrupts
This could also be used as an indicator for the number of spi 
transfers handled, so I do not see a huge difference...

If you want it as root only - we can do it, but I wonder if it is
making a real difference...


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
