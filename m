From: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1 14/15] ARM: dts: imx6sll: correct ecspi/sdma compatible
Date: Wed, 24 Apr 2019 08:37:45 +0200
Message-ID: <20190424063745.b67kcb3zzifuf22b@pengutronix.de>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
 <1556027045-5269-15-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "plyatov@gmail.com" <plyatov@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Robin Gong <yibin.gong@nxp.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1556027045-5269-15-git-send-email-yibin.gong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Tue, Apr 23, 2019 at 01:51:45PM +0000, Robin Gong wrote:
> Correct ecspi/sdma compatible since ecspi errata ERR009165
> not fixed on i.mx6sll chip.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sll.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
> index 1b4899f..03f2103 100644
> --- a/arch/arm/boot/dts/imx6sll.dtsi
> +++ b/arch/arm/boot/dts/imx6sll.dtsi
> @@ -183,7 +183,7 @@
>  				};
>  
>  				ecspi1: spi@2008000 {
> -					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
> +					compatible ="fsl,imx51-ecspi";

Where is the fsl,imx6sll-ecspi compatible that would have prevented us
from changing this devicetree now? You should at least add it now.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
