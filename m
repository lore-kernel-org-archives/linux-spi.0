From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Thu, 31 Oct 2013 13:37:52 +0100
Message-ID: <1586287.qm633XfQbK@amdc1227>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com>
 <6043727.WVyVGYjJys@amdc1227>
 <CAPs=JDcVXpJJnWxRFpq7aoW98LKmHq0jo-oTVqSUasnO_1My3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@kernel.org>,
	Rajeshwari S Shinde <rajeshwari.s@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	linux-spi@vger.kernel.org, Simon Glass <sjg@chromium.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Doug Anderson <dianders@google.com>
To: Rajeshwari Birje <rajeshwari.birje@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAPs=JDcVXpJJnWxRFpq7aoW98LKmHq0jo-oTVqSUasnO_1My3g@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Rajeshwari,

On Thursday 31 of October 2013 16:17:15 Rajeshwari Birje wrote:
> Hi Mark Brown ,
> 
> On Wed, Oct 30, 2013 at 10:36 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> > On Wednesday 30 of October 2013 10:00:29 Mark Brown wrote:
> >> On Wed, Oct 30, 2013 at 11:52:54AM +0530, Rajeshwari Birje wrote:
> >>
> >> > The following patch already sets bits_per_word_mask for
> >> > drivers/spi/spi-s3c64xx.c in s3c64xx_spi_probe, hence I had a doubt do
> >> > I need to set the same again.
> >>
> >> OK, so how did this work before then?  You're just adding new code but
> >> the driver was previously claiming to support different bits per word
> >> (and now I look at the code there is some handling for that in code).
> >> Is this a bug fix?
> No idea if it worked before, but now if I try to do 16 bit transfer
> without my patch, I get following error.
> "Xfer length(1) not a multiple of word size(2)"
> I guess we can consider this as a bug fix then for word transfer.
> >
> > That's a good question. Rajeshwari, what SPI device did you test this
> > patch with? Does it have a driver in mainline kernel?
> @Tomasz: I tested it for W25Q32DW Winbond device which is already has
> a driver in mainline Kernel

The driver as of today's linux-next does not seem to support word
transfers. Do you have some additional, out of tree patches that add
such support?

Best regards,
Tomasz
