From: Neil Armstrong <narmstrong@baylibre.com>
Subject: McSPI hangs with cs_change after "Switch driver to use transfer_one"
 change
Date: Thu, 8 Oct 2015 14:54:50 +0100
Message-ID: <561675AA.4010505@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael Welling <mwelling@ieee.org>,
	Fionn Cleary <clearyf@tcd.ie>,
	Wolfram Sang <wsa@the-dreams.de>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi All,

I'm in a use case where I use cs_change on McSPI channel 3 on a single transfer Full-Duplex message, then I transfer a single full duplex message without cs_change on channel 1.

Here is a better representation :
-- 1 transfer message cs_change=1
cs3 : set_cs(0)
cs3 : full-duplex transfer
cs3 : transfer ok
-- 1 transfer message cs_change=1
cs3 : set_cs(0)
cs3 : full-duplex transfer
cs3 : transfer ok
...
-- 1 transfer message cs_change=1
cs3 : set_cs(0)
cs3 : full-duplex transfer
cs3 : transfer ok
-- 1 transfer message cs_change=1
cs1 : set_cs(0)
cs1 : full-duplex transfer
cs1 : RXS timed out
cs1 : set_cs(1)

Then "RXS timed out" on each non-cs3 transfers.

The previous behavior of cs_change was :
- between transfers, unassert CS and re-assert-it for the following transfer
- between messages, unassert CS

The new behaviour inherited from the SPI core spi_transfer_one_message function :
- between transfers, unassert CS and re-assert-it for the following transfer
- between messages, leave CS asserted

We tried disabling the DMA, and the FIFO, but the behavior was actually the same, only reverting back before the "Switch driver to use transfer_one" fixed the issue.

Then actually disabling the cs_change corrected the issue. It may be why the original driver ignored the "leave it on after last xfer" hint.

The problem is : how can we disable this hint since it is managed in SPI core spi_transfer_one_message ?

A solution will be to track down the current asserted CS and unassert it them when the active channel changes.

Neil
