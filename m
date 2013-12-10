From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 05/11] spi: nuc900: Use devm_*() functions
Date: Tue, 10 Dec 2013 14:57:55 +0900
Message-ID: <000401cef56c$c5758710$50609530$%han@samsung.com>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
 <001101cef4c7$fb071e20$f1155a60$%han@samsung.com>
 <CAKT61h9D=mSqTshn4RxHJpBWkaoEtSCom_N1MvYdF5FxR8hy=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Axel Lin' <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Wan ZongShun' <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CAKT61h9D=mSqTshn4RxHJpBWkaoEtSCom_N1MvYdF5FxR8hy=w@mail.gmail.com>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday, December 10, 2013 2:52 PM, Wan ZongShun wrote:
> 2013/12/9 Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
> > Use devm_*() functions to make cleanup paths simpler.
> >
> > Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/spi/spi-nuc900.c |   50 ++++++++++------------------------------------
> >  1 file changed, 10 insertions(+), 40 deletions(-)

[.....]

> Great, thanks for your help.
> 
> Acked-by: <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hi Wan ZongShun,

I really appreciate your feedback.
For clarity, it can be the following. :-)

Acked-by: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Best regards,
Jingoo Han

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
