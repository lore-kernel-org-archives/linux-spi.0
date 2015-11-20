From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message length
Date: Fri, 20 Nov 2015 20:44:01 +0100
Message-ID: <CAOMqctSCMO93BWD0HOAmKniZLmZkXvXG5hbUQ3kD9PrxNzKw+w@mail.gmail.com>
References: <564CEB61.2000601@gmail.com> <20151120000226.GP64635@google.com>
 <564EC4E0.90602@gmail.com> <CAFSsGVsJBi6yPin7X9MCS8LD6nygjynfgDgFicjojkm0rOJSJw@mail.gmail.com>
 <20151120123540.GC1929@sirena.org.uk> <564F6D99.8090203@gmail.com>
 <CAOMqctTt=78C4m2jjMb9mRBOkoZ5uZ4neVm0NS39iNO8otn=dA@mail.gmail.com> <20151120192157.GF1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151120192157.GF1929-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 20 November 2015 at 20:21, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Nov 20, 2015 at 08:05:48PM +0100, Michal Suchanek wrote:
>
>> I don't think ignoring errors in general is good idea.
>
>> If it's desirable that a partial transfer is reported as error then a
>> particular error value should be defined for this case and drivers
>> that can continue the transfer in a driver-specific way (such as
>> spi-nor) can check for this error and handle it appropriately and pass
>> through any other error.
>
> Fundamentally callers just shouldn't be trying to do excessively large
> transfers in the first place, this is why we want capability reporting.
> *Any* error code could indicate a truncation, we may have truncated due
> to some length limitation but it could also be that there was some
> hardware problem that occurred mid transfer or something similar.

Indeed, and in the case the SPI master driver truncated the message
due to known limitation before it even attempted a transfer it can
assure with as much certainty as is possible with SPI bus that this
much data was transferred, no more and no less. In contrast, a DMA
failure that is detected after the fact can leave the hardware in
unknown state. So I see a difference here.

And yes, for some driver protocols transferring less data than was
initially requested is not acceptable. For example, if you transferred
Ethernet frames to an Ethernet controller the frames must be
transferred fully.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
