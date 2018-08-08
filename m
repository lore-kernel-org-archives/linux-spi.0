From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 2/2] spi: sprd: Add SPI driver for Spreadtrum SC9860
Date: Wed, 8 Aug 2018 10:45:33 +0800
Message-ID: <CAMz4kuL2=7mNHLoTg7hjA4NjfGgNQ-mBJBSE8uMb0oqwnU1=Yg@mail.gmail.com>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <99befd2badc4dffb59662fca1e11d79f18b64755.1533638405.git.baolin.wang@linaro.org>
 <20180807142408.GB7958@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        lanqing.liu@spreadtrum.com, linux-spi@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180807142408.GB7958@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On 7 August 2018 at 22:24, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 07, 2018 at 06:43:38PM +0800, Baolin Wang wrote:
>> From: Lanqing Liu <lanqing.liu@spreadtrum.com>
>>
>> This patch adds the SPI controller driver for Spreadtrum SC9860 platform.
>
> This all looks pretty clean, a few comments below but nothing too major:
>
>> +static void sprd_spi_chipselect(struct spi_device *sdev, bool cs)
>> +{
>> +     struct spi_controller *sctlr = sdev->controller;
>> +     struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
>> +     u32 val;
>> +     int ret;
>> +
>> +     ret = pm_runtime_get_sync(ss->dev);
>> +     if (ret < 0) {
>> +             dev_err(ss->dev, "failed to resume SPI controller\n");
>> +             return;
>> +     }
>
> Something else further up the stack should probably have runtime PM
> enabled already - we should only be changing chip select as part of a
> bigger operation.  If you use the core auto_runtime_pm feature this will
> definitely happen.

Indeed, will use auto_runtime_pm.

>
>> +     bits_per_word = bits_per_word > 16 ? round_up(bits_per_word, 16) :
>> +             round_up(bits_per_word, 8);
>
> Please

Sorry I did not get your points here, could you elaborate on?

>
>> +     switch (bits_per_word) {
>> +     case 8:
>> +     case 16:
>> +     case 32:
>
> It'd be nice to have a default case, the core should check for you but
> it's nice to have defensive programming here.

Sure.

>
>> +static int sprd_spi_transfer_one(struct spi_controller *sctlr,
>> +                              struct spi_device *sdev,
>> +                              struct spi_transfer *t)
>> +{
>> +     struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
>> +     int ret;
>> +
>> +     ret = pm_runtime_get_sync(ss->dev);
>> +     if (ret < 0) {
>> +             dev_err(ss->dev, "failed to resume SPI controller\n");
>> +             goto rpm_err;
>> +     }
>
> Same thing with runtime PM here - the core can do this for you.

Yes.

>
>> +static int sprd_spi_setup(struct spi_device *spi_dev)
>> +{
>> +     struct spi_controller *sctlr = spi_dev->controller;
>> +     struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
>> +     int ret;
>> +
>> +     ret = pm_runtime_get_sync(ss->dev);
>> +     if (ret < 0) {
>> +             dev_err(ss->dev, "failed to resume SPI controller\n");
>> +             return ret;
>> +     }
>> +
>> +     ss->hw_mode = spi_dev->mode;
>> +     sprd_spi_init_hw(ss);
>
> This can be called for one chip select while another is in progress so
> it's not good to actually configure the hardware here unless the
> configuration is in a chip select specific set of registers.  Instead
> you should defer to when the transfer is being set up.

You are right, will move these into transfer setup.

>
>> +static int sprd_spi_clk_init(struct platform_device *pdev, struct sprd_spi *ss)
>> +{
>> +     struct clk *clk_spi, *clk_parent;
>> +
>> +     clk_spi = devm_clk_get(&pdev->dev, "spi");
>> +     if (IS_ERR(clk_spi)) {
>> +             dev_warn(&pdev->dev, "can't get the spi clock\n");
>> +             clk_spi = NULL;
>> +     }
>
> I suspect some of these clocks are essential and you should probably
> return an error if you can't get them (especially if probe deferral
> becomes a factor).

The 'spi' and 'source' clock can be optional, and the SPI can work at
default source clock without setting 'spi' and 'source' clock. This is
used on our FPGA board which has not set the spi source clock, but
still make the SPI can work. So here we just give a warning.

>> +     if (!clk_set_parent(clk_spi, clk_parent))
>> +             ss->src_clk = clk_get_rate(clk_spi);
>> +     else
>> +             ss->src_clk = SPRD_SPI_DEFAULT_SOURCE;
>
> Are upstream DTs going to be missing the clock setup needed here?

Right. DTs can not set 'spi' and 'source' clock to make SPI work at
default clock. Thanks for your useful comments.

-- 
Baolin Wang
Best Regards
