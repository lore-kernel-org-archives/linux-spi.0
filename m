From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v5 13/15] ARM: dts: imx6sll: correct sdma compatible
Date: Wed, 17 Jul 2019 14:42:28 +0800
Message-ID: <20190717064226.GB3738@dragon>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
 <20190610081753.11422-14-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, broonie@kernel.org, festevam@gmail.com,
        vkoul@kernel.org, dan.j.williams@intel.com,
        u.kleine-koenig@pengutronix.de, catalin.marinas@arm.com,
        l.stach@pengutronix.de, will.deacon@arm.com,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
To: yibin.gong@nxp.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190610081753.11422-14-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jun 10, 2019 at 04:17:51PM +0800, yibin.gong@nxp.com wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> Correct sdma compatible since ecspi errata ERR009165 has been fixed
> on i.mx6sll as i.mx6ul.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Applied, thanks.
