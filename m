From: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] spi/fsl-espi: fix rx_buf in fsl_espi_cmd_trans()/fsl_espi_rw_trans()
Date: Tue, 20 May 2014 17:07:13 +0200
Message-ID: <537B6FA1.5080200@keymile.com>
References: <1400251581-26617-1-git-send-email-valentin.longchamp@keymile.com> <20140516190723.GT22111@sirena.org.uk> <537A2390.4070203@keymile.com> <20140519162200.GD12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linux SPI <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Marshall <markmarshall14-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140519162200.GD12304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 05/19/2014 06:22 PM, Mark Brown wrote:
> On Mon, May 19, 2014 at 05:30:24PM +0200, Valentin Longchamp wrote:
>> Or are you talking about the initial memcpy call that fills up the local buffer
>> in both rw_trans() and cmd_trans() ? And maybe your second point with the
>> scatterlists is about replacing these memcpy calls ?
> 
> We shouldn't need this copy at all and therefore there should be no need
> to make sure it is copying into an adequately sized buffer.  The only
> thing I can think that the memcpy() is for is ensuring that the data is
> sent from a physically contiguous buffer but scatter/gather should
> handle that.
> 

OK I see your point. The problem is that I currently have no time to write/test
a patch that replaces this unnecessary memcpy() to the buffer with
scatter/gather, it will have to wait a bit.

On the other hand, the patch I have sent fixes a buffer overflow with the
current implementation so it could be good to take it if I don't send another
patch with the above improvement.

Valentin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
