From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Handling clocks on external busses
Date: Tue, 24 Nov 2015 17:37:18 +0000
Message-ID: <20151124173718.GK18889@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-i2c@vger.kernel.org>, <linux-spi@vger.kernel.org>
To: <linux-clk@vger.kernel.org>
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

When a clock driver is controlling a clock that is controlled
over I2C / SPI, we need to perform a write on that bus to enable
the clock. However, such busses often have their own clocks that
must be enabled. Since all clock prepares are controlled under
one large mutex this easily causes deadlock. The device is
waiting for the I2C / SPI write to complete and the I2C / SPI
driver is waiting for the clock prepare lock to be released so it
can enable its own clock.

I have had a bit of a search and it seems the only really advice
kicking about is that all I2C / SPI drivers should leave the
clock prepared all the time. Is that intended to be the long term
solution, should I treat not leaving the clock prepared as a bug?

Thanks,
Charles
