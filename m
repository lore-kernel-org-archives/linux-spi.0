From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2] spi: Add driver for the CPLD chip on Mikrotik RB4xx boards
Date: Wed, 25 Mar 2015 23:45:34 +0200
Message-ID: <CAHp75VeGo8MT+p8eSAsZ8s+Re_qyd_v+BfE2yzNhOXsViOT5cA@mail.gmail.com>
References: <1426853793-24454-1-git-send-email-bert@biot.com>
	<1426853793-24454-3-git-send-email-bert@biot.com>
	<20150320132821.GL2869@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bert Vermeulen <bert@biot.com>, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150320132821.GL2869@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Mar 20, 2015 at 3:28 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Mar 20, 2015 at 01:16:33PM +0100, Bert Vermeulen wrote:
>> The CPLD is connected to the NAND flash chip and five LEDs. Access to
>> those devices goes via this driver.
>
> None of this driver looks like a SPI controller - this appears to be a
> MFD so should have a core in drivers/mfd with function drivers for the
> individual features in the relevant subsystem directories.

I can add that even in this case better to use devm_* API, remove
unneded lines an so on. Seems like driver really far from modern
kernel API (2010 was written and mostly wasn't changed?).

-- 
With Best Regards,
Andy Shevchenko
