From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v5 0/6] spi: s3c64xx: add support for device tree
Date: Thu, 12 Jul 2012 18:11:05 +0900
Message-ID: <0fae01cd600e$442ed160$cc8c7420$%kim@samsung.com>
References: <1342021265-11212-1-git-send-email-thomas.abraham@linaro.org>
 <20120711174908.GP3938@opensource.wolfsonmicro.com>
 <CAJuYYwQA_x112xqOnQmwZjzoXoR-DAvT8YdB90Wm=78CH72uOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, jaswinder.singh@linaro.org
To: 'Thomas Abraham' <thomas.abraham@linaro.org>,
	'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAJuYYwQA_x112xqOnQmwZjzoXoR-DAvT8YdB90Wm=78CH72uOg@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Thomas Abraham wrote:
> 
> On 11 July 2012 23:19, Mark Brown <broonie@opensource.wolfsonmicro.com>
> wrote:
> > On Wed, Jul 11, 2012 at 09:10:59PM +0530, Thomas Abraham wrote:
> >> Changes since v4:
> >> - Includes the missing gpio request for slave select line gpio as
> suggested
> >>   by Mark Brown.
> >
> > These looked OK (and have had quite a bit of review already so we're
> > probably at the stage where incremental fixes are better anyway) so I
> > tried to apply them but git am was really unhappy.  I tried applying on
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git spi-
> next
> >
> > and -next.  Can you check what's going on here please?
> 
Firstly, this patches look ok to me.

And Mark, this touches various samsung stuff in arch/arm/ so if you're ok,
I'd like to pick this up in samsung tree. We don't want to see conflicts...

> These patches were based on Samsung maintainer's for-next branch with
> Grant's spi/next branch merged. I will check with your spi-next
> branch. Thanks.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
