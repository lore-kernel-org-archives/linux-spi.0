From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message
 length
Date: Wed, 18 Nov 2015 23:50:00 +0100
Message-ID: <564D0098.4030107@gmail.com>
References: <564CEB61.2000601@gmail.com>
 <20151118215755.GL31303@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151118215755.GL31303-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 18.11.2015 um 22:57 schrieb Mark Brown:
> On Wed, Nov 18, 2015 at 10:19:29PM +0100, Heiner Kallweit wrote:
>> There have been few discussions in the past about how to handle SPI controller
>> limitations like max message length. However they don't seem to have resulted
>> in accepted patches yet.
> 
> No, they've resulted in people writing code.  We've got a bunch of
> things in the spi_master struct like the limits on speeds and bits per
> word.
> 
Sure, I'm aware of this. To you it might sound obvious to handle such
limitations in the SPI core, however there have been several attempts
to deal with such limitations in controller or protocol drivers.

>> Maybe a better approach would be to introduce a new member of spi_master
>> dealing with controller limitations.
> 
> That's what we've been doing...
> 
Primary addressees of my comment were users of the SPI core trying to deal
in their own code with things which might be better dealt with in the core.
Again, for you it's obvious ..
Just one more comment:
In case there should be more need to reflect such limitations in spi_master
it might be good to encapsulate them in a separate struct instead of adding
more such members to spi_master directly.

>> I also add an example how a protocol driver could use this extension.
>> Appreciate any comment.
>>
>>
>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
>> index 269e8af..8a27c66 100644
> 
> Please don't send patches without a signoff, see SubmittingPatches.
> 
It wasn't meant to be actual patches, therefore I omitted some stuff
and didn't use [PATCH] in the subject.
It was meant just to be code snippets providing a little more detail.

Thanks for the comment anyway.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
