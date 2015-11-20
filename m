From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message
 length
Date: Fri, 20 Nov 2015 19:59:37 +0100
Message-ID: <564F6D99.8090203@gmail.com>
References: <564CEB61.2000601@gmail.com> <20151120000226.GP64635@google.com>
 <564EC4E0.90602@gmail.com>
 <CAFSsGVsJBi6yPin7X9MCS8LD6nygjynfgDgFicjojkm0rOJSJw@mail.gmail.com>
 <20151120123540.GC1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151120123540.GC1929-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 20.11.2015 um 13:35 schrieb Mark Brown:
> On Fri, Nov 20, 2015 at 11:06:47AM +0100, Heiner Kallweit wrote:
>> On Fri, Nov 20, 2015 at 7:59 AM, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
>>> It would be sufficient if it's a valid case that spi_master returns 0
>>> and an actual_length < requested_length as this is some kind of error
>>> situation.
> 
>> I had one more look at the SPI core and e.g. spi_write_then_read
>> calls spi_sync w/o checking actual_length afterwards.
>> This can mean the discussed case is not valid, however it also could be
>> simply a bug.
> 
> We can't assume that users of spi_write_then_read() will cope with a
> restarted transfer - the usual use case is things like register I/O
> where restarting a partial transfer wouldn't produce the desired result
> so it's just a plain error for users of that interface.  Anything that
> is able to cope needs to be using the core API directly.
> 
>> If the discussed case is valid a clear hint to all users of spi_sync and
>> friends should be added that the caller can not rely on status code 0
>> only but must check actual_length to verify that the complete message
>> was transferred.
> 
> You'll get an error on truncation.  It may be possible to recover.
> 
OK, I interpret this as:
Controller drivers shall return 0 only if the complete message was
transferred successfully.
If  a controller driver returns an error it has the option to set
actual_length to what was transferred successfully.

This means we can't use patch 4 from Michal because it bails out as soon
as the underlying SPI transfer returns an error.

Instead something like the spi-nor patch I sent on Oct 6th would be needed:
[PATCH] mtd: spi-nor: handle controller driver limitations in spi_nor_read

It loops over nor->read and ignores errors as long as at least something
was read.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
