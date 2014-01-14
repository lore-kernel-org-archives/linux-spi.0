From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: fix build warning when printing resource_size_t
 vars
Date: Tue, 14 Jan 2014 09:41:48 -0500
Message-ID: <52D54CAC.1050005@ti.com>
References: <20140112110916.GR15937@n2100.arm.linux.org.uk> <1389707408-24785-1-git-send-email-grygorii.strashko@ti.com> <20140114143945.GP15567@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>,
	<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <nsekhar-l0cyMroinI0@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140114143945.GP15567-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday 14 January 2014 09:39 AM, Mark Brown wrote:
> On Tue, Jan 14, 2014 at 03:50:08PM +0200, Grygorii Strashko wrote:
>> Use %pa format specifier when printing variables of resource_size_t type
>> to fix build warnings:
>> drivers/spi/spi-davinci.c:966:3: warning: format '%d' expects argument of type 'int', but argument 3 has type 'resource_size_t'
>> drivers/spi/spi-davinci.c:966:3: warning: format '%d' expects argument of type 'int', but argument 4 has type 'resource_size_t'
> 
> This doesn't apply against current code, it seems the same patch has
> already been applied.
> 
Yeah. I did send same patch last merge window time-frame which has been
applied by you.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
