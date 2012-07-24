From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 09/10 RESEND] spi: Add SSP/SPI device tree documentation
Date: Tue, 24 Jul 2012 22:15:39 +0400
Message-ID: <500EE64B.8080103@mvista.com>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
 <1343076052-27312-10-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Chris Ball <cjb@laptop.org>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Attila Kinali <attila@kinali.ch>, Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net, Shawn Guo <shawn.guo@linaro.org>,
 Dong Aisheng <b29396@freescale.com>,
 Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
To: Marek Vasut <marex@denx.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1343076052-27312-10-git-send-email-marex@denx.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hello.

On 07/24/2012 12:40 AM, Marek Vasut wrote:

> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Attila Kinali <attila@kinali.ch>
> Cc: Chris Ball <cjb@laptop.org>
> CC: Dong Aisheng <b29396@freescale.com>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> ---
>  Documentation/devicetree/bindings/spi/mxs-spi.txt |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/mxs-spi.txt

> diff --git a/Documentation/devicetree/bindings/spi/mxs-spi.txt b/Documentation/devicetree/bindings/spi/mxs-spi.txt
> new file mode 100644
> index 0000000..f1263a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/mxs-spi.txt
> @@ -0,0 +1,18 @@
> +* Freescale MX233/MX28 SSP/SPI
> +
> +Required properties:
> +- compatible: Should be "fsl,<soc>-spi", where soc is "imx23" or "imx28"
> +- reg: Offset and length of the register set for the device
> +- interrupts: Should contain SSP interrupts (error irq first, dma irq second)
> +- fsl,ssp-dma-channel: APBX DMA channel for the SSP
> +
> +Example:
> +
> +ssp0: ssp@80010000 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	compatible = "fsl,imx28-spi";
> +	reg = <0x80010000 2000>;

   Not 0x2000?

WBR, Sergei
