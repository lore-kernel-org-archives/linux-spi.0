From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v5 0/6] spi: s3c64xx: add support for device tree
Date: Thu, 12 Jul 2012 19:13:37 +0530
Message-ID: <CAJuYYwS59yoRnyFOR4_M5ymAS5uh0fN5zS=x2CS5Ax-795awBA@mail.gmail.com>
References: <1342021265-11212-1-git-send-email-thomas.abraham@linaro.org>
	<20120711174908.GP3938@opensource.wolfsonmicro.com>
	<CAJuYYwQA_x112xqOnQmwZjzoXoR-DAvT8YdB90Wm=78CH72uOg@mail.gmail.com>
	<0fae01cd600e$442ed160$cc8c7420$%kim@samsung.com>
	<20120712130234.GE3957@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kukjin Kim <kgene.kim@samsung.com>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, jaswinder.singh@linaro.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120712130234.GE3957@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12 July 2012 18:32, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Jul 12, 2012 at 06:11:05PM +0900, Kukjin Kim wrote:
>
>> And Mark, this touches various samsung stuff in arch/arm/ so if you're ok,
>> I'd like to pick this up in samsung tree. We don't want to see conflicts...
>
> Well, simple conflicts aren't that big a deal...  However, Thomas
> mentioned that in order to test this he merged the SPI tree into your
> tree so perhaps there is also a dependency on the SPI tree?  If that was
> just for good practice testing then I agree that the best thing is to
> merge via your tree, otherwise we might need to think harder.

There were no dependency on Grant's spi/next branch. It was merged
just to ensure that nothing is broken.
