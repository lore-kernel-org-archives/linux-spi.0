From: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Subject: RE: [PATCH] spi: Remove duplicate code to set default bits_per_word
 setting
Date: Fri, 17 Jan 2014 13:05:14 +0000
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E9012BC15F30@SHAASIEXM01.ASIA.ROOT.PRI>
References: <1389956020.6412.5.camel@phoenix>,<201401171355.27291.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>,
	Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	DL-SHA-WorkGroupLinux <DL-SHA-WorkGroupLinux-z7JfP6tgrtVrifDez5n5bw@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201401171355.27291.marex-ynQEQJNshbs@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Friday, January 17, 2014 at 11:53:40 AM, Axel Lin wrote:
> The implementation in spi_setup() already set spi->bits_per_word = 8 when
> spi->bits_per_word is 0 before calling spi->master->setup.
> So we don't need to do it again in setup() callback.
>
> Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> Cc: Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Cc: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
> Cc: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

Acked-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>

for CSR sirfsoc.

-barry



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
