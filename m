From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: Re: [PATCH 0/1] spi: sc18is602: Add reset control via gpio pin.
Date: Thu, 1 Sep 2016 09:47:23 +0800
Message-ID: <fecfdf07-a3e6-c84d-31dc-b1e2b7486868@electromag.com.au>
References: <1472628698-10599-1-git-send-email-preid@electromag.com.au>
 <20160831144934.GA5967@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160831144934.GA5967-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 31/08/2016 22:49, Mark Brown wrote:
> On Wed, Aug 31, 2016 at 03:31:37PM +0800, Phil Reid wrote:
>> I didn't not check for null on devm_gpiod_get_optional as gpiod_set_value
>> does this on entry. Frequency of this seemed low enough that the function
>> call doesn't add any significant overhead. I can add a check if required.
>
> Please don't send cover letters for single patches, if there is anything
> that needs saying put it in the changelog of the patch or after the ---
> if it's administrative stuff.  This reduces mail volume and ensures that
> any important information is recorded in the changelog rather than being
> lost.
>
Ok.
Would you like me to resubmit the patch?


-- 
Regards
Phil Reid

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
