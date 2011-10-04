From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/5 v2] spi-topcliff-pch: add tx-memory clear after
 complete transmitting
Date: Tue, 4 Oct 2011 10:15:19 -0600
Message-ID: <20111004161519.GA10840@ponder.secretlab.ca>
References: <1315296998-7296-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, qi.wang@intel.com,
	yong.y.wang@intel.com, joel.clark@intel.com,
	kok.howg.ewe@intel.com, toshiharu-linux@dsn.okisemi.com
To: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1315296998-7296-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Sep 06, 2011 at 05:16:34PM +0900, Tomoya MORINAGA wrote:
> Currently, in case of reading date from SPI flash,
> command is sent twice.
> The cause is that tx-memory clear processing is missing .
> This patch adds the tx-momory clear processing.
> 
> Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
> ---
> v2: v1 patch series are included invalid patch file

Merged all 5 patches, thanks.

g.
