From: Ben Gardiner <ben.l.gardiner@gmail.com>
Subject: Re: [PATCH] spi: spi-davinci: deassert CS on setup()
Date: Thu, 12 Sep 2013 09:01:48 -0400
Message-ID: <CA+5vRUXL6HR5NNopxWb7XP9PFg49t8yXOJdg4f3epVqmWKyDbQ@mail.gmail.com>
References: <1378833022-31046-1-git-send-email-ben.l.gardiner@gmail.com>
	<CA+7tXih464v2xwf41rLzG5_mSFG2x7-2Wgde=g-y7d56g_2HeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Grant Likely <grant.likely@secretlab.ca>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	davinci-linux-open-source@linux.davincidsp.com,
	linux-kernel@vger.kernel.org
To: Trent Piepho <tpiepho@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+7tXih464v2xwf41rLzG5_mSFG2x7-2Wgde=g-y7d56g_2HeA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Trent,

Thanks for the quick review.

On Tue, Sep 10, 2013 at 10:44 PM, Trent Piepho <tpiepho@gmail.com> wrote:
>
> It is supposed to be possible to call setup() on one slave while
> transfers on another slave attached to the same master are in
> progress.
>
> A cursory look at the code makes it seem that all the CS control bits
> share SPIDAT1?  Will writing to SPIDAT1 in davinci_spi_chipselect()
> cause a race if another chipselect is being used?

Good point. I think you're right there could be a race.

I tested with multiple slaves and hammered the bus with concurrent
accesses; but that doesn't mean that there _isn't_ still a race.

Can you recommend an existing implementation in-tree upon which I can
base a new patch to add concurrency protection to SPIDAT1 accesses?
