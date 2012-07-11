From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v5 5/6] spi: s3c64xx: Remove the 'set_level' callback from
 controller data
Date: Wed, 11 Jul 2012 17:51:13 +0530
Message-ID: <CAJuYYwR8o76aLr_2J4jqF93hhz_4L3MJikJUtTpG5jWfPKDk+w@mail.gmail.com>
References: <CAJuYYwSi-1nBM40SWt359W0Lr2n_yVX5tvWfOS77bmLQRt_9fw@mail.gmail.com>
	<1342005359-748-1-git-send-email-thomas.abraham@linaro.org>
	<20120711114716.GF3938@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, kgene.kim@samsung.com,
	jaswinder.singh@linaro.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120711114716.GF3938@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 11 July 2012 17:17, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jul 11, 2012 at 04:45:59PM +0530, Thomas Abraham wrote:
>> The set_level callback in the controller data, which is used to configure
>> the slave select line, cannot be supported when migrating the driver to
>> device tree based discovery. Since all the platforms currently use gpio
>> as the slave select line, this callback can be removed from the
>> controller data and replaced with call to gpio_set_value in the driver.
>
> I don't seem to have patches 1-4?

Based on your comments to add the gpio request, only two patches 5/6
and 6/6 in this series have changed since. I have cc'ed you in the
other 4 patches as well. If you do not have those patches, please let
me know, I will repost the whole series again. Thanks.
