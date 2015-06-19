From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: Re: [PATCH] spi: expose spi_master and spi_device statistics via
 sysfs
Date: Fri, 19 Jun 2015 11:35:39 +0200
Message-ID: <20150619113539.04a7fcf2@north>
References: <1432574909-2326-1-git-send-email-kernel@martin.sperl.org>
	<556EE446.3060407@metafoo.de>
	<20150603115319.GF14071@sirena.org.uk>
	<8DBE5E2D-47ED-48D3-A185-82AF4831B0A2@martin.sperl.org>
	<B3BA7701-96E1-466A-90EA-121E2A85F851@martin.sperl.org>
	<20150618134918.GF14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150618134918.GF14071-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 18 Jun 2015 14:49:18 +0100, Mark Brown wrote:
> On Thu, Jun 18, 2015 at 02:54:35PM +0200, Martin Sperl wrote:
> 
> > Now that I am back here some examples from /sys which contain multiple values:
> > /sys/devices/platform/soc/20980000.usb/pools:
> 
> The fact that other people have broken the ABI doesn't mean it's a good
> idea to introduce further ABI breakage.

How about putting this file in debugfs after all?  Mark suggested it
initially but the conversation went in other direction.  Martin said
that his main purpose is to help *debugging* performance of RPi dma,
so it's a perfect candidate for debugfs.  I can't in my mind see any
use for this information on a production system to be honest...
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
