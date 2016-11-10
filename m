From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: Re: [PATCH] spi: rspi: avoid uninitialized variable access
Date: Thu, 10 Nov 2016 18:25:56 +0900
Message-ID: <58243D24.5080302@jinso.co.jp>
References: <20161108134624.1905209-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161108134624.1905209-1-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Arnd,

Thanks for your fixed patch.

On 11/08/2016 10:46 PM, Arnd Bergmann wrote:
> The newly introduced rspi_pio_transfer_in_or_our() function must
> take either a valid 'rx' or 'tx' pointer, and has undefined behavior
> if both are NULL, as found by 'gcc -Wmaybe-unintialized':
>
> drivers/spi/spi-rspi.c: In function 'rspi_pio_transfer_in_or_our':
> drivers/spi/spi-rspi.c:558:5: error: 'len' may be used uninitialized in this function [-Werror=maybe-uninitialized]
Could you tell me what kind of GCC are you using?
I'd like to reproduce it on my environment, too.
I am using the Linaro's gcc of 
"gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux".
But there is no error message like this on my environment.


Best regards,
Jinzai Solution Inc,
Hiep.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
