From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: Fix the build warning with CONFIG_ARM_LPAE=y
Date: Tue, 12 Nov 2013 22:38:13 -0800
Message-ID: <CAOesGMhRoEvsQoSvoCSY=zm71zeZec3MG_FpHOy1zUkYronZcw@mail.gmail.com>
References: <1380567179-20174-1-git-send-email-santosh.shilimkar@ti.com>
	<20131001104840.GL19304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131001104840.GL19304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Tue, Oct 1, 2013 at 3:48 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Sep 30, 2013 at 02:52:59PM -0400, Santosh Shilimkar wrote:
>> With CONFIG_ARM_LPAE=y spi driver throws below warning
>
> Applied, thanks.

These warnings are showing up (again?), so wherever it was applied is
not making it into -next. Did it fall between the cracks?


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
