From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] mtd: m25p80: consider max_transfer_size when reading
Date: Sat, 4 Jun 2016 00:22:37 +0200
Message-ID: <77a22258-95ca-031a-825d-a9e98e30a162@gmail.com>
References: <56D22823.7090005@gmail.com> <20160405193952.GA5243@localhost>
 <57041B43.2000109@gmail.com> <20160405210727.GB5243@localhost>
 <5706B084.2070909@gmail.com> <20160505235700.GA99474@google.com>
 <20160506121431.GQ6292@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160506121431.GQ6292-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 06.05.2016 um 14:14 schrieb Mark Brown:
> On Thu, May 05, 2016 at 04:57:00PM -0700, Brian Norris wrote:
>> On Thu, Apr 07, 2016 at 09:09:56PM +0200, Heiner Kallweit wrote:
> 
>>> 2. At least in the case of fsl-espi the size limit refers to one
>>>    physical transfer (including the command) and therefore to the sum
>>>    of all transfers.
>>> We should change
>>> +	t[1].len = min_t(size_t, len, spi_max_transfer_size(spi));
>>> to
>>> +	t[1].len = min(len, spi_max_transfer_size(spi) - t[0].len);
>>>
>>> Apart from that the patch set looks good to me.
> 
>> That's not what Mark specified here:
> 
>> http://lists.infradead.org/pipermail/linux-mtd/2015-November/063616.html
> 
>> and that's not what the API's very *name* means; it says max transfer
>> size (where a spi_transfer is a very well-defined concept). You need to
>> fix the driver or take up the API issues with Mark if you want to
>> suggest we interpret this differently.
> 
> Yes, it's called the maximum transfer size because it is the maximum
> size of a transfer, not because it's the maximum size of a message.
> 
I'd like to come back to this discussion. You said best would be to fix
the chip driver. To do this and calculate an appropriate value for
max_transfer_size the chip driver would have to know that the spi_device
is a spi-nor device.
We could check that the name of the driver bound to the spi-device is m25p80.
This doesn't sound very nice.

Or maybe better, struct spi_device could be extended by a pointer to a struct spi_nor.
This comment in the definition of struct spi_device seems to point in this direction:
"likely need more hooks for more protocol options affecting how the controller
talks to each chip"
Just storing the length of the read command + dummy bytes would also be sufficient.
Could this be a feasible way?

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
