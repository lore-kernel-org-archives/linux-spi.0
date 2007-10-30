From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 09/14] Blackfin SPI driver: Fix SPI driver to work with SPI flash ST25P16 on bf548
Date: Tue, 30 Oct 2007 13:05:02 -0700
Message-ID: <200710301305.02640.david-b@pacbell.net>
References: <1193735885-8202-1-git-send-email-bryan.wu@analog.com> <1193735885-8202-10-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>
To: Bryan Wu <bryan.wu@analog.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757818AbXJ3UYf@vger.kernel.org>
In-Reply-To: <1193735885-8202-10-git-send-email-bryan.wu@analog.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 30 October 2007, Bryan Wu wrote:
> Current SPI driver enables SPI controller and set the SPI baud register
> for each SPI transfer. But, they should never be changed within a SPI
> message session, in which seveal SPI transfers are pumped.

That's actually not true.  If a driver sets spi_transfer.max_speed_hz
to a nonzero value that's different from the previous bit rate (which
may be spi_device.max_speed_hz), it should be updated before that
transfer segment.  Example, sometimes data can't be clocked out at
the same rate commands can be clocked in.

Similarly with spi_transfer.bits_per_word ... again, it's very possible
that commands and data have different sizes.

Of course, if those values don't change, there'd be no point in
reconfiguring any aspect of those communications parameters...


I'll be forwarding this patch, since this looks like another case
where the main effect of the patch doesn't match its description
and since this patch series has taken too long already.  (Does this
patch even really relate primarily to working with an ST M25P16
flash part??)  Though it'd be reasonable to be more hard-nosed
about this and insist on another go-around for thesse patches.
(Making this the fifth one??)

But I *STRONGLY* suggest someone revisit the issue of whether those
two per-transfer options are now being handled correctly.  As well
as update procedures so that the patch comments start to have a
direct correspondence to what the patches have changed...

- Dave


> This patch 
> move move SPI setting to the begining of a message session. And never
> disables SPI controller until an error occurs.
