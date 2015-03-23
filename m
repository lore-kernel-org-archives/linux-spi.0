From: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: fix possible arithmetic overflow for multi-transfer
 message
Date: Mon, 23 Mar 2015 19:29:15 +0000
Message-ID: <5510698B.3040000@mev.co.uk>
References: <1427133027-8134-1-git-send-email-abbotti@mev.co.uk> <20150323185042.GL14954@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150323185042.GL14954-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 23/03/15 18:50, Mark Brown wrote:
> On Mon, Mar 23, 2015 at 05:50:27PM +0000, Ian Abbott wrote:
>
>> Signed-off-by: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
>> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # 4.0+
>
> This doesn't apply against Linus' tree as far as I can tell - if you
> think this needs to go to stable please send a version that applies
> against that.
>

Sorry about that.  It applies to linux-next and might apply against 4.1, 
depending on the timing.

Can you strip the Cc line or do you want me to repost the patch?

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
