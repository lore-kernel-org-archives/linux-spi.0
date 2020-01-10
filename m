From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Fri, 10 Jan 2020 11:55:37 +0000
Message-ID: <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, <fengsheng5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
        <chenxiang66-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200109212842.GK3702-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 09/01/2020 21:28, Mark Brown wrote:
> On Thu, Jan 09, 2020 at 03:54:00PM +0000, John Garry wrote:
> 
>>  From checking acpi_spi_add_resource() or anywhere else, I cannot see how
>> SPI_RX_DUAL or the others are set for spi_device.mode. What am I missing?
>> Are these just not supported yet for ACPI? Or should the spi-nor code not be
>> relying on this since we should be able to get this info from the SPI NOR
>> part?
> 

Hi Mark,

> I'm not aware of any work on integrating this sort of stuff into ACPI
> platforms so I think it's just not yet supported in ACPI.  I'm not
> really sure what would be idiomatic for ACPI, figuring it out from what
> the part supports might well be idiomatic there though I don't know how
> common it is for people not to wire up all the data lines even if both
> controller and device support wider transfers. 

OK, so I guess that is why we require the width property from the FW and 
can't blindly rely on SFDP.

  I've got a horrible
> feeling that the idiomatic thing is a combination of that and a bunch of
> per-device quirks.  There may be a spec I'm not aware of though I'd be a
> bit surprised.
> 

I'm not sure on that. I don't see anything in the ACPI spec.

I will note that PRP0001+"jedec,spi-nor" compatible DSD seems to be the 
defacto method to describe the SPI NOR-compat part for ACPI - that's 
what I'm using. We could add properties there, but that seems improper.

I'll continue to look....

Thanks,
John
