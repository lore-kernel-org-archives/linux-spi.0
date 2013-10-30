From: Rajeshwari Birje <rajeshwari.birje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Wed, 30 Oct 2013 11:52:54 +0530
Message-ID: <CAPs=JDeDbevjOtMH0y+9aVSbNSV4zmEQxWygtB-f69XzooSinQ@mail.gmail.com>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com>
	<20131019162504.GA1863@sirena.org.uk>
	<CAPs=JDeOqkJT32quBH1tF9FtFUOt=CHP7m6ZqzhfASM2uPj-dw@mail.gmail.com>
	<CAPs=JDdzvnM5BzgRLhLsJrdwcVSwxd6x8_kFz0EvB=OjFfVszw@mail.gmail.com>
	<20131029163926.GA6776@sirena.org.uk>
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
In-Reply-To: <20131029163926.GA6776-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark Brown,

On Tue, Oct 29, 2013 at 10:09 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Oct 29, 2013 at 04:59:11PM +0530, Rajeshwari Birje wrote:
>> On Tue, Oct 29, 2013 at 4:29 PM, Rajeshwari Birje
>
>> >> This patch is still not setting bits_per_word_mask as far as I can see?
>
>> > Will send new version of patch including this.
>
>> I had some confusion regarding this bits_per_word_mask, where do you
>> want me to mask the bpw.
>> bits_per_word is something which comes from the user, do we need to mask it?
>
> Have you looked at the code and documentation for this feature - if it's
> not clear can you please explain in more detail what needs clarifying?

The following patch already sets bits_per_word_mask for
drivers/spi/spi-s3c64xx.c in s3c64xx_spi_probe, hence I had a doubt do
I need to set the same again.

commit e761f4236e94f2dd36316f9892583b29ce986031
Author: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Date:   Mon Apr 1 14:17:37 2013 +0100

    spi/s3c64xx: Convert to bits_per_word_mask

    The core can do the validation for us.

    Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>

It is already present as follows in s3c64xx_spi_probe
master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
                                        SPI_BPW_MASK(8);
-- 
Regards,
Rajeshwari Shinde
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
