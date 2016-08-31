From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH 0/1] spi: sc18is602: Add reset control via gpio pin.
Date: Wed, 31 Aug 2016 15:31:37 +0800
Message-ID: <1472628698-10599-1-git-send-email-preid@electromag.com.au>
Cc: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

I didn't not check for null on devm_gpiod_get_optional as gpiod_set_value
does this on entry. Frequency of this seemed low enough that the function
call doesn't add any significant overhead. I can add a check if required.

Phil Reid (1):
  spi: sc18is602: Add reset control via gpio pin.

 drivers/spi/spi-sc18is602.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
