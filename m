From: Harini Katakam <harinikatakamlinux@gmail.com>
Subject: Re: [PATCH v3 1/2] SPI: Add driver for Cadence SPI controller
Date: Mon, 14 Apr 2014 14:41:59 +0530
Message-ID: <CAFcVECLEzheDMPZ=3wjDCyD00qBtbYps6OgYzeLMcEzAPijZvQ@mail.gmail.com>
References: <1397132030-2440-1-git-send-email-harinik@xilinx.com>
	<20140410224825.GI6518@sirena.org.uk>
	<CAFcVECL7fSn6S53712ZfaezVxfCbeT15Wbk432k61KuQOL4PdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, linux-spi@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	michals@xilinx.com
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAFcVECL7fSn6S53712ZfaezVxfCbeT15Wbk432k61KuQOL4PdQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Fri, Apr 11, 2014 at 9:06 AM, Harini Katakam
<harinikatakamlinux@gmail.com> wrote:
> Hi Mark,
>
> On Fri, Apr 11, 2014 at 4:18 AM, Mark Brown <broonie@kernel.org> wrote:
>> On Thu, Apr 10, 2014 at 05:43:49PM +0530, Harini Katakam wrote:
>>> Add driver for Cadence SPI controller. This is used in Xilinx Zynq.
>>
>> This looks mostly good, the issues below are very small.
>>
>>> +static int __maybe_unused cdns_spi_suspend(struct device *dev)
>>> +{
>>> +     struct platform_device *pdev = container_of(dev,
>>> +                     struct platform_device, dev);
>>> +     struct spi_master *master = platform_get_drvdata(pdev);
>>> +     struct cdns_spi *xspi = spi_master_get_devdata(master);
>>> +
>>> +     spi_master_suspend(master);
>>> +
>>> +     clk_disable(xspi->ref_clk);
>>> +
>>> +     clk_disable(xspi->pclk);
>>
>> You're only doing clk_disable() here, I would expect the clocks to also
>> be unprepared over suspend - there is no value in leaving them prepared
>> that I can see.  Just use clk_unprepare_disable().
>>
>> It would also be good (though not essential) to implement runtime PM and
>> disable the clocks while there are no transfers in progress for a small
>> power saving.  The auto_runtime_pm feature in the core will do the
>> runtime PM calls for you.
>>
>> Otherwise this looks good.
>
> Thanks. I'll make these changes and send a v4 next week.
>

This driver without runtime PM will suffice our current requirements.
Disabling the clocks will offer some small power savings as you pointed out and
I will revisit this at a later time as an enhancement.

I have addressed the other review comment and sent out a v4.

Regards,
Harini
