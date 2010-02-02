From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [GIT PULL] sh updates for 2.6.33-rc7
Date: Tue, 2 Feb 2010 17:21:44 +0900
Message-ID: <20100202082144.GB5716@linux-sh.org>
References: <20100202040628.GH13428@linux-sh.org> <fa686aa41002020017m5ea0020di6924905a631dc7d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fa686aa41002020017m5ea0020di6924905a631dc7d6@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 02, 2010 at 01:17:49AM -0700, Grant Likely wrote:
> On Mon, Feb 1, 2010 at 9:06 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > Please pull from:
> >
> > ? ? ? ?master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.33
> >
> > Which contains:
> >
> > Magnus Damm (1):
> > ? ? ?usb: r8a66597-hdc disable interrupts fix
> >
> > Marek Skuczynski (2):
> > ? ? ?sh: Fix access to released memory in dwarf_unwinder_cleanup()
> > ? ? ?sh: Fix access to released memory in clk_debugfs_register_one()
> >
> > Markus Pietrek (1):
> > ? ? ?spi: spi_sh_msiof: Fixed data sampling on the correct edge
> 
> Hold the phone; please coordinate with me before picking up SPI
> patches into your tree.  I don't mind arch specific spi changes going
> in via a different tree, but I'd like to know about it before I waste
> time farting around with the same patch (like I did with this one
> tonight, and only found out that you also picked it up when I came
> across this pull request by chance).
> 
If there's someone actively looking after the SPI stuff then that's fine.
I didn't bother bouncing this one off of the SPI list since it's a
hardware-specific correctness fix and has no dependency on anything
subsystem related.
