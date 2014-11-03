From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC 0/2] drivers: spi/i2c: account completions as iowait
Date: Mon, 3 Nov 2014 13:02:22 +0000
Message-ID: <20141103130222.1c53fa39@alan.etchedpixels.co.uk>
References: <1414936689-2707-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Balbir Singh <bsingharora@gmail.com>
To: Wolfram Sang <wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414936689-2707-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun,  2 Nov 2014 14:58:07 +0100
Wolfram Sang <wsa@the-dreams.de> wrote:

> So, I recently learned that there is wait_for_completion_io_* because one I2C
> driver uses it instead of wait_for_completion_*. I want consistency, so
> technically the io-versions seem to be the correct ones to me, because, well,
> we are waiting for IO.
> 
> However, researching the net, users currently interpret iowait entirely as
> blkio wait. Furthermore, io_schedule() calls delayacct_blkio_{start|end}() which
> worked fine for my tests with I2C but might show that iowait was really meant as
> blkiowait? So, should other subsystems use it?

I don't think so. The traditional Unix use of I/O wait is block I/O wait,
in order to account for paging/swapping in "uptime".

The other problem is that if you change the way it behaves you'll get
lots of hate mail from people running server farms as all their load
balancing and cluster management changes behaviour, plus baffled users
wondering why their system is now busy and it wasn't in the last release.

I'm not really sure how it should be accounted - arguably an SPI
transaction to an SD card is I/O wait but one to a display controller on
the same i2c bus is not.

The other question you have to solve is that people are adding i2c and
SPI slave support both in Android space and now perhaps upstream. How do
you I/O account those transactions ?

Alan
