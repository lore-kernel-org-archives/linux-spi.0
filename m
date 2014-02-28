From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: Re: [PATCH v3] spi: core: Validate length of the transfers in
 message
Date: Fri, 28 Feb 2014 22:55:37 +0900 (JST)
Message-ID: <20140228.225537.367613748.anemo@mba.ocn.ne.jp>
References: <20140226001407.GM2927@sirena.org.uk>
	<20140227.223826.522636360.anemo@mba.ocn.ne.jp>
	<20140228061920.GG29849@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org, gsi-ynQEQJNshbs@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140228061920.GG29849-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 28 Feb 2014 15:19:20 +0900, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> I don't object to the whole patch.  Validating in spi core is good of
>> course, and "xfer->len % w_size" part looks no problem.
> 
>> I just want to keep ways to handle an odd device, for example, which
>> requires long delay between chipselect and the first transfer, etc.
> 
> Can you submit a patch adding that support back please?

OK, I will send a patch against spi.git/for-next branch.

---
Atsushi Nemoto
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
