From: Rajeshwari Birje <rajeshwari.birje@gmail.com>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Wed, 6 Nov 2013 10:23:07 +0530
Message-ID: <CAPs=JDcHVe4q7R-3f3SBu8g=Ebkz57AbPN8e2jspVTGYnZ1vqA@mail.gmail.com>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com>
	<6043727.WVyVGYjJys@amdc1227>
	<CAPs=JDcVXpJJnWxRFpq7aoW98LKmHq0jo-oTVqSUasnO_1My3g@mail.gmail.com>
	<1586287.qm633XfQbK@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie@kernel.org>,
	Rajeshwari S Shinde <rajeshwari.s@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	linux-spi@vger.kernel.org, Simon Glass <sjg@chromium.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Doug Anderson <dianders@google.com>
To: Tomasz Figa <t.figa@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1586287.qm633XfQbK@amdc1227>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Tomasz,

On Thu, Oct 31, 2013 at 6:07 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Rajeshwari,
>
> On Thursday 31 of October 2013 16:17:15 Rajeshwari Birje wrote:
>> Hi Mark Brown ,
>>
>> On Wed, Oct 30, 2013 at 10:36 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>> > On Wednesday 30 of October 2013 10:00:29 Mark Brown wrote:
>> >> On Wed, Oct 30, 2013 at 11:52:54AM +0530, Rajeshwari Birje wrote:
>> >>
>> >> > The following patch already sets bits_per_word_mask for
>> >> > drivers/spi/spi-s3c64xx.c in s3c64xx_spi_probe, hence I had a doubt do
>> >> > I need to set the same again.
>> >>
>> >> OK, so how did this work before then?  You're just adding new code but
>> >> the driver was previously claiming to support different bits per word
>> >> (and now I look at the code there is some handling for that in code).
>> >> Is this a bug fix?
>> No idea if it worked before, but now if I try to do 16 bit transfer
>> without my patch, I get following error.
>> "Xfer length(1) not a multiple of word size(2)"
>> I guess we can consider this as a bug fix then for word transfer.
>> >
>> > That's a good question. Rajeshwari, what SPI device did you test this
>> > patch with? Does it have a driver in mainline kernel?
>> @Tomasz: I tested it for W25Q32DW Winbond device which is already has
>> a driver in mainline Kernel
>
> The driver as of today's linux-next does not seem to support word
> transfers. Do you have some additional, out of tree patches that add
> such support?
Yes I set the bits_per_word to 32/16 in drivers/mtd/devices/m25p80.c
m25p_probe function and the call spi_setup(spi).
> Best regards,
> Tomasz
>
-- 
Regards,
Rajeshwari Shinde
