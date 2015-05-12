From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: enable dma modes for transfers meeting
 certain conditions
Date: Mon, 11 May 2015 20:45:36 -0600
Message-ID: <55516950.5070105@wwwdotorg.org>
References: <1431290849-11151-1-git-send-email-kernel@martin.sperl.org> <20150511182448.GW3458@sirena.org.uk> <F47F6B62-3DC6-47C9-AD72-BE7DDABD3AE6@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	=?windows-1252?Q?Noralf_Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F47F6B62-3DC6-47C9-AD72-BE7DDABD3AE6-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 05/11/2015 01:38 PM, Martin Sperl wrote:
> 
>> On 11.05.2015, at 20:24, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>
>> Applied, thanks.
> 
> Found one typo with the logic - it only does one specific
> check for TX twice instead of for rx_buf and tx_buf:
> 	if (((u32)tfr->tx_buf % 4 == 0) && ((u32)tfr->tx_buf % 4 == 0))
> 
> On top there have been some build-reports about SZ_4K not being defined
> so I guess that there is an include <linux/sizes.h> missing.
> 
> as well as a warning about a pointer cast to u32 on 64 bit systems.
> 	if (((u32)tfr->tx_buf % 4 == 0) && ((u32)tfr->tx_buf % 4 == 0))
> 	if (((u32)tfr->rx_buf % SZ_4K) + tfr->len > SZ_4K) {
> I assume fixable by using size_t instead of u32.
> 
> Do you want me to send a patch to fix those, or shall I resend the full
> patch with those issues fixed?

Since the patch has been applied, you'll need to send an incremental patch.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
