From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFC 3/3] spi: HiSilicon v3xx: Use DMI quirk to set
 controller buswidth override bits
Date: Fri, 28 Feb 2020 17:17:18 +0000
Message-ID: <a3b1711b-ed70-59d0-3326-991f1531db2b@huawei.com>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-4-git-send-email-john.garry@huawei.com>
 <20200228162057.GC4956@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200228162057.GC4956-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 28/02/2020 16:20, Mark Brown wrote:
> On Fri, Feb 28, 2020 at 11:18:51PM +0800, John Garry wrote:
>> The Huawei D06 board (and variants) can support Quad mode of operation.
>>
>> Since we have no current method in ACPI SPI bus device resource description
>> to describe this information, use DMI to detect the board, and set the
>> controller buswidth override bits.
> 
> Hopefully this is something that the ACPI people will be looking to
> address going forwards :/
> 

Yeah, well I did mention the bugzilla [0] I raised for this in the cover 
letter; but I think that the new process workflows to raise feature 
requests in this way still needs to be formalized, so this may be 
blocked for now [1].

And unfortunately I can't actively participate in relevant standards WGs 
either, so if anyone else would like to assist, then that would great...

BTW, I think that it might also be good to request a generic 
jedec-compatible SPI NOR part ACPI HID/CID here also.

Thanks,
John

[0] https://bugzilla.tianocore.org/show_bug.cgi?id=2557
[1] https://edk2.groups.io/g/devel/message/53420

> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
