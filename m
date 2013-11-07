From: Rajeshwari Birje <rajeshwari.birje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Thu, 7 Nov 2013 14:52:36 +0530
Message-ID: <CAPs=JDctq1yRbuwnFH40dnQJJHF0C_D1p3iVokSPusPXA27Qeg@mail.gmail.com>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com>
	<6043727.WVyVGYjJys@amdc1227>
	<CAPs=JDcVXpJJnWxRFpq7aoW98LKmHq0jo-oTVqSUasnO_1My3g@mail.gmail.com>
	<1586287.qm633XfQbK@amdc1227>
	<CAPs=JDcHVe4q7R-3f3SBu8g=Ebkz57AbPN8e2jspVTGYnZ1vqA@mail.gmail.com>
	<20131106082141.GA11602@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Rajeshwari S Shinde <rajeshwari.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131106082141.GA11602-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark Brown,

On Wed, Nov 6, 2013 at 1:51 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Nov 06, 2013 at 10:23:07AM +0530, Rajeshwari Birje wrote:
>> On Thu, Oct 31, 2013 at 6:07 PM, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>
>> > The driver as of today's linux-next does not seem to support word
>> > transfers. Do you have some additional, out of tree patches that add
>> > such support?
>
>> Yes I set the bits_per_word to 32/16 in drivers/mtd/devices/m25p80.c
>> m25p_probe function and the call spi_setup(spi).
>
> This sound wrong.  If you just set bits per word then this should result
> in data corruption on the bus since it should cause the words written to
> the bus to be reordered.  Are you sure that the existing driver isn't
> working correctly?
The reordering of the words is taken care by the Swap configuration
(swap_cfg) register, which I have set for both 16 and 32 bits_per_word
case. I have tested this patch and works fine for me and also has
improved the timing performance.

-- 
Regards,
Rajeshwari Shinde
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
