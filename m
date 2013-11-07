From: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Thu, 07 Nov 2013 10:39:37 +0100
Message-ID: <1546740.qqSm3Pi1hO@flatron>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com> <20131106082141.GA11602@sirena.org.uk> <CAPs=JDctq1yRbuwnFH40dnQJJHF0C_D1p3iVokSPusPXA27Qeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Rajeshwari S Shinde <rajeshwari.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Lukasz Czerwinski <l.czerwinski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: Rajeshwari Birje <rajeshwari.birje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPs=JDctq1yRbuwnFH40dnQJJHF0C_D1p3iVokSPusPXA27Qeg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

[CCing Sylwester, Andrzej and Lukasz]

On Thursday 07 of November 2013 14:52:36 Rajeshwari Birje wrote:
> Hi Mark Brown,
> 
> On Wed, Nov 6, 2013 at 1:51 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Wed, Nov 06, 2013 at 10:23:07AM +0530, Rajeshwari Birje wrote:
> >> On Thu, Oct 31, 2013 at 6:07 PM, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> 
wrote:
> >> > The driver as of today's linux-next does not seem to support word
> >> > transfers. Do you have some additional, out of tree patches that
> >> > add
> >> > such support?
> >> 
> >> Yes I set the bits_per_word to 32/16 in drivers/mtd/devices/m25p80.c
> >> m25p_probe function and the call spi_setup(spi).
> > 
> > This sound wrong.  If you just set bits per word then this should
> > result in data corruption on the bus since it should cause the words
> > written to the bus to be reordered.  Are you sure that the existing
> > driver isn't working correctly?
> 
> The reordering of the words is taken care by the Swap configuration
> (swap_cfg) register, which I have set for both 16 and 32 bits_per_word
> case. I have tested this patch and works fine for me and also has
> improved the timing performance.

This driver seems to have already worked fine with 32 bits per word,
using the s5c73m3 camera sensor, which uses SPI for firmware upload.

Sylwester, Andrzej or Lukasz: Can you confirm this?

Best regards,
Tomasz

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
