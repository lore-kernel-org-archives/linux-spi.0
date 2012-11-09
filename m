From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] spi: tegra: sequence compatible strings as per preference
Date: Fri, 09 Nov 2012 10:04:56 -0700
Message-ID: <509D37B8.8020606@wwwdotorg.org>
References: <1352452052-13823-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"broonie@opensource.wolfsonmicro.com"
	<broonie@opensource.wolfsonmicro.com>,
	Stephen Warren <swarren@nvidia.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352452052-13823-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 11/09/2012 02:07 AM, Laxman Dewangan wrote:
> Sequence compatible list for tegra20-slink driver to first
> look for Tegra30 and then Tegra20. Tegra30 have additional
> feature in HW which need to be utilize if it is provided from DT.

I don't object to this patch.

However just FYI, it should not be necessary for correctness; The DT
matching order is supposed to be driven purely by the order of the
compatible values in the DT now, and not affected by the order of values
in the table. (This wasn't always the case, but was a bug that was fixed
IIRC by Thierry Reding).
