From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 0/1] spi: Add driver for Routerboard RB4xx boards
Date: Tue, 31 Mar 2015 16:22:47 +0200
Message-ID: <20150331142247.GG28951@linux-mips.org>
References: <1427739857-13395-1-git-send-email-bert@biot.com>
 <20150331084425.GI2869@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Vermeulen <bert@biot.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        andy.shevchenko@gmail.com
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20150331084425.GI2869@sirena.org.uk>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Id: linux-spi.vger.kernel.org

On Tue, Mar 31, 2015 at 09:44:25AM +0100, Mark Brown wrote:

> On Mon, Mar 30, 2015 at 08:24:16PM +0200, Bert Vermeulen wrote:
> > Changes in v2:
> > This is a near complete rewrite of the original OpenWrt driver. All comments
> > were taken into account, and the spi_transfer.fast_write flag is gone.
> > Instead, the cs_change flag is used. It's not too bad a hack, as it really
> > does use CS.
> 
> Don't send cover letters for single patches, if there's anything that
> needs saying it should either be in the changelog or after the ---.  A
> separate cover letter adds to the mail volume and probably means that
> the patch itself is inadequately described.

My personal grief with cover letters is that patchwork only collects
patches but cover letters themselves aren't patches.  Which means working
through patchwork I might miss important information.  Maybe I should
request an enhancement to patchwork.

  Ralf
