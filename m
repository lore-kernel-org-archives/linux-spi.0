From: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: only use up TX/RX bounce buffer space when
 needed
Date: Sun, 15 Feb 2015 10:40:22 +0000
Message-ID: <54E07796.1060501@mev.co.uk>
References: <1423743188-1821-1-git-send-email-abbotti@mev.co.uk> <20150214044910.GF9110@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150214044910.GF9110-bheZrs9scGb3/WHNxyQH9YN0K6Il/+VY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 14/02/15 04:49, Mark Brown wrote:
> On Thu, Feb 12, 2015 at 12:13:08PM +0000, Ian Abbott wrote:
>> Devices have separate, pre-allocated TX and RX bounce buffers of fixed
>> size.  Currently, each transfer uses up space in both buffers even if
>> the user-supplied no TX data or no RX space.  Change it to only use up
>> space in the TX and RX bounce buffers as required.
>
> This is a bit hard to parse.  [...]

I just noticed I typed "user-supplied" in the first paragraph when I 
meant to type "user supplied".

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
