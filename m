From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] [RFC] spi: pxa2xx: Do cs if restart the SSP during
 pxa2xx_spi_transfer_one()
Date: Tue, 19 Mar 2019 17:27:43 +0200
Message-ID: <6013a37a-ee24-e371-773c-141a54926239@linux.intel.com>
References: <20190307072424.18820-1-jin.xiao@intel.com>
 <cf5b89b6-e081-5ba2-2837-7d3cfde779ae@linux.intel.com>
 <20190307160924.GE6529@sirena.org.uk>
 <11f165e9-ef53-edb9-cec2-e30ad2b440b5@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanmin.zhang@intel.com, bo.he@intel.com
To: "Xiao, Jin" <jin.xiao@intel.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11f165e9-ef53-edb9-cec2-e30ad2b440b5@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Jin

On 3/8/19 9:28 AM, Xiao, Jin wrote:
> 
> Yes, the spi core has de-asserted the CS before the 
> pxa2xx_spi_unprepare_transfer(). The problem on my side is that the new 
> transfer will restart the SSP in pxa2xx_spi_transfer_one(). The spi core 
> has asserted the CS again before restart the SSP.  In my test the CS 
> assert before the restart SSP can't ensure the spi transfer working 
> correctly.
> 
I wanted to ask have you found any other fix or reason than the patches 
you have sent?

I've been trying to debug why the commit d5898e19c0d7 ("spi: pxa2xx: Use 
core message processing loop") is causing the regression you are seeing.

I've been testing this by sending two or more messages each consisting 
of two 4-byte transfers through the spidev. SPI mode 3 and clock is 1 
MHz. I see only slight timing difference between a commit before and at 
d5898e19c0d7 when the chip select is active.

8ae55af38817: CS act to CLK running ~40 us. CLK idle to CS deact ~26 us
d5898e19c0d7: CS act to CLK running ~34 us. CLK idle to CS deact ~18 us

There is more difference/variability during the times when the CS is not 
active between messages. Which is understandable since there happens 
message passing from userspace, queing, etc.

At 8ae55af38817 total time over 2 messages varies from ~600 us to 1200 
~us and at d5898e19c0d7 from ~500 us to 1100 us. Then at v4.19 it goes a 
bit slover and varies between ~700 to 1600 us. Most probably due some 
other change than in SPI subsystem as there is not commit either in SPI 
core or spi-pxa2xx explaining it. Or just some random config change in 
my kernel configuration between 4.17 and 4.19.

What I don't understand why additional CS toggling makes it work for you 
in case SSP was stopped in pxa2xx_spi_unprepare_transfer() and restarted 
again in pxa2xx_spi_transfer_one(). This SSP stopping and restarting is 
not visible in the SPI signals since clock is already stopped when FIFO 
gets empty.

I guess the reason why you are seeing pxa2xx_spi_unprepare_transfer() 
only called sometimes is that in those cases where it is not called a 
new SPI message got queued while processing the current one and in other 
cases queue became empty before new message was queued.

In both cases there shouldn't be difference in CS handling. Which makes 
me scratching my head why additional CS toggling is fixing the issue in 
case there is SSP restart. And which was due more time elapsed between 
messages and queue went empty.

-- 
Jarkko
