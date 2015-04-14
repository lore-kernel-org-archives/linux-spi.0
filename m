From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: Add GPIOLIB dependency
Date: Tue, 14 Apr 2015 02:01:20 -0700
Message-ID: <552CD760.4060902@roeck-us.net>
References: <1428985488-3811-1-git-send-email-linux@roeck-us.net> <B320F6B6-23A4-4ECF-9B16-2C177D9EE96F@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, jim.epost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B320F6B6-23A4-4ECF-9B16-2C177D9EE96F-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 04/13/2015 10:48 PM, Martin Sperl wrote:
>
>> On 14.04.2015, at 06:24, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
>>
>> by adding the now mandatory GPIOLIB dependency.
>>
> Note this shows up during automated randconfig testing.
>

Also for m68k:allmodconfig and mips:allmodconfig in both mainline and -next.

http://server.roeck-us.net:8010/builders/hwmon-m68k-master/builds/129
http://server.roeck-us.net:8010/builders/hwmon-mips-master/builds/129

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
