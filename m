From: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: Re-do the returning value of rspi_dma_check_then_transfer
Date: Thu, 30 Apr 2015 09:33:38 +0900
Message-ID: <55417862.4010800@jinso.co.jp>
References: <1430200551-20708-1-git-send-email-cm-hiep@jinso.co.jp> <1430200551-20708-2-git-send-email-cm-hiep@jinso.co.jp> <553F72F1.9010300@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org,
	ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>,
	geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <553F72F1.9010300-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Sergei-san,

>> To reduce indentation and complex of code, insteeds of returning zero,
>
>    Complexity?
>

>> the function rspi_dma_check_then_transfer should be returned
>
>    Returning? Or perhaps just "return", without "be"?
>

Thanks for pointing this out. I'll update it.


Hiep.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
