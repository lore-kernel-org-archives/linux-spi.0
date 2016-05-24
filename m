From: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus number.
Date: Tue, 24 May 2016 16:34:50 -0700
Message-ID: <5744E51A.1040506@gmail.com>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se> <20160524172045.GN8206@sirena.org.uk> <57449784.4070108@weinigel.se> <20160524183256.GP8206@sirena.org.uk>
Reply-To: frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160524183256.GP8206-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 5/24/2016 11:32 AM, Mark Brown wrote:
> On Tue, May 24, 2016 at 08:03:48PM +0200, Christer Weinigel wrote:
>> On 05/24/2016 07:20 PM, Mark Brown wrote:
> 
>>> I'm not sure this is something we want to support at all, I can't 
>>> immediately see anything that does this deliberately in the SPI
>>> code and obviously the "bus number" is something of a Linux
>>> specific concept which would need some explanation if we were going
>>> to document it.  It's something I'm struggling a bit to see a
>>> robust use case for that isn't better served by parsing sysfs,
>>> what's the goal here?
> 
>> If this isn't something that should be in the Documentation/devicetree
>>  because it's not generig enough, where should Linux-specific
>> interpretations such as this be documented?
> 
> I'm not clear that we want to document this at all since I am not clear
> that there is a sensible use case for doing it.  I did ask for one but
> you've not articulated one in this reply.  I am much less gung ho than
> Grant on this one, even as a Linux specific interface it seems very
> legacy.
> 

The time for the use case was when the patch was accepted.

It is in the kernel, it is appropriate to document it.

-Frank
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
