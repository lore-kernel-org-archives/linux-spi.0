From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/1] Adding intel_mid_ssp_spi driver : 01/27/2011
Date: Sat, 12 Feb 2011 02:19:13 -0700
Message-ID: <20110212091913.GD17755@angua.secretlab.ca>
References: <1296680512-2758-1-git-send-email-russ.gorby@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	"open list:SPI SUBSYSTEM" <spi-devel-general@lists.sourceforge.net>,
	open list <linux-kernel@vger.kernel.org>
To: Russ Gorby <russ.gorby@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1296680512-2758-1-git-send-email-russ.gorby@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 02, 2011 at 01:01:51PM -0800, Russ Gorby wrote:
> Hello SPI maintainers,
> I am sending a patch for the (new) intel_mid_ssp_spi driver for
> consideration for inclusion in the Linux Kernel. This is a SPI master
> controller driver that is being used for the intel MID platform (Medfield).
> It uses the on-board Bulverde SSP controller configured for SPI (spibus #3)
> running at 25Mhz.

Hi Russ,

Just for future reference, when you're only sending one patch, please
put your notes into the patch description itself, or immediately after
the --- line.  No need for a cover letter like this one.

Thanks,
g.
