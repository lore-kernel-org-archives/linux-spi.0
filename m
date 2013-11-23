From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: Fix the build warning with CONFIG_ARM_LPAE=y
Date: Sat, 23 Nov 2013 16:17:24 -0500
Message-ID: <52911B64.3020009@ti.com>
References: <1380567179-20174-1-git-send-email-santosh.shilimkar@ti.com> <20131001104840.GL19304@sirena.org.uk> <CAOesGMhRoEvsQoSvoCSY=zm71zeZec3MG_FpHOy1zUkYronZcw@mail.gmail.com> <20131113132952.GK878@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131113132952.GK878-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Mark,

On Wednesday 13 November 2013 08:29 AM, Mark Brown wrote:
> On Tue, Nov 12, 2013 at 10:38:13PM -0800, Olof Johansson wrote:
>> On Tue, Oct 1, 2013 at 3:48 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
>>> Applied, thanks.
> 
>> These warnings are showing up (again?), so wherever it was applied is
>> not making it into -next. Did it fall between the cracks?
> 
> Looks lie it never got pushed and nobody looked at the warnings for over
> a month.  Oh well, sorry about that.
> 
Are you going to push this one ? The warning is still showing up at
3.13-rc1.

Regards,
Santosh 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
