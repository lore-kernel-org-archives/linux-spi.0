From: Rajeshwari Birje <rajeshwari.birje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Thu, 31 Oct 2013 16:17:15 +0530
Message-ID: <CAPs=JDcVXpJJnWxRFpq7aoW98LKmHq0jo-oTVqSUasnO_1My3g@mail.gmail.com>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com>
	<CAPs=JDeDbevjOtMH0y+9aVSbNSV4zmEQxWygtB-f69XzooSinQ@mail.gmail.com>
	<20131030170029.GK2493@sirena.org.uk>
	<6043727.WVyVGYjJys@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Rajeshwari S Shinde <rajeshwari.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
To: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6043727.WVyVGYjJys@amdc1227>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark Brown ,

On Wed, Oct 30, 2013 at 10:36 PM, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> On Wednesday 30 of October 2013 10:00:29 Mark Brown wrote:
>> On Wed, Oct 30, 2013 at 11:52:54AM +0530, Rajeshwari Birje wrote:
>>
>> > The following patch already sets bits_per_word_mask for
>> > drivers/spi/spi-s3c64xx.c in s3c64xx_spi_probe, hence I had a doubt do
>> > I need to set the same again.
>>
>> OK, so how did this work before then?  You're just adding new code but
>> the driver was previously claiming to support different bits per word
>> (and now I look at the code there is some handling for that in code).
>> Is this a bug fix?
No idea if it worked before, but now if I try to do 16 bit transfer
without my patch, I get following error.
"Xfer length(1) not a multiple of word size(2)"
I guess we can consider this as a bug fix then for word transfer.
>
> That's a good question. Rajeshwari, what SPI device did you test this
> patch with? Does it have a driver in mainline kernel?
@Tomasz: I tested it for W25Q32DW Winbond device which is already has
a driver in mainline Kernel
>
> Best regards,
> Tomasz
>
-- 
Regards,
Rajeshwari Shinde
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
