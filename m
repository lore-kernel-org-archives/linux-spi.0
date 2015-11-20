From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message
 length
Date: Fri, 20 Nov 2015 20:37:23 +0100
Message-ID: <564F7673.40205@gmail.com>
References: <564CEB61.2000601@gmail.com> <20151120000226.GP64635@google.com>
 <564EC4E0.90602@gmail.com>
 <CAFSsGVsJBi6yPin7X9MCS8LD6nygjynfgDgFicjojkm0rOJSJw@mail.gmail.com>
 <20151120123540.GC1929@sirena.org.uk> <564F6D99.8090203@gmail.com>
 <20151120191842.GE1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151120191842.GE1929-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 20.11.2015 um 20:18 schrieb Mark Brown:
> On Fri, Nov 20, 2015 at 07:59:37PM +0100, Heiner Kallweit wrote:
> 
>> OK, I interpret this as:
>> Controller drivers shall return 0 only if the complete message was
>> transferred successfully.
> 
> Yes.
> 
>> If  a controller driver returns an error it has the option to set
>> actual_length to what was transferred successfully.
> 
> It should always do this.
> 
>> This means we can't use patch 4 from Michal because it bails out as soon
>> as the underlying SPI transfer returns an error.
> 
> I haven't seen that patch.
> 
Sorry, this was addressed to Brian. It's about a mtd spi-nor patch.
http://lists.infradead.org/pipermail/linux-mtd/2015-August/061062.html
Most likely neither you nor linux-spi was on cc.
(Oh, it was patch 7 of the series, not 4.)

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
