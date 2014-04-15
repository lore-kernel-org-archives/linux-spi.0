From: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi: cadence: Add dependency on ARCH_ARM
Date: Tue, 15 Apr 2014 16:10:55 +0530
Message-ID: <CAFcVECJ+DADKdUdqSz8VHWTOYyphEjCJd9s-fVeC3uR7XfyjgQ@mail.gmail.com>
References: <1397556735-2536-1-git-send-email-harinik@xilinx.com>
	<1397557331.1985.36.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397557331.1985.36.camel@x220>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Tue, Apr 15, 2014 at 3:52 PM, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org> wrote:
> On Tue, 2014-04-15 at 15:42 +0530, Harini Katakam wrote:
>> Add dependency on ARCH_ARM in Kconfig.
>> This is to fix the build error related to _relaxed IO.
>>
>> Signed-off-by: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>> ---
>>
>> v2 changes:
>> Dependency on ARCH_ARM instead of restricting to ARCH_ZYNQ.
>>
>> ---
>>  drivers/spi/Kconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index b0f091b..32c27dd 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -150,6 +150,7 @@ config SPI_BUTTERFLY
>>
>>  config SPI_CADENCE
>>       tristate "Cadence SPI controller"
>> +     depends on ARCH_ARM
>
> Did you mean just ARM?

Please ignore patch, I will resend it.

Regards,
Harini
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
