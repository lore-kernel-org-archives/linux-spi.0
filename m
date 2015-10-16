From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] spi: Setup the master controller driver before setting
 the chipselect
Date: Fri, 16 Oct 2015 18:55:21 +0300
Message-ID: <CAHp75VchYayRsvsjPoM9YphcjMajfvYuDrLcLrTiADVn8LU=8A@mail.gmail.com>
References: <1445009343-28307-1-git-send-email-fcooper@ti.com>
	<CAHp75VdexZWSEEM8xjYEx9WU4dbrNrXeczvBpyKcRKn-qMN=-g@mail.gmail.com>
	<56211C0F.4090102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Sekhar Nori <nsekhar@ti.com>, ssantosh@kernel.org,
	"Ivan T. Ivanov" <iivanov@mm-sol.com>, m-karicheri2@ti.com,
	"Ivan T. Ivanov" <iivanov.xz@gmail.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	hkallweit1@gmail.com
To: "Franklin S Cooper Jr." <fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56211C0F.4090102@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 16, 2015 at 6:47 PM, Franklin S Cooper Jr. <fcooper@ti.com> wrote:
>
>
> On 10/16/2015 10:45 AM, Andy Shevchenko wrote:
>> On Fri, Oct 16, 2015 at 6:29 PM, Franklin S Cooper Jr <fcooper@ti.com> wrote:
>>> SPI controllers may need to be properly setup before chip selects
>>> can be used. Therefore, wait until the spi controller has a chance
>>> to perform their setup procedure before trying to use the chip
>>> select.
>>>
>>> This also insures that the chip selects pins are in a good
>>> state before asseting them which otherwise may cause confusion.
>>>
>>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> Does it mean I have to test it again?
> Oops sorry. No the patch hasn't changed. I can shoot a v3 with your tested by included.

Whatever Mark prefers.


-- 
With Best Regards,
Andy Shevchenko
