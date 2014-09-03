From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: atmel: remove unnecessary #if defined(CONFIG_OF)
Date: Wed, 03 Sep 2014 10:25:02 +0900
Message-ID: <009801cfc715$e27d8030$a7788090$%han@samsung.com>
References: <002a01cfc65d$2dc86640$895932c0$%han@samsung.com>
 <002b01cfc65d$569ef570$03dce050$%han@samsung.com>
 <20140902105018.GR29327@sirena.org.uk>
 <CAMuHMdU2S_vwv3=CUtgGjqnq-nbh=up42gDWzR35ai6s4ZVaWQ@mail.gmail.com>
 <20140902163658.GA29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: 'linux-spi' <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	'Nicolas Ferre' <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Axel Lin' <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
	'Max Filippov' <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	'Geert Uytterhoeven' <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20140902163658.GA29327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday, September 03, 2014 1:37 AM, Mark Brown wrote:
> On Tue, Sep 02, 2014 at 02:15:09PM +0200, Geert Uytterhoeven wrote:
> > On Tue, Sep 2, 2014 at 12:50 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > > On Tue, Sep 02, 2014 at 12:24:00PM +0900, Jingoo Han wrote:
> > >> Remove unnecessary  #if defined(CONFIG_OF), because this is
> > >> already handled by the of_match_ptr macro.
> 
> > > Applied, thanks.
> 
> > If CONFIG_OF is not set, binary size is increased, as the OF match
> > table is still emitted, while it's no longer in use:
> 
> OK, I've discarded the series.

(+cc Axel Lin, Max Filippov)

OK, I see. I appreciate Geert's feedback. :-)

However, personally I don't like #ifdef guards. I think that
#ifdef guards can be removed for the same binary, regardless
of kernel config options.

In this case, the binary size is more important than #ifdef guards,
right?

Best regards,
Jingoo Han

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
