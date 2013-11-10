From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Sun, 10 Nov 2013 18:26:34 +0100
Message-ID: <3104102.55j2C8XQ5u@flatron>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com> <1546740.qqSm3Pi1hO@flatron> <20131108110517.GK2493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Rajeshwari Birje <rajeshwari.birje@gmail.com>,
	Tomasz Figa <t.figa@samsung.com>,
	Rajeshwari S Shinde <rajeshwari.s@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	linux-spi@vger.kernel.org, Simon Glass <sjg@chromium.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Doug Anderson <dianders@google.com>,
	Andrzej Hajda <a.hajda@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Lukasz Czerwinski <l.czerwinski@samsung.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20131108110517.GK2493@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Friday 08 of November 2013 11:05:17 Mark Brown wrote:
> On Thu, Nov 07, 2013 at 10:39:37AM +0100, Tomasz Figa wrote:
> > On Thursday 07 of November 2013 14:52:36 Rajeshwari Birje wrote:
> 
> > > The reordering of the words is taken care by the Swap configuration
> > > (swap_cfg) register, which I have set for both 16 and 32 bits_per_word
> > > case. I have tested this patch and works fine for me and also has
> > > improved the timing performance.
> 
> > This driver seems to have already worked fine with 32 bits per word,
> > using the s5c73m3 camera sensor, which uses SPI for firmware upload.
> 
> This is all sounding very confused.  Either this patch is a bug fix or
> it's breaking the driver but I can't tell without more information about
> what it's supposed to do.  Can someone explain in concrete terms what
> the intended effect of the patch is on wire behaviour?
> 
> It is possible that the s5c73m3 driver is buggy here if it's only been
> tested with the s3c64xx driver (which seems likely) since the author
> could have worked around the driver behaviour.

I'm confused here as well.

Looking at the W25Q32DW datasheet[1], it does not really support 32 bit
words and using such with it seems more like an abuse of this feature.

As for the s5c73m3 sensor, we should ask Andrzej or Sylwester to look
at the datasheet and see how SPI transfer are supposed to work there.

[1] http://www.winbond.com.tw/NR/rdonlyres/D35D5D04-4CE9-46A1-8950-AEA573045507/0/W25Q32DW.pdf

Best regards,
Tomasz
