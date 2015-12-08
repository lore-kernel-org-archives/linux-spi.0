From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v2 1/8] spi: lm70llp: remove multiple blank lines
Date: Tue, 8 Dec 2015 10:03:00 +0530
Message-ID: <20151208043259.GA23610@sudip-pc>
References: <1449485255-1103-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20151207200737.GN5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151207200737.GN5727@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 07, 2015 at 08:07:37PM +0000, Mark Brown wrote:
> On Mon, Dec 07, 2015 at 04:17:28PM +0530, Sudip Mukherjee wrote:
> > checkpatch complains about multiple blank lines.
> 
> Please don't resubmit already applied patches, please submit against the
> latest development code for the subsystem you're submitting to (unless
> the change is a bug fix that should go to Linus).

I think there is some confusion. I am not seeing v1 of these patches in
for-next branch of your spi tree. And in review of v1 you said to use
dev_*. And for that last 2 patch of v1 changed and one extra came so I
sent the whole series as v2.

regards
sudip
