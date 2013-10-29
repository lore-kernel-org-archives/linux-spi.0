From: Rajeshwari Birje <rajeshwari.birje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Tue, 29 Oct 2013 16:59:11 +0530
Message-ID: <CAPs=JDdzvnM5BzgRLhLsJrdwcVSwxd6x8_kFz0EvB=OjFfVszw@mail.gmail.com>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com>
	<20131019162504.GA1863@sirena.org.uk>
	<CAPs=JDeOqkJT32quBH1tF9FtFUOt=CHP7m6ZqzhfASM2uPj-dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rajeshwari S Shinde <rajeshwari.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPs=JDeOqkJT32quBH1tF9FtFUOt=CHP7m6ZqzhfASM2uPj-dw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark Brown,

Sorry for spamming again.

On Tue, Oct 29, 2013 at 4:29 PM, Rajeshwari Birje
<rajeshwari.birje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Mark,
>
> On Sat, Oct 19, 2013 at 9:55 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On Fri, Oct 18, 2013 at 11:02:36AM +0530, Rajeshwari S Shinde wrote:
>>> This patch enables word transfer for s3c64xx spi driver.
>>> User can set bits_per_word to 32 or 16 or 8, before calling
>>> spi_setup, which would enable the corresponding transfer mode.
>>
>>> Change-Id: Ib04f9851a3ea891d2bfa527f2100acd314fe1c98
>>
>> Please don't include stuff like this in upstrem submissions, it's of no
>> use to anyone outside your organisation.
> That had got added by mistake. Sorry for the same.
>>
>> This patch is still not setting bits_per_word_mask as far as I can see?
> Will send new version of patch including this.
I had some confusion regarding this bits_per_word_mask, where do you
want me to mask the bpw.
bits_per_word is something which comes from the user, do we need to mask it?


-- 
Regards,
Rajeshwari Shinde
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
