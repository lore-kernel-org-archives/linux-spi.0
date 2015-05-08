From: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: Re: [PATCH 1/1 v2] spi: Re-do the returning value of rspi_dma_check_then_transfer
Date: Fri, 08 May 2015 10:35:03 +0900
Message-ID: <554C12C7.4030302@jinso.co.jp>
References: <1430359932-13245-1-git-send-email-cm-hiep@jinso.co.jp> <1430359932-13245-2-git-send-email-cm-hiep@jinso.co.jp> <20150507125744.GX15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org,
	ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150507125744.GX15510-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark-san

On 2015=E5=B9=B405=E6=9C=8807=E6=97=A5 21:57, Mark Brown wrote:
> On Thu, Apr 30, 2015 at 11:12:12AM +0900, Cao Minh Hiep wrote:
>> From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
>>
>> To reduce indentation and complexity of code, insteeds of returning =
zero
>> the function rspi_dma_check_then_transfer should return rspi_dma_tra=
nsfer
>> directly after checking error.
> Applied, thanks.  Please use subject lines reflecting the style for t=
he
> subsystem and don't send cover letters for single patches - if there'=
s
> any content in there it's usually a sign that the changelog is not
> detailed enough.
Thank you!, I understood.

Hiep.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
